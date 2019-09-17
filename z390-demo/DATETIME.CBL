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
          02                        PIC X        VALUE SPACE.
          02 ENGLISH-AM-PM          PIC X(2)     VALUE '!!'.
       01 FRENCH-LINE.
          02 FRENCH-WEEKDAY         PIC X(5).
          02                        PIC X        VALUE SPACE.
          02 FRENCH-DAY             PIC Z9.
          02                        PIC X        VALUE SPACE.
          02 FRENCH-MONTH           PIC X(5).
          02                        PIC X        VALUE SPACE.
          02 FRENCH-HOUR            PIC Z9.
          02                        PIC X        VALUE ':'.
          02 FRENCH-MINUTE          PIC 99.

       PROCEDURE DIVISION.
       MAINLINE.

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
           EVALUATE SYSTEM-WEEKDAY
               WHEN  1  MOVE 'Sun' TO ENGLISH-WEEKDAY
               WHEN  2  MOVE 'Mon' TO ENGLISH-WEEKDAY
               WHEN  3  MOVE 'Tue' TO ENGLISH-WEEKDAY
               WHEN  4  MOVE 'Wed' TO ENGLISH-WEEKDAY
               WHEN  5  MOVE 'Thu' TO ENGLISH-WEEKDAY
               WHEN  6  MOVE 'Fri' TO ENGLISH-WEEKDAY
               WHEN  7  MOVE 'Sat' TO ENGLISH-WEEKDAY
           END-EVALUATE.

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


       GET-FR-WEEKDAY-NAME SECTION.
           EVALUATE SYSTEM-WEEKDAY
               WHEN  1  MOVE 'Dim' TO FRENCH-WEEKDAY
               WHEN  2  MOVE 'Lun' TO FRENCH-WEEKDAY
               WHEN  3  MOVE 'Mar' TO FRENCH-WEEKDAY
               WHEN  4  MOVE 'Mer' TO FRENCH-WEEKDAY
               WHEN  5  MOVE 'Jeu' TO FRENCH-WEEKDAY
               WHEN  6  MOVE 'Ven' TO FRENCH-WEEKDAY
               WHEN  7  MOVE 'Sam' TO FRENCH-WEEKDAY
           END-EVALUATE.

       GET-FR-MONTH-NAME SECTION.
           EVALUATE SYSTEM-MONTH
               WHEN  1  MOVE 'Jan' TO FRENCH-MONTH
               WHEN  2  MOVE 'Fév' TO FRENCH-MONTH
               WHEN  3  MOVE 'Mar' TO FRENCH-MONTH
               WHEN  4  MOVE 'Avr' TO FRENCH-MONTH
               WHEN  5  MOVE 'Mai' TO FRENCH-MONTH
               WHEN  6  MOVE 'Jun' TO FRENCH-MONTH
               WHEN  7  MOVE 'Jul' TO FRENCH-MONTH
               WHEN  8  MOVE 'Aou' TO FRENCH-MONTH
               WHEN  9  MOVE 'Sep' TO FRENCH-MONTH
               WHEN 10  MOVE 'Oct' TO FRENCH-MONTH
               WHEN 11  MOVE 'Nov' TO FRENCH-MONTH
               WHEN 12  MOVE 'Déc' TO FRENCH-MONTH
           END-EVALUATE.

       FILL-FRENCH-LINE SECTION.
           MOVE SYSTEM-DAY TO FRENCH-DAY.
           MOVE SYSTEM-HOUR TO FRENCH-HOUR.
           MOVE SYSTEM-MINUTE TO FRENCH-MINUTE.
