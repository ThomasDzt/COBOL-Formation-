      *Exercice: Décompte de 1 à 10.
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Decompte2.
       AUTHOR. ThomasD.

       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      
      *Création d'une variable numérique.
       01  WS-VAR    PIC 9(2) VALUE ZERO.


       PROCEDURE DIVISION.
       
       
      * Création de la boucle pour la variable allant de 1 à 10
       PERFORM 10 TIMES

      *Appel du paragraphe P-COUNT jusqu'au paragraphe FIN-TRAITEMENT.
           PERFORM P-COUNT THROUGH FIN-TRAITEMENT

       END-PERFORM.

       STOP RUN.


      *****************************************************************
      *Paragraphe itérant puis affichant la variable créée.
       P-COUNT .
           ADD 1 TO WS-VAR.
           DISPLAY WS-VAR.
           
      *Paragraphant indiquant la sortie de boucle
       FIN-TRAITEMENT .
           EXIT.

       