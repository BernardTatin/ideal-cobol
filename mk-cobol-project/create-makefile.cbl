       IDENTIFICATION DIVISION.
         PROGRAM-ID. create-makefile.

       ENVIRONMENT DIVISION.
         input-output section.
           file-control.
             select out-file ASSIGN "Makefile.test"
               organization line sequential. 

       DATA DIVISION.
         FILE SECTION.
           FD  out-file.
           01  fline     PIC X(512).
         WORKING-STORAGE SECTION.
       01  file-is-open    PIC 9 VALUE 0.
       01  app-string.
           05  app         pic X(16) value "APP = ".
           05  prj-name    pic X(256).

         LINKAGE SECTION.
      *> project name, the first argument on the command line   
           01 project-name PIC X(256).

       PROCEDURE DIVISION USING project-name.
       DECLARATIVES.
       out-file-error SECTION.
           USE AFTER ERROR ON out-file.
           DISPLAY "An error occurred while using output.txt."
               UPON SYSERR
           END-DISPLAY.
           if file-is-open = 1 then
              display "Closing file..."
              end-display
              CLOSE out-file
           end-if.
           STOP RUN.
       END DECLARATIVES.

       prog.
         open OUTPUT out-file.
         DISPLAY "Writing Makefile for " project-name, " project"
         END-DISPLAY.
         WRITE fline FROM "#" BEFORE ADVANCING 2 END-WRITE.
           MOVE project-name TO prj-name.
         WRITE fline FROM app-string END-WRITE.
         WRITE fline FROM "MAIN = $(APP).cbl" END-WRITE.
         WRITE fline FROM "CPYBOOKS = " END-WRITE.
         WRITE fline FROM "TESTS_ARGS =" END-WRITE.
         WRITE fline FROM "_dll =" BEFORE ADVANCING 2 END-WRITE.
         WRITE fline FROM "include ../mk/common.mk" END-WRITE.

         CLOSE out-file
         EXIT PROGRAM.
      *> emergency exit
       900-TERMINATE SECTION.
           if file-is-open = 1 then
              display "Closing file..."
              end-display
              CLOSE out-file
           end-if.
           DISPLAY "FATAL ERROR when witing Makefile, exit"
              UPON SYSERR
           END-DISPLAY.
           STOP RUN.

       END PROGRAM create-makefile.
