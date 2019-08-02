       IDENTIFICATION DIVISION.
       PROGRAM-ID. create_makefile IS INITIAL.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *> Constants
      *> 78 ALL-LINES-TABLE-SIZE VALUE 13.
      *> 78 VAR-LINES-TABLE-SIZE VALUE 2.
      *> 78 THE-STRINGLEN VALUE 92.

      *> Variable lines
       01 var-template.
         02 idx-tit PIC 99 VALUE 2.
         02 line-tit PIC X(92) VALUE "# Makefile :".
         02 idx-app PIC 99 VALUE 6.
         02 line-app PIC X(92) VALUE "APP = :".
       01 var-lines REDEFINES var-template.
         02 arr-line OCCURS 3.
           05 idx PIC 99.
           05 var-line PIC X(92).

      *> All lines
       01 all-template.
         05 line-aa PIC X(92) VALUE "# ===============" &
            "=================================================".
         05 line-ab PIC X(92) VALUE "#x".
         05 line-ac PIC X(92) VALUE "# export " &
            "LD_LIBRARY_PATH=$(pwd)/bin".
         05 line-ad PIC X(92) VALUE "# ===============" &
            "=================================================".
         05 line-ae PIC X(92) VALUE "#".
         05 line-00 PIC X(92) VALUE "#x".
         05 line-01 PIC X(92) VALUE "#".
         05 line-04 PIC X(92) VALUE "TESTS-ARGS =".
         05 line-02 PIC X(92) VALUE "MAIN = $(APP).cbl".
         05 line-03 PIC X(92) VALUE "CPYBOOKS =".
         05 line-05 PIC X(92) VALUE "_dll = ".
         05 line-06 PIC X(92) VALUE "#".
         05 line-07 PIC X(92) VALUE "include ../mk/" &
            "common.mk".
      *> Preceding lines mapped into an array
       01 all-lines REDEFINES all-template.
         05 one-line OCCURS 13 PIC X(92).
      *> line count
       01 i PIC 999.
       01 itmp PIC 999.

       LINKAGE SECTION.
      *> project name, the first argument on the command line
       01 project-name PIC X(92).

       PROCEDURE DIVISION USING project-name.
       prog.
         PERFORM VARYING i FROM 1 BY 1 UNTIL i > 3
           MOVE idx(i) TO itmp
           STRING var-line(i) DELIMITED BY ":"
             project-name DELIMITED BY SPACES
             INTO one-line(itmp)
             ON OVERFLOW MOVE 'ERROR (STRING var-line)'
                to one-line(itmp)
           END-STRING
         END-PERFORM.

         PERFORM VARYING i FROM 1 BY 1 UNTIL i > 13
           CALL "trimright" USING CONTENT one-line(i)
           end-call
         END-PERFORM.
         EXIT PROGRAM.
      *> emergency exit
       900-TERMINATE SECTION.
         DISPLAY "FATAL ERROR when writing Makefile, exit"
      *>     UPON SYSERR
         STOP RUN.

       END PROGRAM create_makefile.
