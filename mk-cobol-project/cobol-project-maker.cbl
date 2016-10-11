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
      *>   Open Cobol specific I think.
      *>   TODO find a way to control string size here 
           ACCEPT project-name FROM COMMAND-LINE
           END-ACCEPT.

      *> end of the game
       STOP RUN.

