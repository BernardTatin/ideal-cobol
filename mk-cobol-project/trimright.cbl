       IDENTIFICATION DIVISION.
       PROGRAM-ID. trimright IS INITIAL.

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
              display full-string(1:blen) end-display
           else
              DISPLAY '##'
              END-DISPLAY
           end-if.
           EXIT PROGRAM.

           END PROGRAM trimright.

