#!/bin/sh

. ~/bin/cobol.env.sh

cd $(dirname $0)
ici=$(pwd)
tmpdir=$(dirname ${ici})/tmpdir
mkdir -p ${tmpdir}
cd ${tmpdir}

date -R
echo
echo ">>> Compile and run with RainCode Cobol"
cobrc :StrictIBM=TRUE ../DATETIME.CBL \
  || { echo "cobrc failed"; exit 1; }
echo '...'
rclrun DATETIME.dll
echo
echo ">>> Compile and run with GNU Cobol"
cobc -std=ibm-strict -Wcolumn-overflow -Wall -Wterminator -W -fixed -x -o DATETIME.EXE ../DATETIME.CBL \
  || { echo "cobc failed"; exit 1; }
echo '...'
./DATETIME.EXE
