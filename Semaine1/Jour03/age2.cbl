      * Programme qui invite à saisir l'âge d'une personne et de la 
      * classer selon ce dernier.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. age2.
       AUTHOR. Thomas. 

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       
       WORKING-STORAGE SECTION.
       01 WS-AGE   PIC 9(03).


       PROCEDURE DIVISION.
           
           PERFORM 0100-SAISIE-AGE-DEB
              THRU 0100-SAISIE-AGE-FIN.
           
           PERFORM 0200-TEST-CLASSE-AGE-DEB
              THRU 0200-TEST-CLASSE-AGE-FIN.
           
           STOP RUN.

      ******************************************************************
      *                         PARAGRAPHES                            * 
      ******************************************************************

       0100-SAISIE-AGE-DEB.

           DISPLAY "Entrez votre âge :".
           ACCEPT WS-AGE.

           EXIT.
       0100-SAISIE-AGE-FIN.
      *----------------------------------------------------------------- 

       0200-TEST-CLASSE-AGE-DEB. 

           EVALUATE WS-AGE 

               WHEN >= 0 AND <= 11
                   DISPLAY "Vous êtes un enfant."

               WHEN >= 12 AND <= 17
                   DISPLAY "Vous êtes un adolescent."
               
               WHEN >= 18 AND <= 64
                   DISPLAY "Vous êtes un adulte."
           
               WHEN OTHER 
               DISPLAY "Vous êtes un senior."

           END-EVALUATE.

           EXIT.
       0200-TEST-CLASSE-AGE-FIN. 
      *----------------------------------------------------------------- 










