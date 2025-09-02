      * Demander à l'utilisateur de saisir deux nombres entiers positifs
      * puis calculer et afficher leur PGCD en utilisant l'algorithme 
      * d'Euclide.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. pgcd.
       AUTHOR. Thomas.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
       01 WS-NBR1              PIC 9(03).
       01 WS-NBR2              PIC 9(03).
       01 WS-NBR1-SAISIE       PIC 9(03).
       01 WS-NBR2-SAISIE       PIC 9(03).

       01 WS-QUOT              PIC 9(03).
       01 WS-RESTE             PIC 9(03).

      * Flag pour gérer la boucle lors du contrôle de saisie.
       01 WS-SAISIE-OK         PIC X.
           88 WS-SAISIE-OK-O           VALUE "O".
           88 WS-SAISIE-OK-N           VALUE "N".



       PROCEDURE DIVISION.

           PERFORM 0100-SAISIE-NOMBRES-DEB
              THRU 0100-SAISIE-NOMBRES-FIN.

           STOP RUN.

      ******************************************************************
      *                          PARAGRAPHES                           * 
      ****************************************************************** 

       0100-SAISIE-NOMBRES-DEB.
           
           SET WS-SAISIE-OK-N TO TRUE.
           
           PERFORM UNTIL WS-SAISIE-OK-O
               
               DISPLAY "Veuillez saisir un entier positif : "
               WITH NO ADVANCING
               ACCEPT WS-NBR1-SAISIE
       
               DISPLAY "Veuillez saisir un autre entier positif : "
               WITH NO ADVANCING
               ACCEPT WS-NBR2-SAISIE
               
               IF WS-NBR1-SAISIE = 0 OR WS-NBR2-SAISIE = 0
                   DISPLAY "Erreur de saisie."

               ELSE 

                   SET WS-SAISIE-OK-O TO TRUE 

                   MOVE WS-NBR1-SAISIE TO WS-NBR1
                   MOVE WS-NBR2-SAISIE TO WS-NBR2

                   PERFORM 0200-BOUCLE-PRINCIP-DEB
                      THRU 0200-BOUCLE-PRINCIP-FIN

               END-IF 
           END-PERFORM.

           EXIT.

       0100-SAISIE-NOMBRES-FIN.

      *-----------------------------------------------------------------

       0200-BOUCLE-PRINCIP-DEB.
           
           MOVE 1 TO WS-RESTE.

           PERFORM UNTIL WS-RESTE = 0

               IF WS-NBR1 >= WS-NBR2
                   DIVIDE WS-NBR1 BY WS-NBR2 
                   GIVING WS-QUOT REMAINDER WS-RESTE
                   
      *            DISPLAY "Nombre 1 : " WS-NBR1
      *            DISPLAY "Nombre 2 : " WS-NBR2
      *            DISPLAY "Quotient : " WS-QUOT
      *            DISPLAY "Reste : " WS-RESTE
                   
                   IF WS-RESTE NOT = 0
                       MOVE WS-NBR2 TO WS-NBR1
                       MOVE WS-RESTE TO WS-NBR2
                   END-IF 

               ELSE 
                   DIVIDE WS-NBR2 BY WS-NBR1 
                   GIVING WS-QUOT REMAINDER WS-RESTE
                   
                   IF WS-RESTE NOT = 0
                       MOVE WS-NBR1 TO WS-NBR2
                       MOVE WS-RESTE TO WS-NBR1
                   END-IF 

               END-IF 
           
           END-PERFORM.
           
           IF WS-NBR1 >= WS-NBR2

               DISPLAY "PGCD de " WS-NBR1-SAISIE 
                       " et de " WS-NBR2-SAISIE 
                       " : " WS-NBR2
           
           ELSE 
               DISPLAY "PGCD de " WS-NBR1-SAISIE 
                       " et de " WS-NBR2-SAISIE 
                       " : " WS-NBR1
           END-IF. 
           EXIT.

       0200-BOUCLE-PRINCIP-FIN.       
       










