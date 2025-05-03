       IDENTIFICATION DIVISION.
       PROGRAM-ID. PosNe.
       AUTHOR. ThomasD.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *Déclaration de la variable numérique signée
       01 WS-NUMBER1   PIC S9(5).     

       PROCEDURE DIVISION.

      *Saisie du nombre par l'utilisateur
           DISPLAY "Entrez un nombre".
           ACCEPT WS-NUMBER1.
      
      *Test si le nombre saisi est supérieur ou inférieur à 0
           IF WS-NUMBER1 >= 0 
               DISPLAY "Le nombre saisi est positif"
               
           ELSE IF WS-NUMBER1 < 0
               DISPLAY "Le nombre saisi est négatif"
           
      
           END-IF.
       
       STOP RUN.
           