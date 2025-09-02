      * Écrire un programme qui calcule la conjecture de Syracuse à 
      * partir d’un nombre entier non nul saisi par l’utilisateur, 
      * jusqu’à ce que ce nombre atteigne 1.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. syracuse.
       AUTHOR. Thomas.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * Nombre saisi par l'utilisateur.
       01 WS-NBR           PIC 9(03).

      * Résultat de l'opération effectuée selon la parité du nombre.
       01 WS-RESULTAT      PIC 9(04).
       
      * Flag pour gérer la boucle lors du contrôle de saisie.
       01 WS-SAISIE-OK         PIC X.
           88 WS-SAISIE-OK-O           VALUE "O".
           88 WS-SAISIE-OK-N           VALUE "N".


       PROCEDURE DIVISION.

           PERFORM 0100-SAISIE-NOMBRE-DEB
              THRU 0100-SAISIE-NOMBRE-FIN

           STOP RUN.

       
      ******************************************************************
      *                          PARAGRAPHES                           * 
      ****************************************************************** 

       0100-SAISIE-NOMBRE-DEB.

           SET WS-SAISIE-OK-N TO TRUE.

      * Boucle jusqu'à ce que la saisie du nombre soit correcte.
           PERFORM UNTIL WS-SAISIE-OK-O
               
               DISPLAY "Veuillez saisir un nombre (entre 1 et 99) : " 
               WITH NO ADVANCING
               ACCEPT WS-NBR

               IF WS-NBR = 0 OR WS-NBR > 99 
                   DISPLAY "Erreur de saisie."

               ELSE 
                   SET WS-SAISIE-OK-O TO TRUE 

                   PERFORM 0200-BOUCLE-PRINCIP-DEB
                      THRU 0200-BOUCLE-PRINCIP-FIN

               END-IF

           END-PERFORM.

           EXIT.

       0100-SAISIE-NOMBRE-FIN.

      *-----------------------------------------------------------------

       0200-BOUCLE-PRINCIP-DEB.

      * Boucle jusqu'à ce que le nombre soit égal à 1.
           PERFORM UNTIL WS-NBR = 1 

               PERFORM 0300-TEST-PARITE-DEB
                  THRU 0300-TEST-PARITE-FIN

           END-PERFORM.

           EXIT.

       0200-BOUCLE-PRINCIP-FIN.

      *-----------------------------------------------------------------
       
       0300-TEST-PARITE-DEB.

      * Opérations à mener selon la parité du nombre, tel qu'énoncé 
      * dans la conjecture de Syracuse.
           IF FUNCTION MOD(WS-NBR,2) = 0 
               
               COMPUTE WS-RESULTAT = WS-NBR / 2

           ELSE
               COMPUTE WS-RESULTAT = 3 * WS-NBR + 1
               
           END-IF.

      * Affichage du nombre obtenu après opération.      
           MOVE WS-RESULTAT TO WS-NBR.
           DISPLAY WS-NBR.
           EXIT.

       0300-TEST-PARITE-FIN.























