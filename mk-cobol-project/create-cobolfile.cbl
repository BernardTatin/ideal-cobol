       IDENTIFICATION DIVISION.
         PROGRAM-ID. create-cobolfile.
       DATA DIVISION.
         WORKING-STORAGE SECTION.
      *> Constants
       78 ALL-LINES-TABLE-SIZE VALUE 6.
       78 VAR-LINES-TABLE-SIZE VALUE 2.
       78 THE-STRINGLEN VALUE 92.

      *> Variable lines
       01 var-template.
           02 idx-tit PIC 99 VALUE 2.
           02 line-tit PIC X(THE-STRINGLEN) VALUE "         " &
              "PROGRAM-ID. :".
           02 idx-app PIC 99 VALUE 6.
           02 line-app PIC X(THE-STRINGLEN) VALUE "       " &
              "END PROGRAM :".
       01 var-lines REDEFINES var-template.
           02 arr-line OCCURS VAR-LINES-TABLE-SIZE.
             05 idx PIC 99.
             05 var-line PIC X(THE-STRINGLEN).

      *> All lines
       01 all-template.
           05 line-aa PIC X(THE-STRINGLEN) VALUE "       " &
              "IDENTIFICATION DIVISION.".
           05 line-ab PIC X(THE-STRINGLEN) VALUE "#x".
           05 line-ac PIC X(THE-STRINGLEN) VALUE "       " &
              "DATA DIVISION.".
           05 line-ad PIC X(THE-STRINGLEN) VALUE "       " &
              "WORKING-STORAGE SECTION.".
           05 line-ae PIC X(THE-STRINGLEN) VALUE "       " &
              "PROCEDURE DIVISION.".
           05 line-00 PIC X(THE-STRINGLEN) VALUE "       " &
              "END PROGRAM.".
      *> Preceding lines mapped into an array
       01 all-lines REDEFINES all-template.
               05 one-line OCCURS ALL-LINES-TABLE-SIZE
                  PIC X(THE-STRINGLEN).
      *> line count
       01 i PIC 999.
       01 itmp PIC 999.
       LINKAGE SECTION.
      *> project name, the first argument on the command line
           01 project-name PIC X(256).
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
           DISPLAY "FATAL ERROR when writing Cobol source file, exit"
            UPON SYSERR
           STOP RUN.

       END PROGRAM create-cobolfile.
