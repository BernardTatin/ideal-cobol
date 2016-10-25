#!/bin/bash

ici=$(dirname $0)
source ${ici}/shlib.sh

dohelp() {
	cat << DOHELP
$script [-h|--help] : this text
$script main.CBL [ f1.CBL [ f2.CBL ...]]
DOHELP
	exit 0
}

erase_residues() {
	rm -fv $1.MLC $1.390 $1.BAL $1.LOG $1.ERR $1.LST $1.OBJ $1.PRN $1.STA $1.TR*
	rm -fv $1.cpp $1.java $1.class
}

cobol2asm() {
	local src=$1

	echo '=================================================='
	echo "cobol2asm $src"
	erase_residues $src
	${ici}/zc390.sh $src 'SYSCPY(+zcobol+zcobol\z390)' || \
		onerror 2 "$src: see errors on mz390 generated bal file and console"

	${ici}/mz390.sh $src '@zcobol\z390\ZC390CLG' || \
		onerror 3 "$src: see errors on mz390 generated bal file and console"
}

[[ $# -eq 0 ]] && dohelp
case $1 in
	-h|--help)
		dohelp
		;;
esac

main_file=$1
shift
objs=
_sysobj='+zcobol/z390'
while [[ $# -ne 0 ]]
do
	objs="$objs $1"
	d=$(dirname $1)
	echo $_sysobj | grep $d &> /dev/null || _sysobj="$_sysobj+$d"
	cobol2asm $1
	shift
done

cobol2asm $main_file

echo '=================================================='
sysobj=$(echo $_sysobj | tr '/' '\\')
echo "SYSOBJ ($sysobj)"
${ici}/lz390.sh $main_file "SYSOBJ($sysobj)" || \
	onerror 4 "see errors on lz390 generated lst file and console"

