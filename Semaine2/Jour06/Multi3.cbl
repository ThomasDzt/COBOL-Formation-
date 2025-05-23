      *Exercice: Créer un programme qui affiche tous les multiples de 3
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Multi3.
       AUTHOR. ThomasD.


       ENVIRONMENT DIVISION.
       

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *Création des variables numériques pour l'itération, le résultat
      *de la division par 3 et le stockage du reste

       01  WS-VAR      PIC 9(3).
       01  WS-RES      PIC 9(3).
       01  WS-REM      PIC 9(3).


       PROCEDURE DIVISION.
       
       DISPLAY "Les multiples de 3 sont: "
       
      *Création de la boucle affichant les multiples de 3 de 1 à 100
       PERFORM VARYING WS-VAR FROM 1 BY 1 UNTIL WS-VAR = 101
           PERFORM 0100-MULTI3-START THRU 0100-MULTI3-END

       END-PERFORM.

       STOP RUN.

      ******************************************************************
       0100-MULTI3-START .
      
      *Stockage du reste de la division de la variable par 3
           DIVIDE WS-VAR BY 3 GIVING WS-RES REMAINDER WS-REM.


      *Test de la divisibilité par 3 de la variable
           IF WS-REM = 0

      *Affichage de la variable si c'est un multiple de 3
               DISPLAY WS-VAR
           
           ELSE 
               CONTINUE 
           
           END-IF.

       0100-MULTI3-END .

           EXIT.
