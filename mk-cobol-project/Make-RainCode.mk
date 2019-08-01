
COB = $(wildcard *.cbl)
CPY = $(wildcard *.cpy)
DLL = $(patsubst %.cbl,%.dll,$(COB))

EXE = cobol-project-maker

all: $(DLL)

run:
	rclrun $(EXE)

list:
	echo 'COB=' $(COB)
	echo 'CPY=' $(CPY)
	echo 'DLL=' $(DLL)

%.dll: %.cbl $(CPY)
	cobrc $<

clean:
	rm -fv $(DLL)

.PHONY: all clean list run
