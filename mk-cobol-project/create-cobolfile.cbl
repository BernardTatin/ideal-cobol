       IDENTIFICATION DIVISION.
         PROGRAM-ID. create-cobolfile.
       DATA DIVISION.
         WORKING-STORAGE SECTION.
           01 buffer PIC X(256).
         LINKAGE SECTION.
      *> project name, the first argument on the command line
           01 project-name PIC X(256).
       PROCEDURE DIVISION USING project-name.
       prog.
           STRING "Writing source file for " DELIMITED BY SIZE
               project-name DELIMITED BY SPACES
               " project" DELIMITED BY SIZE
               INTO buffer
           END-STRING.
           DISPLAY buffer
           END-DISPLAY.
           EXIT PROGRAM.
      *> emergency exit
       900-TERMINATE SECTION.
           DISPLAY "FATAL ERROR when witing cobolfile, exit"
           END-DISPLAY.
           STOP RUN.

       END PROGRAM create-cobolfile.
