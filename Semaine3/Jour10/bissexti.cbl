      * Demander à l'utilisateur de saisir une année et vérifier si elle 
      * est bissextile.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. bissexti.
       AUTHOR. Thomas.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS-ANNEE     PIC 9(04).


       PROCEDURE DIVISION.
           
           PERFORM 0100-SAISIE-ANNEE-DEB
              THRU 0100-SAISIE-ANNEE-FIN.
              

           STOP RUN.

      ******************************************************************
      *                          PARAGRAPHES                           * 
      ****************************************************************** 
           
       0100-SAISIE-ANNEE-DEB.

           DISPLAY "Veuillez saisir une année : " WITH NO ADVANCING.
           ACCEPT WS-ANNEE.

           PERFORM 0200-TEST-BISSEXTILE-DEB
              THRU 0200-TEST-BISSEXTILE-FIN.

           EXIT.

       0100-SAISIE-ANNEE-FIN.

      *-----------------------------------------------------------------

       0200-TEST-BISSEXTILE-DEB.
           
           IF FUNCTION MOD(WS-ANNEE, 4) = 0 
           AND FUNCTION MOD(WS-ANNEE, 100) NOT = 0 
           OR FUNCTION MOD(WS-ANNEE, 400) = 0
           
               DISPLAY "L'année est bissextile."

           ELSE 
               DISPLAY "L'année n'est pas bissextile."

           END-IF.

           EXIT.

       0200-TEST-BISSEXTILE-FIN.
       