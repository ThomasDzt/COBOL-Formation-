      * Demander à l’utilisateur de saisir une série de notes (de 0 
      * à 99) et leurs dates associées (au format JJ/MM/AAAA), puis 
      * afficher les données avec une mise en forme à l’aide de FILLER.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. affinote.
       AUTHOR. Thomas.
       DATE-WRITTEN. 16/09/2025 (fr).

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS-TAB.
           05 WS-LIGNE-TAB OCCURS 1 TO 100 TIMES DEPENDING ON WS-COMPTE.
               10 FILLER       PIC X(07)       VALUE "Note : ".
               10 WS-NOTE      PIC 9(02).
               10 FILLER       PIC X(04)       VALUE " le ".
               10 WS-DATE.
                   15 WS-JOUR      PIC 9(02).
                   15 FILLER       PIC X           VALUE "/".
                   15 WS-MOIS      PIC 9(02).
                   15 FILLER       PIC X           VALUE "/".
                   15 WS-ANNEE     PIC 9(04).  


       77 WS-IDX               PIC 9(03).
       01 WS-COMPTE            PIC 9(03).
       
       01 WS-CONTINUER         PIC X.
           88 WS-CONTINUER-O               VALUE "O".
           88 WS-CONTINUER-N               VALUE "N".

       01 WS-SAISIE-OK        PIC X.
           88 WS-SAISIE-OK-O               VALUE "O".
           88 WS-SAISIE-OK-N               VALUE "N".



       PROCEDURE DIVISION.
           
           PERFORM 0100-SAISIE-DEB
              THRU 0100-SAISIE-FIN.

           PERFORM 0200-AFFICHAGE-DEB
              THRU 0200-AFFICHAGE-FIN.

           STOP RUN.

      ******************************************************************
      *                          PARAGRAPHES                           *
      ******************************************************************

       0100-SAISIE-DEB.
           
           SET WS-CONTINUER-O TO TRUE.
           INITIALIZE WS-COMPTE.

           PERFORM VARYING WS-IDX FROM 1 BY 1 
           UNTIL WS-IDX = 100 
           OR WS-CONTINUER-N
               
               ADD 1 TO WS-COMPTE

               SET WS-SAISIE-OK-N TO TRUE 
               PERFORM UNTIL WS-SAISIE-OK-O
                   DISPLAY "Veuillez saisir une note (0 à 99): " 
                   WITH NO ADVANCING 
                   ACCEPT WS-NOTE(WS-IDX)
       
                   IF WS-NOTE(WS-IDX) NOT >= 0 
                   AND WS-NOTE(WS-IDX) NOT <= 99
                       DISPLAY "La note saisie est incorrecte."

                   ELSE 
                       SET WS-SAISIE-OK-O TO TRUE
                   END-IF
               END-PERFORM 

               DISPLAY "Veuillez saisir un jour : " WITH NO ADVANCING 
               ACCEPT WS-JOUR(WS-IDX)
               
               DISPLAY "Veuillez saisir un mois : " WITH NO ADVANCING 
               ACCEPT WS-MOIS(WS-IDX)

               DISPLAY "Veuillez saisir une année : " WITH NO ADVANCING 
               ACCEPT WS-ANNEE(WS-IDX)
               
               SET WS-SAISIE-OK-N TO TRUE 

               PERFORM UNTIL WS-SAISIE-OK-O
                   DISPLAY "Continuer ? (O/N)"
                   ACCEPT WS-CONTINUER

                   IF WS-CONTINUER NOT = "O" AND WS-CONTINUER NOT = "N"
                       DISPLAY "Erreur de saisie."

                   ELSE 
                       SET WS-SAISIE-OK-O TO TRUE 
                   END-IF 
               END-PERFORM

               IF WS-CONTINUER-O
                   DISPLAY "Note ajoutée."
               
               ELSE 
                   DISPLAY "Fin de saisie."
               END-IF 

           END-PERFORM.
           EXIT.
       0100-SAISIE-FIN.

      *-----------------------------------------------------------------

       0200-AFFICHAGE-DEB.
           
           PERFORM VARYING WS-IDX FROM 1 BY 1 
           UNTIL WS-IDX = WS-COMPTE 
               DISPLAY WS-LIGNE-TAB(WS-IDX)
           END-PERFORM.


           EXIT.
       0200-AFFICHAGE-FIN.









