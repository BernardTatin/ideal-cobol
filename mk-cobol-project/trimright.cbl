       IDENTIFICATION DIVISION.
       PROGRAM-ID. trimright.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 blen PIC 99999.
       LINKAGE SECTION.
       01 full-string pic x ANY LENGTH.

       PROCEDURE DIVISION USING full-string.
       prog.
           MOVE FUNCTION LENGTH ( FUNCTION TRIM (full-string TRAILING) )
           TO blen.
           DISPLAY blen " -- " END-DISPLAY.
           if blen > 0 then
              if blen = 256 then
                display full-string(1:20) end-display
              else
                DISPLAY full-string(1:blen) END-DISPLAY
              end-if
           else
              DISPLAY '##'
              END-DISPLAY
           end-if.
           EXIT PROGRAM.

           END PROGRAM trimright.

