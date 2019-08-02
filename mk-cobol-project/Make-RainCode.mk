
COB = $(wildcard *.cbl)
CPY = $(wildcard *.cpy)
DLL = $(patsubst %.cbl,%.dll,$(COB))

EXE = cobol_project_maker

all: $(DLL)

run: all
	rclrun $(EXE) pipo

list:
	@echo 'COB=' $(COB)
	@echo 'CPY=' $(CPY)
	@echo 'DLL=' $(DLL)

%.dll: %.cbl $(CPY)
	cobrc $<

clean:
	rm -fv $(DLL)

.PHONY: all clean list run
