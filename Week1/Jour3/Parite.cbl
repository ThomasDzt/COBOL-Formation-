      *Exercice : ce nombre est-il pair ou impair ?
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Parite.
       AUTHOR. ThomasD.
       
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *Déclaration de la variable numérique 
       01 WS-NUM        PIC 9(4).
       01 WS-RES        PIC 9(4).
       01 WS-REM        PIC 9(4).
       
       
       PROCEDURE DIVISION.

      *Saisie du nombre à tester
           DISPLAY "Entrez un nombre".
           ACCEPT WS-NUM.
      
      *Division du nombre par 2
           DIVIDE WS-NUM 
           BY 2 
           GIVING WS-RES
           REMAINDER WS-REM
           END-DIVIDE.
       
      *DISPLAY WS-REM.
      *Test de la parité du nombre saisi
       IF WS-REM = 0
           DISPLAY "Le nombre saisi est pair"
       
       ELSE 
           DISPLAY "Le nombre saisi est impair"

       END-IF.

       STOP RUN.
       
       



