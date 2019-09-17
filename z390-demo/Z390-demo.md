# _z390_ demo

All the _COBOL_ files (extension `.CBL`) come from the [z390 project](http://sourceforge.net/projects/z390/files/z390_v1506/).

## notes

Compilation process is something like this:

```sh
cobrc PROGRAM.CBL F.CPY ...
```

Running a _COBOL_ program with output text files is like this:

```sh
rclrun  PROGRAM.dll && dos2unix OUTFILE
```
