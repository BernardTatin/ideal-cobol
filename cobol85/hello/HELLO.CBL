       IDENTIFICATION DIVISION.
      *> Run with : ZC390CLG zcobol\works\HELLO
       PROGRAM-ID. HELLO.
      *>  Not supported by Tiny Cobol.
      *>      Author Bernard Tatin.
      *>      Installation Z390 Emulator.
      *>      Date-Written 10/24/2016.
      *>      Date-Compiled 10/24/2016.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *> Constants are unknown with z390 Cobol...
      *>78 string-len value 32.

       01 myname PIC X(32) value 'Bernard'.
       01 message.
          02 m-label PIC X(32) VALUE 'My name is '.
          02 m-name PIC X(32).
       PROCEDURE DIVISION.
              DISPLAY 'Hello World'.
              MOVE myname TO m-name.
              DISPLAY message.
              STOP RUN.
