#!/bin/bash

ici=$(dirname $0)
source ${ici}/shlib.sh

# exec execute 390 load module
rm -fv $1.log $1.err $1.sta $1.tr*
${ici}/ez390.sh $@ ||
	onerror 1 "see errors on ez390 generated log file and console"
