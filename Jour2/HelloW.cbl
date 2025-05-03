       IDENTIFICATION DIVISION.
       PROGRAM-ID. HelloW.
       AUTHOR. ThomasD.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  NAMES PIC X(10).

      
       PROCEDURE DIVISION.

      *On rajoute son nom
           DISPLAY "Entrez votre nom"
           ACCEPT NAMES.   
           DISPLAY "Hello " NAMES.
       

       STOP RUN.
