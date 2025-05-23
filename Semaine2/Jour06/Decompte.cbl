      *Exercice: Décompte de 1 à 10.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Decompte.
       AUTHOR. ThomasD.

       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      
      *Création d'une variable numérique.
       01  WS-VAR    PIC 9(2).


       PROCEDURE DIVISION.
       
      * Création de la boucle pour la variable allant de 1 à 10
       PERFORM VARYING WS-VAR FROM 1 BY 1 UNTIL WS-VAR = 11
      
      *Appel du paragraphe P-COUNT jusqu'au paragraphe FIN-TRAITEMENT.
           PERFORM P-COUNT THROUGH FIN-TRAITEMENT

       END-PERFORM.

       STOP RUN.


      *****************************************************************
      *Paragraphe affichant la variable créée.
       P-COUNT .
           DISPLAY WS-VAR.

      *Paragraphant indiquant la sortie de boucle
       FIN-TRAITEMENT .
           EXIT.

       