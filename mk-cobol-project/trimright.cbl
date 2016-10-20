       IDENTIFICATION DIVISION.
       PROGRAM-ID. trimright.

       DATA DIVISION.
       01 blen PIC 99999.
       LINKAGE SECTION.
      *> project name, the first argument on the command line   
       01 project-name PIC X(256).

       PROCEDURE DIVISION USING project-name.
       prog.
           STRING line-app DELIMITED BY ":" 
           project-name DELIMITED BY SPACES
           INTO buffer
           END-STRING.
           DISPLAY buffer END-DISPLAY.
           PERFORM VARYING i FROM 1 BY 1 UNTIL i > 7
               MOVE "#" TO buffer
               STRING one-line(i) DELIMITED BY ":" INTO buffer
               END-STRING
               MOVE FUNCTION LENGTH ( FUNCTION TRIM (buffer TRAILING) )
               TO blen
               DISPLAY buffer(1:blen) 
               END-DISPLAY
           END-PERFORM.
           EXIT PROGRAM.
      *> emergency exit
       900-TERMINATE SECTION.
           DISPLAY "FATAL ERROR when witing Makefile, exit"
           UPON SYSERR
           END-DISPLAY.
           STOP RUN.

           END PROGRAM trimright.

