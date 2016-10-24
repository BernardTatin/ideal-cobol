       IDENTIFICATION DIVISION.
       PROGRAM-ID. trimright-display IS INITIAL.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 left-len PIC 99999.
       LINKAGE SECTION.
       01 full-string PIC X ANY LENGTH.

       PROCEDURE DIVISION USING full-string.
       prog.
           MOVE FUNCTION LENGTH ( FUNCTION TRIM (full-string TRAILING) )
           TO left-len.
           IF left-len > 0 then
              DISPLAY full-string(1:left-len)
           ELSE
              DISPLAY ''
           END-IF.
           EXIT PROGRAM.

       END PROGRAM trimright-display.

