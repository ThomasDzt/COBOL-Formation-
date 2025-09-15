      * Demander à l'utilisateur de saisir un mot et vérifier s’il 
      * s'agit d'un isogramme, c’est-à-dire un mot où chaque lettre 
      * apparaît une seule fois.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. isogram2.
       AUTHOR. Thomas.
       DATE-WRITTEN. 15/09/2025 (fr).
       
       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * Saisie de l'utilisateur.
       01 WS-MOT-SAISI         PIC X(15).

      * Mot stocké sous forme de tableau après contrôle de saisie.
       01 WS-MOT.  
      *  Mot de 10 lettres maximum.
           05 WS-LETTRE-MOT    OCCURS 10 TIMES.
               10 WS-LETTRE    PIC X.

      * Index pour parcourir les lettres du mot saisi.
       77 WS-IDX               PIC 9(02). 
       77 WS-IDX2              PIC 9(02).

      * Index temporaire servant de valeur de départ à l'index 2.
       77 WS-IDX-TEMP          PIC 9(02).
       01 WS-LONGUEUR-MOT      PIC 9(02).

      * Flag pour le contrôle de saisie.
       01 WS-SAISIE-OK         PIC X.
           88 WS-SAISIE-OK-O           VALUE "O".
           88 WS-SAISIE-OK-N           VALUE "N".

      * Flag pour confirmer si le mot est un isogramme.
       01 WS-ISOGRAMME         PIC X.
           88 WS-ISOGRAMME-O           VALUE "O".
           88 WS-ISOGRAMME-N           VALUE "N".


       PROCEDURE DIVISION.
           
      * Saisie du mot par l'utilisateur.
           PERFORM 0100-SAISIE-MOT-DEB
              THRU 0100-SAISIE-MOT-FIN.

      * Vérification du mot pour savoir si c'est un isogramme ou non.
           PERFORM 0200-VERIF-ISOGRAMME-DEB
              THRU 0200-VERIF-ISOGRAMME-FIN.

           STOP RUN. 
           

      ******************************************************************
      *                          PARAGRAPHES                           * 
      ****************************************************************** 

       0100-SAISIE-MOT-DEB.
           
           SET WS-SAISIE-OK-N TO TRUE.

      * Boucle tant que la saisie n'est pas correcte.
           PERFORM UNTIL WS-SAISIE-OK-O

               DISPLAY "Veuillez saisir un mot (10 lettres max) : "    
               WITH NO ADVANCING
       
               ACCEPT WS-MOT-SAISI
       
      * Contrôle de saisie du mot.
               PERFORM 0150-CONTROLE-SAISIE-DEB
                  THRU 0150-CONTROLE-SAISIE-FIN
           
           END-PERFORM.
           
      * Conversion des lettres du mot en lettres majuscules pour 
      * pouvoir comparer efficacement les lettres du mot saisi.
           MOVE FUNCTION UPPER-CASE(WS-MOT) TO WS-MOT.

      * Affichage du mot saisi.
           DISPLAY "Mot : " FUNCTION TRIM(WS-MOT) ".".

           EXIT.
       0100-SAISIE-MOT-FIN.

      *-----------------------------------------------------------------

       0150-CONTROLE-SAISIE-DEB.
      
      * Contrôle de saisie : vérification de la longueur du mot saisi.
           EVALUATE TRUE
               WHEN FUNCTION LENGTH(FUNCTION TRIM (WS-MOT-SAISI)) > 10
                   DISPLAY "Erreur : le mot saisi est trop long."
               
               WHEN WS-MOT-SAISI = SPACES
                   DISPLAY "Erreur : aucun mot n'a été saisi."

               WHEN OTHER 
                   SET WS-SAISIE-OK-O TO TRUE
                   MOVE FUNCTION TRIM (WS-MOT-SAISI) TO WS-MOT 

           END-EVALUATE.
           
           EXIT.
       0150-CONTROLE-SAISIE-FIN.

      *-----------------------------------------------------------------

       0200-VERIF-ISOGRAMME-DEB.

      * Stockage de la longueur du mot saisi dans une variable.   
           MOVE FUNCTION LENGTH (FUNCTION TRIM(WS-MOT)) 
           TO WS-LONGUEUR-MOT.
           
           SET WS-ISOGRAMME-O TO TRUE.

      * Boucle pour sélectionner la lettre que l'on va comparer aux 
      * autres lettres.
           PERFORM VARYING WS-IDX FROM 1 BY 1 
           UNTIL WS-IDX > WS-LONGUEUR-MOT - 1
           OR WS-ISOGRAMME-N
               
      * Définition d'un indice temporaire servant de valeur de départ à 
      * l'indice 2.
               COMPUTE WS-IDX-TEMP = WS-IDX + 1
               
      * Boucle pour parcourir les lettres qui vont être comparées à 
      * la lettre sélectionnée au préalable.
               PERFORM VARYING WS-IDX2 FROM WS-IDX-TEMP  BY 1 
               UNTIL WS-IDX2 > WS-LONGUEUR-MOT
               OR WS-ISOGRAMME-N
           
      * Dès que 2 lettres sont identiques, le mot ne peut être défini 
      * comme étant un isogramme.
                   IF WS-LETTRE(WS-IDX) = WS-LETTRE(WS-IDX2)
                       SET WS-ISOGRAMME-N TO TRUE
                       
                   END-IF 
               END-PERFORM
           END-PERFORM.

       
      * Affichage du statut "isogramme" ou non à l'utilisateur.
           IF WS-ISOGRAMME-N
               DISPLAY "Ce mot n'est pas un isogramme."

           ELSE 
               DISPLAY "Ce mot est un isogramme."
               
           END-IF.
           EXIT.
       0200-VERIF-ISOGRAMME-FIN.

      *-----------------------------------------------------------------




