#!/bin/bash

script=$(basename $0)
ici=$(dirname $0)

onerror() {
    local exit_code=$1
    local error_msg=$2

    echo "ERROR: $error_msg" 1>&2
    exit $exit_code
}

with_echo=0
case $1 in
	tron|TRON)
		with_echo=1
		shift
		;;
	troff|TROFF)
		with_echo=0
		shift
		;;
esac

# exec execute 390 load module
rm -fv $1.log $1.err $1.sta $1.tr*
${ici}/ez390.sh $@ ||
	onerror 1 "see errors on ez390 generated log file and console"
