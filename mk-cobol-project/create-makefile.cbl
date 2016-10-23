       IDENTIFICATION DIVISION.
       PROGRAM-ID. create-makefile IS INITIAL.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *> Constants
       78 STRING-LEN VALUE 92.
       78 ALL-LINES-TABLE-SIZE VALUE 13.
       78 VAR-LINES-TABLE-SIZE VALUE 2.

      *> Variable lines
       01 var-template.
           02 idx-tit PIC 99 VALUE 2.
           02 line-tit PIC X(STRING-LEN) VALUE "# Makefile :".
           02 idx-app PIC 99 VALUE 6.
           02 line-app PIC X(STRING-LEN) VALUE "APP = :".
       01 var-lines REDEFINES var-template.
           02 arr-line OCCURS VAR-LINES-TABLE-SIZE.
             05 idx PIC 99.
             05 var-line PIC X(STRING-LEN).

      *> All lines
       01 all-template.
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
               05 line-03 PIC X(STRING-LEN) VALUE "CPYBOOKS =".
               05 line-05 PIC X(STRING-LEN) VALUE "_dll = ".
               05 line-06 PIC X(STRING-LEN) VALUE "#".
               05 line-07 PIC X(STRING-LEN) VALUE "include ../mk/" &
                  "common.mk".
      *> Preceding lines mapped into an array
       01 all-lines REDEFINES all-template.
               05 one-line OCCURS ALL-LINES-TABLE-SIZE
                  PIC X(STRING-LEN).
      *> line count
       01 i PIC 999.
       01 itmp PIC 999.
       LINKAGE SECTION.
      *> project name, the first argument on the command line
       01 project-name PIC X(STRING-LEN).

       PROCEDURE DIVISION USING project-name.
       prog.
           PERFORM VARYING i FROM 1 BY 1 UNTIL i > VAR-LINES-TABLE-SIZE
             MOVE idx(i) TO itmp
             STRING var-line(i) DELIMITED BY ":"
               project-name DELIMITED BY SPACES
               INTO one-line(itmp)
               ON OVERFLOW MOVE 'ERROR (STRING var-line)'
                  to one-line(itmp)
             END-STRING
           END-PERFORM.

           PERFORM VARYING i FROM 1 BY 1 UNTIL i > ALL-LINES-TABLE-SIZE
               CALL "trimright-display" USING CONTENT one-line(i)
               end-call
           END-PERFORM.
           EXIT PROGRAM.
      *> emergency exit
       900-TERMINATE SECTION.
           DISPLAY "FATAL ERROR when writing Makefile, exit"
            UPON SYSERR
           END-DISPLAY.
           STOP RUN.

           END PROGRAM create-makefile.
