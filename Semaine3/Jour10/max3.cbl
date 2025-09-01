      * Écrire un programme qui demande à l'utilisateur de saisir trois
      * nombres, puis qui affiche le plus grand des trois.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. max3.
       AUTHOR. Thomas.


       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       
       WORKING-STORAGE SECTION.
       
      * Tableau de saisie des nombres.
       01 WS-TABLEAU.
           05 WS-LIGNE-TABLEAU OCCURS 3 TIMES.

      * Nombre saisi par l'utilisateur après contrôle de saisie.
               10 WS-NBR           PIC 9(02).

      * Saisie du nombre par l'utilisateur.
               10 WS-NBR-SAISI     PIC X(05).
       
      * Index pour parcourir le tableau.
       77 WS-IDX               PIC 9(02).

      * Nombre maximal saisi par l'utilisateur.
       01 WS-MAX               PIC 9(02).

      * Flag pour gérer la boucle lors du contrôle de saisie.
       01 WS-SAISIE-OK         PIC X.
           88 WS-SAISIE-OK-O           VALUE "O".
           88 WS-SAISIE-OK-N           VALUE "N".




       PROCEDURE DIVISION.

           PERFORM 0100-CHERCHE-MAX-DEB
              THRU 0100-CHERCHE-MAX-FIN.


           STOP RUN.




      ******************************************************************
      *                          PARAGRAPHES                           * 
      ****************************************************************** 

       0100-CHERCHE-MAX-DEB.
           
           INITIALIZE WS-MAX.

      * Parcours du tableau de nombres.
           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 3

              PERFORM 0200-SAISIE-NOMBRE-DEB
                 THRU 0200-SAISIE-NOMBRE-FIN 
       
      * Comparaison du nombre saisi avec le maximum. 
      * Si le nombre saisi est supérieur au maximum, il devient le 
      * nouveau maximum.
              IF WS-NBR(WS-IDX) > WS-MAX 
                  MOVE WS-NBR(WS-IDX) TO WS-MAX 
              END-IF  

           END-PERFORM.
           
           DISPLAY "Nombre maximal saisi : " WITH NO ADVANCING 
                   WS-MAX.
           EXIT.
       0100-CHERCHE-MAX-FIN.

      *-----------------------------------------------------------------
       
       0200-SAISIE-NOMBRE-DEB.

           SET WS-SAISIE-OK-N TO TRUE.

           PERFORM UNTIL WS-SAISIE-OK-O

               DISPLAY "Veuillez saisir un nombre de 2 chiffres max : "
               ACCEPT WS-NBR-SAISI(WS-IDX)
               
      * Contrôle de saisie du nombre entré par l'utilisateur.
               PERFORM 0300-TEST-LONGUEUR-DEB
                  THRU 0300-TEST-LONGUEUR-FIN 

           END-PERFORM.
           EXIT.

       0200-SAISIE-NOMBRE-FIN.

      *-----------------------------------------------------------------
       
       0300-TEST-LONGUEUR-DEB.

           IF FUNCTION LENGTH(FUNCTION TRIM(WS-NBR-SAISI(WS-IDX))) > 2
               DISPLAY "Erreur : le nombre saisi a plus de 2 chiffres."

           ELSE 
               MOVE WS-NBR-SAISI(WS-IDX) TO WS-NBR(WS-IDX)
               SET WS-SAISIE-OK-O TO TRUE 

           END-IF
           EXIT.

       0300-TEST-LONGUEUR-FIN.
       




