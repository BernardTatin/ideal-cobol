       IDENTIFICATION DIVISION.
         PROGRAM-ID. create-cobolfile.
       DATA DIVISION.
         LINKAGE SECTION.
      *> project name, the first argument on the command line   
           01 project-name PIC X(256).
       PROCEDURE DIVISION USING project-name.
       prog.
         DISPLAY "Writing cobolfile for " project-name, " project"
         END-DISPLAY.
         EXIT PROGRAM.
      *> emergency exit
       900-TERMINATE SECTION.
           DISPLAY "FATAL ERROR when witing cobolfile, exit"
              UPON SYSERR
           END-DISPLAY.
           STOP RUN.

       END PROGRAM create-cobolfile.
