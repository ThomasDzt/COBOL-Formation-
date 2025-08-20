      * Programme qui invite à saisir un nombre et qui vérifie la 
      * parité de ce dernier.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. parite2.
       AUTHOR. Thomas. 

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       
       WORKING-STORAGE SECTION.
       01 WS-NBR       PIC 9(02).
       01 WS-QUOTIENT  PIC 9(02).
       01 WS-RESTE     PIC 9(02).

       PROCEDURE DIVISION.
           
           PERFORM 0100-SAISIE-NBR-DEB
              THRU 0100-SAISIE-NBR-FIN.
           
           PERFORM 0200-CALCUL-RESTE-DEB
              THRU 0200-CALCUL-RESTE-FIN.

           PERFORM 0300-TEST-PARITE-NBR-DEB
              THRU 0300-TEST-PARITE-NBR-FIN.
           
           STOP RUN.

      ******************************************************************
      *                         PARAGRAPHES                            * 
      ******************************************************************

       0100-SAISIE-NBR-DEB.

           DISPLAY "Entrez un nombre :".
           ACCEPT WS-NBR.

           EXIT.
       0100-SAISIE-NBR-FIN.
      *----------------------------------------------------------------- 
       
       0200-CALCUL-RESTE-DEB.
           
           DIVIDE WS-NBR BY 2 GIVING WS-QUOTIENT REMAINDER WS-RESTE.

           EXIT.
       0200-CALCUL-RESTE-FIN.

      *----------------------------------------------------------------- 

       0300-TEST-PARITE-NBR-DEB. 
           
           IF WS-RESTE = 0 

               DISPLAY "Le nombre saisi est pair."

           ELSE 
               DISPLAY "Le nombre saisi est impair."

           END-IF. 
       
           EXIT.
       0300-TEST-PARITE-NBR-FIN. 
      *----------------------------------------------------------------- 










