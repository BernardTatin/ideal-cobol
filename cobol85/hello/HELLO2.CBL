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

           77 MYNAME PIC X(32) VALUE 'BERNARD TAT1 !!!'.
           77 BUFFER PIC X(32).
       PROCEDURE DIVISION.
       MAINLINE.
      *> Z390 does not support STRING yet.
      *>        STRING m-label DELIMITED BY ':'
      *>        myname DELIMITED BY spaces
      *>        into buffer.
           MOVE 'Hello world !' TO BUFFER.
           CALL 'TRIMRD' USING BY VALUE BUFFER.
           MOVE MYNAME TO BUFFER.
           CALL 'TRIMRD' USING BY VALUE BUFFER.
           MOVE 0 TO return-code.
       STOP RUN.
       END PROGRAM HELLO.

