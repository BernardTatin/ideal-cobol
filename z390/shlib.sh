#!/bin/sh

script=$(basename $0)

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
