       IDENTIFICATION DIVISION.
      *> Compile and link with : ZC390CLG zcobol\cobol85\hello\HELLO
      *> Run with              : EXEC zcobol\cobol85\hello\HELLO
      *>
      *> I can't use CALL in any way, nor MOVE FUNCTION, nor STRING...
      *> zcobol for z390 emulator is a great idea but hard to use.

       PROGRAM-ID. HELLO.
      *>  Not supported by Tiny Cobol.
            Author Bernard Tatin.
            Installation Z390 Emulator.
            Date-Written 10/24/2016.
            Date-Compiled 10/24/2016.

       ENVIRONMENT DIVISION.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *> Constants are unknown with z390 Cobol...
      *>78 string-len value 32.

           77 MYNAME PIC X(32) VALUE 'BERNARD'.
           77 BUFFER PIC X(32).
           77 BUFFER2 PIC X(32).
       01 left-len PIC 99999.
       PROCEDURE DIVISION.
       MAINLINE.
      *> Z390 does not support STRING yet.
      *>        STRING m-label DELIMITED BY ':'
      *>        myname DELIMITED BY spaces
      *>        into buffer.
           MOVE 'Hello world !' TO BUFFER.
           PERFORM TRIMR-DISP.
           MOVE MYNAME TO BUFFER.
           PERFORM TRIMR-DISP.
       STOP RUN.
       TRIMR-DISP.
      *> Z390 does not support MOVE FUNCTION
      *>     MOVE FUNCTION LENGTH ( FUNCTION TRIM (BUFFER TRAILING) )
      *>     TO LEFT-LEN.
           MOVE 8 TO LEFT-LEN.
           IF LEFT-LEN > 0 THEN
             MOVE BUFFER(1:LEFT-LEN) TO BUFFER2
           ELSE
             MOVE '??' TO BUFFER2
           END-IF.
           DISPLAY BUFFER2.

       END PROGRAM HELLO.

