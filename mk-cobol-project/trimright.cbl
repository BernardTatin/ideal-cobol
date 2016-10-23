       IDENTIFICATION DIVISION.
       PROGRAM-ID. trimright-display IS INITIAL.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 blen PIC 99999.
       LINKAGE SECTION.
       01 full-string pic x ANY LENGTH.

       PROCEDURE DIVISION USING full-string.
       prog.
           MOVE FUNCTION LENGTH ( FUNCTION TRIM (full-string TRAILING) )
           TO blen.
           if blen > 0 then
              DISPLAY full-string(1:blen)
           ELSE
              DISPLAY '##'
           END-IF.
           EXIT PROGRAM.

       END PROGRAM trimright-display.

