#
# common.mk
#

COBOL = /usr/local/bin/cobc
RM    = rm -Rfv

STANDARD ?= default
# cobol85

ODIR = bin

WARNS = -Wcolumn-overflow -Wall -Wterminator -W -std=$(STANDARD)
DEBUG =
OPTIM =

EXE = bin/$(APP).exe

OPTIONS = $(WARNS) $(DEBUG) $(OPTIM)

_SOBJS = $(addsuffix .so,$(notdir $(_dll)))
SOBJS = $(addprefix $(ODIR)/lib, $(_SOBJS))

all: $(ODIR) $(SOBJS) $(EXE)

$(ODIR):
	mkdir -p $@

clean:
	$(RM) $(EXE) $(SOBJS)

bin/lib%.so: %.cbl $(CPYBOOKS)
	$(COBOL) $(OPTIONS) -m -o $@ $<

test: all
	./$(EXE) $(TESTS_ARGS)

$(EXE): $(MAIN) $(CPYBOOKS)
ifdef _dll
	$(COBOL) $(OPTIONS) -x -o $@ $< -L $(ODIR) $(addprefix -l ,$(_dll))
else
	$(COBOL) $(OPTIONS) -x -o $@ $<
endif

.PHONY: all clean test
