#
# common.mk
#

COBOL ?= cobc
RM    = rm -Rfv

STANDARD ?= default
# cobol85


EXEDIR = $(shell pwd)/bin
LIBDIR = $(shell pwd)/lib
TSTDIR = $(shell pwd)/test

ifeq ($(COBOL),cobc)
WARNS = -Wcolumn-overflow -Wall -Wterminator -W -std=$(STANDARD) -fixed
else
WARNS = -v -P
endif

DEBUG =
OPTIM =

EXE = $(EXEDIR)/$(APP).exe

OPTIONS = $(WARNS) $(DEBUG) $(OPTIM)

_SOBJS = $(addsuffix .so,$(_dll))
SOBJS = $(addprefix $(LIBDIR)/lib,$(_SOBJS))

all: $(EXEDIR) $(LIBDIR) $(SOBJS) $(EXE)

$(EXEDIR):
	@echo "SOBJS : <$(SOBJS)>"
	mkdir -p $@

$(LIBDIR):
	mkdir -p $@

$(TSTDIR):
	mkdir -p $@

clean:
	$(RM) $(EXE) $(SOBJS)

$(LIBDIR)/lib%.so: %.cbl $(CPYBOOKS)
	$(COBOL) $(OPTIONS) -m -o $@ $<

test: $(TSTDIR) all
	cd $(TSTDIR) && LD_LIBRARY_PATH=$(LIBDIR) $(EXE) $(TESTS_ARGS)

$(EXE): $(MAIN) $(CPYBOOKS)
ifdef _dll
	$(COBOL) $(OPTIONS) -x -o $@ $< -L $(LIBDIR) $(addprefix -l ,$(_dll))
else
	$(COBOL) $(OPTIONS) -x -o $@ $<
endif

.PHONY: all clean test
