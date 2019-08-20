
cob_extension ?= cbl
COB = $(wildcard *.$(cob_extension))
CPY = $(wildcard *.cpy)
DLL = $(patsubst %.$(cob_extension),%.dll,$(COB))

EXE = cobol_project_maker

all: $(DLL)

run: all
	rclrun -LogLevel=DEBUG $(EXE) pipo

list:
	@echo 'COB=' $(COB)
	@echo 'CPY=' $(CPY)
	@echo 'DLL=' $(DLL)

%.dll: %.$(cob_extension) $(CPY)
	cobrc $<

clean:
	rm -fv $(DLL)

.PHONY: all clean list run
