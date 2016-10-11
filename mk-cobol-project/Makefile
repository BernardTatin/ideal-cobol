# ================================================================
# Makefile
# export LD_LIBRARY_PATH=$(pwd)/bin
# ================================================================

APP = cobol-project-maker
MAIN = $(APP).cbl
CPYBOOKS = 
EXE = $(APP).exe
_dll = 

include ../mk/common.mk

test: all
	./$(EXE) o.txt

.PHONY: test
