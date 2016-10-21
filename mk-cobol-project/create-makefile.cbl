       IDENTIFICATION DIVISION.
       PROGRAM-ID. create-makefile IS INITIAL.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       78 STRING-LEN VALUE 128.
       78 BUFFER-LEN VALUE 512.
       78 TABLE-SIZE VALUE 13.

       01 line-tit PIC X(STRING-LEN) VALUE "# Makefile :".
       01 line-app PIC X(STRING-LEN) VALUE "APP = :".
       01 template.
               05 line-aa PIC X(STRING-LEN) VALUE "# ===============" &
                  "=================================================".
               05 line-ab PIC X(STRING-LEN) VALUE "#x".
               05 line-ac PIC X(STRING-LEN) VALUE "# export " &
                  "LD_LIBRARY_PATH=$(pwd)/bin".
               05 line-ad PIC X(STRING-LEN) VALUE "# ===============" &
                  "=================================================".
               05 line-ae PIC X(STRING-LEN) VALUE "#".
               05 line-00 PIC X(STRING-LEN) VALUE "#x".
               05 line-01 PIC X(STRING-LEN) VALUE "#".
               05 line-04 PIC X(STRING-LEN) VALUE "TESTS-ARGS =".
               05 line-02 PIC X(STRING-LEN) VALUE "MAIN = $(APP).cbl".
               05 line-03 PIC X(STRING-LEN) VALUE "CPYBOOKS = ".
               05 line-05 PIC X(STRING-LEN) VALUE "_dll = create-" &
                  "makefile create-cobolfile".
               05 line-06 PIC X(STRING-LEN) VALUE "#".
               05 line-07 PIC X(STRING-LEN) VALUE "include ../mk/" &
                  "common.mk".
       01 all-lines REDEFINES template.
               05 one-line OCCURS TABLE-SIZE PIC X(STRING-LEN).
       01 i PIC 9.
       01 buffer PIC X(BUFFER-LEN).
       LINKAGE SECTION.
      *> project name, the first argument on the command line
       01 project-name PIC X(STRING-LEN).

       PROCEDURE DIVISION USING project-name.
       prog.
           STRING line-tit DELIMITED BY ":"
             project-name DELIMITED BY SPACES
             INTO one-line(2)
             on overflow move 'ERROR (2)' to one-line(2)
           END-STRING.
           STRING line-app DELIMITED BY ":"
             project-name DELIMITED BY SPACES
             INTO one-line(6)
             on overflow move 'ERROR (6)' to one-line(6)
           END-STRING.

           PERFORM VARYING i FROM 1 BY 1 UNTIL i > TABLE-SIZE
      *        MOVE "#" TO buffer
      *        MOVE one-line(i) to buffer
               DISPLAY "--> " i
               CALL "trimright" USING CONTENT one-line(i)
           END-PERFORM.
           EXIT PROGRAM.
      *> emergency exit
       900-TERMINATE SECTION.
           DISPLAY "FATAL ERROR when writing Makefile, exit"
           UPON SYSERR
           END-DISPLAY.
           STOP RUN.

           END PROGRAM create-makefile.
