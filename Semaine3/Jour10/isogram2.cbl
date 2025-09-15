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

       01 WS-MOT-SAISI         PIC X(15).

       01 WS-MOT.
           05 WS-LETTRE-MOT    OCCURS 10 TIMES.
               10 WS-LETTRE    PIC X.

       77 WS-IDX               PIC 9(02).
       77 WS-IDX2              PIC 9(02).
       01 WS-LONGUEUR-MOT      PIC 9(02).

       01 WS-SAISIE-OK         PIC X.
           88 WS-SAISIE-OK-O           VALUE "O".
           88 WS-SAISIE-OK-N           VALUE "N".


       PROCEDURE DIVISION.
           
           PERFORM 0100-SAISIE-MOT-DEB
              THRU 0100-SAISIE-MOT-FIN.

           PERFORM 0200-VERIF-ISOGRAMME-DEB
              THRU 0200-VERIF-ISOGRAMME-FIN.

           STOP RUN. 
           

      ******************************************************************
      *                          PARAGRAPHES                           * 
      ****************************************************************** 

       0100-SAISIE-MOT-DEB.
           
           SET WS-SAISIE-OK-N TO TRUE.

           PERFORM UNTIL WS-SAISIE-OK-O

               DISPLAY "Veuillez saisir un mot (10 lettres max) : "    
               WITH NO ADVANCING
       
               ACCEPT WS-MOT-SAISI
       
               PERFORM 0150-CONTROLE-SAISIE-DEB
                  THRU 0150-CONTROLE-SAISIE-FIN
           
           END-PERFORM.
           
           MOVE FUNCTION UPPER-CASE(WS-MOT) TO WS-MOT.
           DISPLAY "Mot : " FUNCTION TRIM(WS-MOT) ".".

           EXIT.
       0100-SAISIE-MOT-FIN.

      *-----------------------------------------------------------------

       0150-CONTROLE-SAISIE-DEB.

           IF FUNCTION LENGTH(FUNCTION TRIM (WS-MOT-SAISI)) > 10
           
               DISPLAY "Erreur : le mot saisi est trop long."
           
           ELSE 
               SET WS-SAISIE-OK-O TO TRUE
               MOVE FUNCTION TRIM (WS-MOT-SAISI) TO WS-MOT 

           END-IF.
           
           EXIT.
       0150-CONTROLE-SAISIE-FIN.

      *-----------------------------------------------------------------

       0200-VERIF-ISOGRAMME-DEB.
           
           MOVE FUNCTION LENGTH (FUNCTION TRIM(WS-MOT)) 
           TO WS-LONGUEUR-MOT.

           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-LONGUEUR-MOT - 1
           ENDPERFORM.


           EXIT.
       0200-VERIF-ISOGRAMME-FIN.





