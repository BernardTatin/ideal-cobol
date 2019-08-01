#
# common.mk
#

COBOL ?= cobc
RM    = rm -Rfv

STANDARD ?= default
# cobol85

# even if I don't like it, it's hard to work without full path
# and dynamic libs loading.
EXEDIR = $(shell pwd)/bin
LIBDIR = $(shell pwd)/lib
TSTDIR = $(shell pwd)/test

ifeq ($(COBOL),cobc)
WARNS = -Wcolumn-overflow -Wall -Wterminator -W -fixed
DEBUG =
OPTIM =
else ifeq ($(COBOL),cobrc)
WARNS =
DEBUG =
OPTIM =
else
WARNS = -v -P
DEBUG =
OPTIM =
endif


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
	$(COBOL) $(OPTIONS) -std=cobol85 -m -o $@ $<

test: $(TSTDIR) all
	cd $(TSTDIR) && LD_LIBRARY_PATH=$(LIBDIR) $(EXE) $(TESTS_ARGS)

$(EXE): $(MAIN) $(CPYBOOKS)
ifdef _dll
	$(COBOL) -std=$(STANDARD) $(OPTIONS) -x -o $@ $< -L $(LIBDIR) $(addprefix -l ,$(_dll))
else
	$(COBOL) -std=$(STANDARD) $(OPTIONS) -x -o $@ $<
endif

.PHONY: all clean test
