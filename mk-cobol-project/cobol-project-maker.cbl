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
               perform 900-TERMINATE
           END-IF.
           DISPLAY "We will create the project " project-name
           END-DISPLAY.
           perform 900-TERMINATE.
           
       900-TERMINATE SECTION.
           STOP RUN.

      *> end of the game
       STOP RUN.

