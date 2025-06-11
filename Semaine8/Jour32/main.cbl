       IDENTIFICATION DIVISION.
       PROGRAM-ID. MAIN.
       AUTHOR. ThomasD.

       DATA DIVISION.

       WORKING-STORAGE SECTION.
       01 WS-NOM     PIC X(20)    VALUE "Bob".
       01 WS-RESULT  PIC X(30).
       01 WS-COUNT   PIC 9(02). 

       PROCEDURE DIVISION.
       
       CALL "greet" USING WS-NOM, WS-RESULT.
       DISPLAY WS-RESULT.
       
       CALL "counchar" USING WS-NOM, WS-COUNT.
       DISPLAY WS-COUNT.

           STOP RUN. 


