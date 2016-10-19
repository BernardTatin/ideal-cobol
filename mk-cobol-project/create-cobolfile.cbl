       IDENTIFICATION DIVISION.
         PROGRAM-ID. create-cobolfile.
       DATA DIVISION.
         WORKING-STORAGE SECTION.
           01 line-app PIC X(256) VALUE "APP = :".
           01 template.
               05 line-01 PIC X(256) VALUE "APP = cobol-project-maker".
               05 line-02 PIC X(256) VALUE "MAIN = $(APP).cbl".
               05 line-03 PIC X(256) VALUE "CPYBOOKS = ".
               05 line-04 PIC X(256) VALUE "TESTS_ARGS = coco-project".
               05 line-05 PIC X(256) VALUE "_dll = create-makefile" &
                   " create-cobolfile".
               05 line-06 PIC X(256) VALUE "".
               05 line-07 PIC X(256) VALUE "include ../mk/common.mk".
           01 buffer PIC X(256).
         LINKAGE SECTION.
      *> project name, the first argument on the command line   
           01 project-name PIC X(256).
       PROCEDURE DIVISION USING project-name.
       prog.
           STRING line-app DELIMITED BY ":" 
                   project-name DELIMITED BY SPACES
                   INTO buffer
           END STRING.
           DISPLAY buffer END-DISPLAY.
           EXIT PROGRAM.
      *> emergency exit
       900-TERMINATE SECTION.
           DISPLAY "FATAL ERROR when witing cobolfile, exit"
              UPON SYSERR
           END-DISPLAY.
           STOP RUN.

       END PROGRAM create-cobolfile.
