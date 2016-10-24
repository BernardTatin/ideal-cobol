#!/bin/bash

ici=$(dirname $0)
source ${ici}/shlib.sh

rm -fv $1.MLC $1.390 $1.BAL $1.LOG $1.ERR $1.LST $1.OBJ $1.PRN $1.STA $1.TR*
rm -fv $1.cpp $1.java $1.class

projectname=$1
! [ -f ${projectname}.CBL ] && onerror 1 "Cannot find source file ${projectname}.CBL"
shift

${ici}/zc390.sh $projectname 'SYSCPY(+zcobol+zcobol\z390)' $@ || \
	onerror 2 "see errors on mz390 generated bal file and console"

${ici}/mz390.sh $projectname '@zcobol\z390\ZC390CLG' $@ || \
	onerror 3 "see errors on mz390 generated bal file and console"

${ici}/lz390.sh $projectname 'SYSOBJ(+zcobol\z390)' $@ || \
	onerror 4 "see errors on lz390 generated lst file and console"

exit 0