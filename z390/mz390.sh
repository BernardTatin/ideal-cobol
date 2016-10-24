#!/bin/bash

ici=$(dirname $0)

# execute mz390 runtime with java runtime options:
# 01/15/09 DSH added 150 MB init and max mem for zcobol
# -classpath  path to jar file
# -verbose:gc trace garbage collection to detect memory leaks
# -XmsnK      set initial memory allocation to nK
# -XmxnK      set max     memory allocation to nK
# -Xrs        allow control break interruption of java tasks
java -classpath ${ici}/z390.jar -Xrs -Xms150000K -Xmx150000K $J2SEOPTIONS mz390 $@