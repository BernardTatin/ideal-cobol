#!/bin/bash

ici=$(dirname $0)
source ${ici}/shlib.sh

case $with_echo in
	0)
		rm_options='-f'
		;;
	1)
		rm_options='-fv'
		;;
esac

sysobj=
opt_file=zcobol/z390/ZC390CLG.OPT

dohelp() {
	# show help text
	cat << DOHELP
$script [-h|--help] : this text
$script [tron|TRON|troff|TROFF] main.CBL [ f1.CBL [ f2.CBL ...]]

$script transforms each CBL files on the command line in
....... an object file then links all these object files
....... together
DOHELP
	exit 0
}

create_opt_file() {
	cat > ${opt_file} << OPTFILE
sysmac(+zcobol+zcobol\\z390+mac+cics$sysobj)
syscpy(+zcobol+zcobol\\z390+mac+cics$sysobj)
BAL
NOLISTCALL
MAXGBL(1500000) * INCR MAX GBLA/GBLB/GBLC
OPTFILE
}

erase_residues() {
	# erase all compilation residuals
	rm $rm_options $1.MLC $1.390 $1.BAL $1.LOG $1.ERR $1.LST $1.OBJ $1.PRN $1.STA $1.TR*
	rm $rm_options $1.cpp $1.java $1.class
}

cobol2asm() {
	# transfor a CBL file in macro-asm source then in object file
	local src=$1

	echo '=================================================='
	echo "cobol2asm $src"
	# dont't want to use old compilations results
	erase_residues $src
	# from COBOL to Macro ASM
	[[ $with_echo -eq 1 ]] && echo "SYSOBJ ($sysobj)"
	${ici}/zc390.sh $src 'SYSCPY(+zcobol+zcobol\z390$sysobj)' || \
		onerror 2 "$src: see errors on mz390 generated bal file and console"
	# create OPT file
	create_opt_file
	[[ $with_echo -eq 1 ]] && cat ${opt_file}
	# from Macro ASM to OBJ
	${ici}/mz390.sh $src '@zcobol\z390\ZC390CLG' || \
		onerror 3 "$src: see errors on mz390 generated bal file and console"
	rm $rm_options ${opt_file}
}

# ensure we don't need help
[[ $# -eq 0 ]] && dohelp
case $1 in
	-h|--help)
		dohelp
		;;
esac

# get the main file from command line
main_file=$1
shift
# variables initialization
_sysobj=

# compile and compute SYSOBJ
# NOTE: SYSOBJ is a set of directories which contains
# all object files we need for linking
while [[ $# -ne 0 ]]
do
	# get dirname of each files
	d=$(dirname $1)
	# add it only if it is not there
	echo $_sysobj | grep $d &> /dev/null || _sysobj="$_sysobj+$d"
	! [[ -z $_sysobj ]] && sysobj="$(echo $_sysobj | tr '/' '\\')"
	# compile
	cobol2asm $1
	# next file
	shift
done
# compile
cobol2asm $main_file

echo '=================================================='
# then link
[[ $with_echo -eq 1 ]] && echo "SYSOBJ ($sysobj)"
${ici}/lz390.sh $main_file "SYSOBJ(+zcobol\z390$sysobj)" || \
	onerror 4 "see errors on lz390 generated lst file and console"

