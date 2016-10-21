      *> -------------------------------------------
      *> cobol-project-maker.cbl
      *> >>SOURCE FORMAT IS FIXED
      *> -------------------------------------------

       IDENTIFICATION DIVISION.

         PROGRAM-ID. "cobol-project-maker".

       DATA DIVISION.
         WORKING-STORAGE SECTION.
      *> project name, the first argument on the command line
           01 project-name PIC X(256).

      *> program entry point
       PROCEDURE DIVISION.
      *>   Program inirialisation
           perform 001-INIT.
      *>   if we are her, init is good enough, tell ti to user
           DISPLAY "We will create the project " project-name
           END-DISPLAY.
      *>   create Makefile
           CALL "create-makefile" USING CONTENT project-name
           END-CALL.
      *>   create source file
           CALL "create-cobolfile" USING CONTENT project-name
           END-CALL.
           perform 900-TERMINATE.

       001-INIT SECTION.
      *>   reading the first argument of the comand line
      *>   put it in project-name.
      *>   Open Cobol specific I think, set -std of cobc at standard.
      *>   TODO find a way to control string size here
           ACCEPT project-name FROM COMMAND-LINE
           END-ACCEPT.
           IF project-name = SPACES
      *>       if no arguments, show an error
      *>       under Unix, it's like writing on stderr
               DISPLAY "cobol-project-maker needs a project file name"
                 UPON SYSERR
               END-DISPLAY
      *>       ... and exit
               perform 900-TERMINATE
           END-IF.

       900-TERMINATE SECTION.
           STOP RUN.

      *> end of the game
      *> unreachable statement, so we comment it
      *> STOP RUN.
