      *> -------------------------------------------
      *> cobol-project-maker.cbl
      *> >>SOURCE FORMAT IS FIXED
      *> -------------------------------------------

       IDENTIFICATION DIVISION.

         PROGRAM-ID. "cobol-project-maker".

      *> les données
       DATA DIVISION.
         WORKING-STORAGE SECTION.
         
           01 project-name PIC X(256).

      *> le programme
       PROCEDURE DIVISION.
           ACCEPT project-name FROM COMMAND-LINE
           END-ACCEPT.

      *> end of the game
       STOP RUN.

