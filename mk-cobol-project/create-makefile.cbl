       IDENTIFICATION DIVISION.
       PROGRAM-ID. create-makefile. IS initial program.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 line-tit PIC X(256) VALUE "# Makefile :".
       01 line-app PIC X(256) VALUE "APP = :".
       01 template.
               05 line-aa PIC X(256) VALUE "# =====================" &
                  "===========================================".
               05 line-ab PIC X(256) VALUE "#x".
               05 line-ac PIC X(256) VALUE "# export " &
                  "LD_LIBRARY_PATH=$(pwd)/bin".
               05 line-ad PIC X(256) VALUE "# =====================" &
                  "===========================================".
               05 line-ae PIC X(256) VALUE "".
               05 line-00 PIC X(256) VALUE "#x".
               05 line-01 PIC X(256) VALUE "".
               05 line-04 PIC X(256) VALUE "TESTS-ARGS =".
               05 line-02 PIC X(256) VALUE "MAIN = $(APP).cbl".
               05 line-03 PIC X(256) VALUE "CPYBOOKS = ".
               05 line-05 PIC X(256) VALUE "_dll = create-makefile" &
               " create-cobolfile".
               05 line-06 PIC X(256) VALUE "#".
               05 line-07 PIC X(256) VALUE "include ../mk/common.mk".
       01 all-lines REDEFINES template.
               05 one-line OCCURS 50 PIC X(256).
       01 i PIC 9.
       01 buffer PIC X(1256).
       LINKAGE SECTION.
      *> project name, the first argument on the command line
       01 project-name PIC X(256).

       PROCEDURE DIVISION USING project-name.
       prog.
           STRING line-tit DELIMITED BY ":"
             project-name DELIMITED BY SPACES
             INTO one-line(2)
           END-STRING.
           STRING line-app DELIMITED BY ":"
             project-name DELIMITED BY SPACES
             INTO one-line(6)
           END-STRING.

           PERFORM VARYING i FROM 1 BY 1 UNTIL i > 13
      *        MOVE "#" TO buffer
               MOVE one-line(i) to buffer
               CALL "trimright" USING CONTENT buffer
           END-PERFORM.
           EXIT PROGRAM.
      *> emergency exit
       900-TERMINATE SECTION.
           DISPLAY "FATAL ERROR when writing Makefile, exit"
           UPON SYSERR
           END-DISPLAY.
           STOP RUN.

           END PROGRAM create-makefile.
