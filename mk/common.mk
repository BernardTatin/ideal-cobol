#
# common.mk
#

COBOL = /usr/local/bin/cobc
RM    = rm -Rfv

STANDARD ?= cobol85

ODIR = bin

WARNS = -Wcolumn-overflow -Wall -Wterminator -W -std=$(STANDARD)
DEBUG =
OPTIM =

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

$(EXE): $(MAIN) $(CPYBOOKS)
ifdef _dll
	$(COBOL) $(OPTIONS) -x -o $@ $< -L $(ODIR) -l $(_dll)
else
	$(COBOL) $(OPTIONS) -x -o $@ $<
endif

.PHONY: all clean
