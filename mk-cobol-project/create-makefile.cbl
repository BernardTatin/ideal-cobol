       IDENTIFICATION DIVISION.
       PROGRAM-ID. create-makefile.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 line-app PIC X(256) VALUE "APP = :".
       01 template.
               05 line-01 PIC X(256) VALUE ":".
               05 line-02 PIC X(256) VALUE "MAIN = $(APP).cbl:".
               05 line-03 PIC X(256) VALUE "CPYBOOKS = :".
               05 line-04 PIC X(256) VALUE "TESTS_ARGS = coco-project:".
               05 line-05 PIC X(256) VALUE "_dll = create-makefile" &
               " create-cobolfile:".
               05 line-06 PIC X(256) VALUE ":".
               05 line-07 PIC X(256) VALUE "include ../mk/common.mk:".
       01 all-lines REDEFINES template.
               05 one-line OCCURS 7 PIC X(256).
       01 i PIC 9.
       01 blen PIC 999.
       01 buffer PIC X(256) USAGE DISPLAY.
       LINKAGE SECTION.
      *> project name, the first argument on the command line   
       01 project-name PIC X(256).
           PROCEDURE DIVISION USING project-name.
       prog.
           STRING line-app DELIMITED BY ":" 
           project-name DELIMITED BY SPACES
           INTO buffer
           END-STRING.
           DISPLAY buffer END-DISPLAY.
           PERFORM VARYING i FROM 1 BY 1 UNTIL i > 7
               MOVE "#" TO buffer
               STRING one-line(i) DELIMITED BY ":" INTO buffer
               END-STRING
               MOVE FUNCTION LENGTH ( FUNCTION TRIM (buffer TRAILING) )
               TO blen
               DISPLAY buffer(1:blen) 
               END-DISPLAY
           END-PERFORM.
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
