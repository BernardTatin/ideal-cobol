       IDENTIFICATION DIVISION.
       PROGRAM-ID.  DATETIME
       AUTHOR.      BILL ROGERS.
      * http://web.sxu.edu/rogers/cobol/datetime.html
      * Compile and run:
      *   RainCode:
      *     cobrc :StrictIBM=TRUE DATETIME.CBL&& rclrun DATETIME.dll
      *   GNU Cobol:
      *     cobc -std=ibm -Wcolumn-overflow -Wall -Wterminator -W -fixed -x -o DATETIME.EXE DATETIME.CBL && ./DATETIME.EXE
      * Note: for GNU Cobol, -std can be standard, ibm, mvs


       INITIAL.

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 SYSTEM-WEEKDAY            PIC 9.

       01 SYSTEM-DATE.
          02 SYSTEM-YEAR            PIC 99.
          02 SYSTEM-MONTH           PIC 99.
          02 SYSTEM-DAY             PIC 99.

       01 SYSTEM-TIME.
          02 SYSTEM-HOUR            PIC 99.
          02 SYSTEM-MINUTE          PIC 99.
          02 SYSTEM-SECOND          PIC 99.
          02 SYSTEM-HUNDREDTH       PIC 99.

       01 GB-WEEKDAY-TABLE.
           05 GB-WEEKDAY-NAMES PIC X(5) OCCURS 7 TIMES.
       01 FR-WEEKDAY-TABLE.
           05 FR-WEEKDAY-NAMES PIC X(5) OCCURS 7 TIMES.

       01 ENGLISH-LINE.
          02 ENGLISH-WEEKDAY        PIC X(5).
          02                        PIC X        VALUE SPACE.
          02 ENGLISH-MONTH          PIC X(5).
          02                        PIC X        VALUE SPACE.
          02 ENGLISH-DAY            PIC Z9.
          02                        PIC X        VALUE SPACE.
          02 ENGLISH-HOUR           PIC Z9.
          02                        PIC X        VALUE ':'.
          02 ENGLISH-MINUTE         PIC 99.
          02                        PIC X        VALUE ':'.
          02 ENGLISH-SECOND         PIC 99.
          02                        PIC X        VALUE SPACE.
          02 ENGLISH-AM-PM          PIC X(2)     VALUE '!!'.
       01 FRENCH-LINE.
          02 FRENCH-WEEKDAY         PIC X(5).
          02                        PIC X        VALUE SPACE.
          02 FRENCH-DAY             PIC Z9.
          02                        PIC X        VALUE SPACE.
          02 FRENCH-MONTH           PIC X(5).
          02                        PIC X        VALUE SPACE.
          02 FRENCH-HOUR            PIC 99.
          02                        PIC X        VALUE ':'.
          02 FRENCH-MINUTE          PIC 99.
          02                        PIC X        VALUE ':'.
          02 FRENCH-SECOND          PIC 99.

       PROCEDURE DIVISION.
       MAINLINE.

           PERFORM INIT-GB.
           PERFORM INIT-FR.

           PERFORM READ-SYSTEM-DATE-TIME.
           PERFORM GET-GB-WEEKDAY-NAME.
           PERFORM GET-GB-MONTH-NAME.
           PERFORM FILL-ENGLISH-LINE.
           DISPLAY ENGLISH-LINE.

           PERFORM READ-SYSTEM-DATE-TIME.
           PERFORM GET-FR-WEEKDAY-NAME.
           PERFORM GET-FR-MONTH-NAME.
           PERFORM FILL-FRENCH-LINE.
           DISPLAY FRENCH-LINE.
      * GNU Cobol: the -std=ibm-strict option does not support this
      *    but RainCode Cobol says nothing.
      *    END-DISPLAY.
           STOP RUN.

       init-gb section.
           move 'Mon' to GB-WEEKDAY-NAMES(1).
           move 'Tue' to GB-WEEKDAY-NAMES(2).
           move 'Wed' to GB-WEEKDAY-NAMES(3).
           move 'Thu' to GB-WEEKDAY-NAMES(4).
           move 'Fri' to GB-WEEKDAY-NAMES(5).
           move 'Sat' to GB-WEEKDAY-NAMES(6).
           move 'Sun' to GB-WEEKDAY-NAMES(7).

       READ-SYSTEM-DATE-TIME SECTION.
      *    Reads date, time and week day from the system
           ACCEPT SYSTEM-WEEKDAY FROM DAY-OF-WEEK.
      * GNU Cobol: the -std=ibm-strict option does not support this
      *    but RainCode Cobol says nothing.
      *    END-ACCEPT.
           ACCEPT SYSTEM-DATE FROM DATE.
      *    END-ACCEPT.
           ACCEPT SYSTEM-TIME FROM TIME.
      *    END-ACCEPT.

       GET-GB-WEEKDAY-NAME SECTION.
           move GB-WEEKDAY-NAMES(SYSTEM-WEEKDAY) to ENGLISH-WEEKDAY.

       GET-GB-MONTH-NAME SECTION.
           EVALUATE SYSTEM-MONTH
               WHEN  1  MOVE 'Jan' TO ENGLISH-MONTH
               WHEN  2  MOVE 'Feb' TO ENGLISH-MONTH
               WHEN  3  MOVE 'Mar' TO ENGLISH-MONTH
               WHEN  4  MOVE 'Apr' TO ENGLISH-MONTH
               WHEN  5  MOVE 'May' TO ENGLISH-MONTH
               WHEN  6  MOVE 'Jun' TO ENGLISH-MONTH
               WHEN  7  MOVE 'Jul' TO ENGLISH-MONTH
               WHEN  8  MOVE 'Aug' TO ENGLISH-MONTH
               WHEN  9  MOVE 'Sep' TO ENGLISH-MONTH
               WHEN 10  MOVE 'Oct' TO ENGLISH-MONTH
               WHEN 11  MOVE 'Nov' TO ENGLISH-MONTH
               WHEN 12  MOVE 'Dec' TO ENGLISH-MONTH
           END-EVALUATE.

       FILL-ENGLISH-LINE SECTION.
           MOVE SYSTEM-DAY TO ENGLISH-DAY.

      *    British time
           IF SYSTEM-HOUR IS LESS THAN 12
              MOVE 'AM' TO ENGLISH-AM-PM
           ELSE
              MOVE 'PM' TO ENGLISH-AM-PM
      *       IF SYSTEM-HOUR IS NOT LESS THAN 13
              IF SYSTEM-HOUR IS GREATER THAN 12
                 SUBTRACT
                   12 FROM SYSTEM-HOUR
                 END-SUBTRACT
              END-IF
           END-IF.
           MOVE SYSTEM-HOUR TO ENGLISH-HOUR.
           MOVE SYSTEM-MINUTE TO ENGLISH-MINUTE.
           MOVE SYSTEM-SECOND TO ENGLISH-SECOND.


       init-fr section.
           move 'Lun' to FR-WEEKDAY-NAMES(1).
           move 'Mar' to FR-WEEKDAY-NAMES(2).
           move 'Mer' to FR-WEEKDAY-NAMES(3).
           move 'Jeu' to FR-WEEKDAY-NAMES(4).
           move 'Ven' to FR-WEEKDAY-NAMES(5).
           move 'Sam' to FR-WEEKDAY-NAMES(6).
           move 'Dim' to FR-WEEKDAY-NAMES(7).

       GET-FR-WEEKDAY-NAME SECTION.
           move FR-WEEKDAY-NAMES(SYSTEM-WEEKDAY) to FRENCH-WEEKDAY.

       GET-FR-MONTH-NAME SECTION.
           EVALUATE SYSTEM-MONTH
               WHEN  1  MOVE 'Jan' TO FRENCH-MONTH
               WHEN  2  MOVE 'Fév' TO FRENCH-MONTH
               WHEN  3  MOVE 'Mars' TO FRENCH-MONTH
               WHEN  4  MOVE 'Avr' TO FRENCH-MONTH
               WHEN  5  MOVE 'Mai' TO FRENCH-MONTH
               WHEN  6  MOVE 'Juin' TO FRENCH-MONTH
               WHEN  7  MOVE 'Juil' TO FRENCH-MONTH
               WHEN  8  MOVE 'Aout' TO FRENCH-MONTH
               WHEN  9  MOVE 'Sept' TO FRENCH-MONTH
               WHEN 10  MOVE 'Oct' TO FRENCH-MONTH
               WHEN 11  MOVE 'Nov' TO FRENCH-MONTH
               WHEN 12  MOVE 'Déc' TO FRENCH-MONTH
           END-EVALUATE.

       FILL-FRENCH-LINE SECTION.
           MOVE SYSTEM-DAY TO FRENCH-DAY.
           MOVE SYSTEM-HOUR TO FRENCH-HOUR.
           MOVE SYSTEM-MINUTE TO FRENCH-MINUTE.
           MOVE SYSTEM-SECOND TO FRENCH-SECOND.
