       IDENTIFICATION DIVISION.
       PROGRAM-ID.  DATETIME
       AUTHOR.      BILL ROGERS.
      * http://web.sxu.edu/rogers/cobol/datetime.html
      *
      * A lot of modifications by Bernard Tatin to (re)learn COBOL
      *
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

      * Raw date read from the system
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

      * Week days names in English
       01 GB-WEEKDAY-TABLE.
           05 FILLER PIC X(5) VALUE 'Mon'.
           05 FILLER PIC X(5) VALUE 'Tue'.
           05 FILLER PIC X(5) VALUE 'Wed'.
           05 FILLER PIC X(5) VALUE 'Thu'.
           05 FILLER PIC X(5) VALUE 'Fri'.
           05 FILLER PIC X(5) VALUE 'Sat'.
           05 FILLER PIC X(5) VALUE 'Sun'.
       01 FILLER REDEFINES GB-WEEKDAY-TABLE.
           05 GB-WEEKDAY-NAMES OCCURS 7 TIMES PIC X(5).

      * Months names in English
       01 GB-MONTH-TABLE.
           05 FILLER PIC X(5) VALUE 'Jan'.
           05 FILLER PIC X(5) VALUE 'Feb'.
           05 FILLER PIC X(5) VALUE 'Mar'.
           05 FILLER PIC X(5) VALUE 'Apr'.
           05 FILLER PIC X(5) VALUE 'May'.
           05 FILLER PIC X(5) VALUE 'Jun'.
           05 FILLER PIC X(5) VALUE 'Jul'.
           05 FILLER PIC X(5) VALUE 'Aug'.
           05 FILLER PIC X(5) VALUE 'Sep'.
           05 FILLER PIC X(5) VALUE 'Oct'.
           05 FILLER PIC X(5) VALUE 'Nov'.
           05 FILLER PIC X(5) VALUE 'Dec'.
       01 FILLER REDEFINES GB-MONTH-TABLE.
           05 GB-MONTH-NAMES OCCURS 12 TIMES PIC X(5).

      * Week days names in French
       01 FR-WEEKDAY-TABLE.
           05 FILLER PIC X(5) VALUE 'Lun'.
           05 FILLER PIC X(5) VALUE 'Mar'.
           05 FILLER PIC X(5) VALUE 'Mer'.
           05 FILLER PIC X(5) VALUE 'Jeu'.
           05 FILLER PIC X(5) VALUE 'Ven'.
           05 FILLER PIC X(5) VALUE 'Sam'.
           05 FILLER PIC X(5) VALUE 'Dim'.
       01 FILLER REDEFINES FR-WEEKDAY-TABLE.
           05 FR-WEEKDAY-NAMES OCCURS 7 TIMES PIC X(5).

      * Months names in English
       01 FR-MONTH-TABLE.
           05 FILLER PIC X(5) VALUE 'Jan'.
           05 FILLER PIC X(5) VALUE 'Fév'.
           05 FILLER PIC X(5) VALUE 'Mars'.
           05 FILLER PIC X(5) VALUE 'Avr'.
           05 FILLER PIC X(5) VALUE 'Mai'.
           05 FILLER PIC X(5) VALUE 'Juin'.
           05 FILLER PIC X(5) VALUE 'Juil'.
           05 FILLER PIC X(5) VALUE 'Aout'.
           05 FILLER PIC X(5) VALUE 'Sept'.
           05 FILLER PIC X(5) VALUE 'Oct'.
           05 FILLER PIC X(5) VALUE 'Nov'.
           05 FILLER PIC X(5) VALUE 'Déc'.
       01 FILLER REDEFINES FR-MONTH-TABLE.
           05 FR-MONTH-NAMES OCCURS 12 TIMES PIC X(5).

      * Output buffer in English
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
      * Output buffer in French
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
           PERFORM READ-SYSTEM-DATE-TIME.
           PERFORM FILL-ENGLISH-LINE.
           DISPLAY ENGLISH-LINE.

           PERFORM READ-SYSTEM-DATE-TIME.
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

       FILL-ENGLISH-LINE SECTION.
           MOVE GB-WEEKDAY-NAMES(SYSTEM-WEEKDAY) TO ENGLISH-WEEKDAY.
           MOVE GB-MONTH-NAMES(SYSTEM-MONTH) TO ENGLISH-MONTH.
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

       FILL-FRENCH-LINE SECTION.
           MOVE FR-WEEKDAY-NAMES(SYSTEM-WEEKDAY) TO FRENCH-WEEKDAY.
           MOVE FR-MONTH-NAMES(SYSTEM-MONTH) TO FRENCH-MONTH.
           MOVE SYSTEM-DAY TO FRENCH-DAY.
           MOVE SYSTEM-HOUR TO FRENCH-HOUR.
           MOVE SYSTEM-MINUTE TO FRENCH-MINUTE.
           MOVE SYSTEM-SECOND TO FRENCH-SECOND.
