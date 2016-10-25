#!/bin/bash

ici=$(dirname $0)

# execute lz390 runtime with java runtime options:
# -classpath  path to jar file
# -verbose:gc trace garbage collection to detect memory leaks
# -XmsnK      set initial memory allocation to nK
# -XmxnK      set max     memory allocation to nK
# -Xrs        allow control break interruption of java tasks
java -classpath ${ici}/z390.jar -Xrs $J2SEOPTIONS lz390 $@