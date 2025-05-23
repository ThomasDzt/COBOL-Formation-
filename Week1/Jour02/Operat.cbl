       IDENTIFICATION DIVISION.
       PROGRAM-ID. Operat.
       AUTHOR. ThomasD.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  NUMBER1 PIC 9(2).
       01  NUMBER2 PIC 9(2).
       01  RESULT  PIC 9(4).

       PROCEDURE DIVISION.
       
      *On calcule l'opération voulue
           
           DISPLAY "Entrez un premier chiffre".
           ACCEPT NUMBER1.
           
           DISPLAY "Entrez un autre chiffre".
           ACCEPT NUMBER2.

     

           COMPUTE RESULT = NUMBER1 + NUMBER2.
           DISPLAY RESULT.   
              

       STOP RUN.       
