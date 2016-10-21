       IDENTIFICATION DIVISION.
       PROGRAM-ID. trimright.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 blen PIC 99999.
       LINKAGE SECTION.
      *> project name, the first argument on the command line
       01 full-string pic x ANY LENGTH.

       PROCEDURE DIVISION USING full-string.
       prog.
           MOVE FUNCTION LENGTH ( FUNCTION TRIM (full-string TRAILING) )
           TO blen.
           DISPLAY full-string(1:blen)
           END-DISPLAY
           EXIT PROGRAM.

           END PROGRAM trimright.

