       IDENTIFICATION DIVISION.
       PROGRAM-ID. Means.
       AUTHOR. ThomasD.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  NUMBER1 PIC 9(2).
       01  NUMBER2 PIC 9(2).
       01  NUMBER3 PIC 9(2).
       01  RESULT  PIC Z(5).


       PROCEDURE DIVISION.
       
      *On calcule l'opération voulue
           
           DISPLAY "Entrez un premier chiffre".
           ACCEPT NUMBER1.
           
           DISPLAY "Entrez un autre chiffre".
           ACCEPT NUMBER2.

           DISPLAY "Entrez un autre chiffre".
           ACCEPT NUMBER3.

           MOVE FUNCTION MEAN(NUMBER1,NUMBER2,NUMBER3) TO RESULT.
           
           DISPLAY "Le résultat de la moyenne est " 
           FUNCTION TRIM(RESULT).
           
              

       STOP RUN.  
