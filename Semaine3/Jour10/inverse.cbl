      * Demander à l'utilisateur de saisir un mot, puis inverser ce mot 
      * et afficher le résultat.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. inverse.
       AUTHOR. Thomas.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
      * Mot à saisir par l'utilisateur représenté par un tableau pour 
      * pour lequel chaque élément représente une lettre du mot saisi.
       01 WS-MOT.
           05 WS-LETTRE    OCCURS 10 TIMES PIC X.

      * Index pour parcourir les lettres du mot saisi. Les deux sont
      * nécessaires pour parcourir le mot dans les 2 sens et donc 
      * échanger les lettres de début et de fin de mot.
       77 WS-IDX           PIC 9(02).
       77 WS-IDX2          PIC 9(02).

      * Représente la longueur du mot saisi.
       77 WS-LONG          PIC 9(02).

      * Variable pour stocker temporairement une lettre du mot saisi et 
      * permettre son échange avec une autre lettre.
       01 WS-TEMPO         PIC X.


       PROCEDURE DIVISION.

           PERFORM 0100-SAISIE-MOT-DEB
              THRU 0100-SAISIE-MOT-FIN.

           PERFORM 0200-INVERSE-MOT-DEB
              THRU 0200-INVERSE-MOT-FIN.   
           
           STOP RUN.

      ******************************************************************
      *                          PARAGRAPHES                           * 
      ****************************************************************** 
 
       0100-SAISIE-MOT-DEB.

           DISPLAY "Veuillez saisir un mot : ".
           ACCEPT WS-MOT.
           
      * Détermination de la longueur du mot.
           MOVE FUNCTION LENGTH(FUNCTION TRIM(WS-MOT)) TO WS-LONG.
      
      * Retrait des espaces restants si le mot saisi fait moins de 10 
      * caractères (taille de la variable WS-MOT).
           MOVE FUNCTION TRIM(WS-MOT) TO WS-MOT.
           
           EXIT.
           
           DISPLAY "Longueur : " WS-LONG.
           DISPLAY "Mot saisi : " WS-MOT.

       0100-SAISIE-MOT-FIN.
       
      *-----------------------------------------------------------------

       0200-INVERSE-MOT-DEB.
           
           PERFORM VARYING WS-IDX FROM WS-LONG BY -1 
           UNTIL WS-IDX < WS-IDX2 OR WS-IDX = WS-IDX2
               
               DISPLAY "Index : " WS-IDX

               COMPUTE WS-IDX2 = WS-LONG - WS-IDX + 1

               MOVE WS-LETTRE(WS-IDX2) TO WS-TEMPO
               MOVE WS-LETTRE(WS-IDX) TO WS-LETTRE(WS-IDX2)
               MOVE WS-TEMPO TO WS-LETTRE(WS-IDX)
               
               DISPLAY "Mot : " WS-MOT

           END-PERFORM. 
           
           DISPLAY "Mot inversé : " WS-MOT.
                   
           EXIT.

       0200-INVERSE-MOT-FIN.

      *-----------------------------------------------------------------
