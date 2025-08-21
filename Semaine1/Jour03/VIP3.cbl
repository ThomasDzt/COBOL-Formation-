      * Reprise de l'exercice VIP: Créer un programme demandant le type 
      * de client (VIP ou Standard)  et son solde, puis afficher un  
      * message selon ces règles : VIP >10000 → premium, 
      * VIP ≤10000 → privilégié, Standard >5000 → fidèle, 
      * sinon → standard.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. VIP3.
       AUTHOR. Thomas.

       ENVIRONMENT DIVISION.


       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * Flag pour définir le type de client. 
       01 WS-TYPE-CLIENT       PIC 9.
           88 WS-CLIENT-VIP                VALUE 1.
           88 WS-CLIENT-STD                VALUE 2.

       01 WS-SOLDE             PIC 9(06).

      * Flag pour contrôler la fin de boucle.
       01 WS-QUITTER           PIC X.
           88 WS-QUITTER-O                 VALUE "O".
           88 WS-QUITTER-N                 VALUE "N".
           


       PROCEDURE DIVISION. 
           
           SET WS-QUITTER-N TO TRUE.

      * Boucle jusqu'à ce que l'utilisateur quitte.

           PERFORM UNTIL WS-QUITTER-O

               PERFORM 0100-SAISIE-CLIENT-DEB
                  THRU 0100-SAISIE-CLIENT-FIN

           END-PERFORM.

           STOP RUN.

      ******************************************************************
      *                         PARAGRAPHES                            * 
      ******************************************************************

       0100-SAISIE-CLIENT-DEB.

           DISPLAY "Quel type de client êtes-vous ?".
           DISPLAY "1-VIP     2-Standard".
           ACCEPT WS-TYPE-CLIENT.
       
           PERFORM 0200-AFFI-CATEG-DEB
              THRU 0200-AFFI-CATEG-FIN.

           EXIT.

       0100-SAISIE-CLIENT-FIN.

      *-----------------------------------------------------------------

       0200-AFFI-CATEG-DEB.

      * Catégorisation du client selon son type et son solde.

           IF WS-CLIENT-VIP
               
              PERFORM 0300-SAISIE-SOLDE-DEB
                 THRU 0300-SAISIE-SOLDE-FIN

               EVALUATE WS-SOLDE             
                   WHEN > 10000
                       DISPLAY "Vous êtes un client premium."

                   WHEN OTHER 
                       DISPLAY "Vous êtes un client privilégié."

               END-EVALUATE 

           ELSE
               IF WS-CLIENT-STD
                   
                   PERFORM 0300-SAISIE-SOLDE-DEB
                      THRU 0300-SAISIE-SOLDE-FIN

                   EVALUATE  WS-SOLDE 
                       WHEN > 5000
                           DISPLAY "Vous êtes un client fidèle."
       
                       WHEN OTHER  
                           DISPLAY "Vous êtes un client standard."
       
                   END-EVALUATE  

               ELSE 
                   DISPLAY "Veuillez choisir une option entre 1 et 2."
               
               END-IF 
           END-IF. 
           
      * Demande d'arrêt de la boucle à l'utilisateur. 

           DISPLAY "Voulez-vous quitter ? (O/N)".
           ACCEPT WS-QUITTER.
          
           EXIT. 

       0200-AFFI-CATEG-FIN. 

      *-----------------------------------------------------------------

       0300-SAISIE-SOLDE-DEB.

           DISPLAY "Quel est votre solde ?".
           ACCEPT WS-SOLDE.

           EXIT.
       0300-SAISIE-SOLDE-FIN. 
      *-----------------------------------------------------------------

