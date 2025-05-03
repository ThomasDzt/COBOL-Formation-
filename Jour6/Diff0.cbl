      *Exercice: Demande de saisie de nombre jusqu'à ce qu'on entre 0
      
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Diff0.
       AUTHOR. ThomasD.

       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      
      *Création d'une variable numérique.
       01  WS-VAR      PIC 9(3).

       PROCEDURE DIVISION.
       
       DISPLAY "Entrez un nombre :".
       ACCEPT WS-VAR.

      
           PERFORM UNTIL WS-VAR = 0
                 PERFORM P-DIFF0 THRU FIN-TRAITEMENT

           END-PERFORM.
       
       
           
       STOP RUN.
      *****************************************************************

       P-DIFF0 .
           DISPLAY "Entrez un nombre :".
           ACCEPT WS-VAR.

       FIN-TRAITEMENT .
           EXIT.
       
            
