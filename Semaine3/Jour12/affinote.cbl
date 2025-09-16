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

      * Tableau de notes avec dates.
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

      * Variable de saisie de la note pour contrôle de saisie.
       01 WS-NOTE-TEMP         PIC S9(03).

      * Index pour parcourir le tableau.
       77 WS-IDX               PIC 9(03).

      * Variable de décompte du nombre de lignes de tableau remplies. 
       01 WS-COMPTE            PIC 9(03).
       
      * Flag de confirmation pour continuer à remplir le tableau.
       01 WS-CONTINUER         PIC X.
           88 WS-CONTINUER-O               VALUE "O".
           88 WS-CONTINUER-N               VALUE "N".

      * Flag de contrôle de saisie.
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
      
      * Remplissage du tableau ligne par ligne tant que l'utilisateur le
      * souhaite et jusqu'à ce que le tableau soit complet.
           PERFORM VARYING WS-IDX FROM 1 BY 1 
           UNTIL WS-IDX = 100 
           OR WS-CONTINUER-N

      * Incrémentation de la variable de décompte.         
               ADD 1 TO WS-COMPTE
               
               PERFORM 0150-SAISIE-NOTE-DEB
                  THRU 0150-SAISIE-NOTE-FIN

               PERFORM 0160-SAISIE-DATE-DEB
                  THRU 0160-SAISIE-DATE-FIN
               
               DISPLAY "Note ajoutée."

      * Demande à l'utilisateur s'il veut poursuivre la saisie de notes.       
               PERFORM 0170-CONTINUER-CHOIX-DEB
                  THRU 0170-CONTINUER-CHOIX-FIN

               IF WS-CONTINUER-N
                   DISPLAY "Fin de saisie."
               END-IF 

           END-PERFORM.
           EXIT.
       0100-SAISIE-FIN.

      *-----------------------------------------------------------------
       
       0150-SAISIE-NOTE-DEB.
       
           SET WS-SAISIE-OK-N TO TRUE. 
       
      * Boucle jusqu'à ce que la saisie de la note soit correcte.
           PERFORM UNTIL WS-SAISIE-OK-O
               DISPLAY "Veuillez saisir une note (0 à 99): " 
               WITH NO ADVANCING 
               ACCEPT WS-NOTE-TEMP

               IF WS-NOTE-TEMP < 0 
               OR WS-NOTE-TEMP > 99
                   DISPLAY "La note saisie est incorrecte."
       
      * Lorsque la saisie est correcte, on alimente la variable WS-NOTE
      * du tableau avec la valeur saisie.
               ELSE 
                   SET WS-SAISIE-OK-O TO TRUE
                   MOVE WS-NOTE-TEMP TO WS-NOTE(WS-IDX)
               END-IF
           END-PERFORM.

           EXIT.
       0150-SAISIE-NOTE-FIN.

      *-----------------------------------------------------------------
       
       0160-SAISIE-DATE-DEB.
           
           PERFORM 0164-SAISIE-JOUR-DEB
              THRU 0164-SAISIE-JOUR-FIN.

           PERFORM 0165-SAISIE-MOIS-DEB
              THRU 0165-SAISIE-MOIS-FIN.

           PERFORM 0166-SAISIE-ANNEE-DEB
              THRU 0166-SAISIE-ANNEE-FIN.

           EXIT.
       0160-SAISIE-DATE-FIN.
      *-----------------------------------------------------------------
           
       0164-SAISIE-JOUR-DEB.

           SET WS-SAISIE-OK-N TO TRUE.

      * Boucle jusqu'à ce que la saisie du jour soit correcte.

           PERFORM UNTIL WS-SAISIE-OK-O

               DISPLAY "Veuillez saisir un jour : " WITH NO ADVANCING 
               ACCEPT WS-JOUR(WS-IDX)

               IF  WS-JOUR(WS-IDX) NOT >= 1 
               OR WS-JOUR(WS-IDX) NOT <= 31 
                   DISPLAY "Erreur de saisie." 

               ELSE 
                   SET WS-SAISIE-OK-O TO TRUE 
               END-IF 
           END-PERFORM.
           EXIT.
       0164-SAISIE-JOUR-FIN.

      *-----------------------------------------------------------------
       
       0165-SAISIE-MOIS-DEB.
           
           SET WS-SAISIE-OK-N TO TRUE.
           
      * Boucle jusqu'à ce que la saisie du mois soit correcte.

           PERFORM UNTIL WS-SAISIE-OK-O

               DISPLAY "Veuillez saisir un mois : " WITH NO ADVANCING 
               ACCEPT WS-MOIS(WS-IDX)

               IF  WS-MOIS(WS-IDX) NOT >= 1 
               OR WS-MOIS(WS-IDX) NOT <= 12 
                   DISPLAY "Erreur de saisie." 

               ELSE 
                   SET WS-SAISIE-OK-O TO TRUE 
               END-IF
           END-PERFORM.

           EXIT.
       0165-SAISIE-MOIS-FIN.

      *-----------------------------------------------------------------
       
       0166-SAISIE-ANNEE-DEB.

           DISPLAY "Veuillez saisir une année : " WITH NO ADVANCING. 
           ACCEPT WS-ANNEE(WS-IDX).
           EXIT.
       0166-SAISIE-ANNEE-FIN.

      *-----------------------------------------------------------------

       0170-CONTINUER-CHOIX-DEB.

           SET WS-SAISIE-OK-N TO TRUE. 
               
      * Boucle jusqu'à ce que la saisie soit correcte.
           PERFORM UNTIL WS-SAISIE-OK-O
               DISPLAY "Continuer ? (O/N)"
               ACCEPT WS-CONTINUER

               IF WS-CONTINUER NOT = "O" AND WS-CONTINUER NOT = "N"
                   DISPLAY "Erreur de saisie."

               ELSE 
                   SET WS-SAISIE-OK-O TO TRUE 
               END-IF 
           END-PERFORM.           

           EXIT.
       0170-CONTINUER-CHOIX-FIN.

      *-----------------------------------------------------------------

       0200-AFFICHAGE-DEB.
           
      * Affichage des lignes remplies du tableau.
           PERFORM VARYING WS-IDX FROM 1 BY 1 
           UNTIL WS-IDX > WS-COMPTE 
               DISPLAY WS-LIGNE-TAB(WS-IDX)
           END-PERFORM.


           EXIT.
       0200-AFFICHAGE-FIN.









