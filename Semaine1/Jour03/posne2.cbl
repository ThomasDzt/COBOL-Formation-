      * Programme qui invite à saisir un nombre et vérifier son signe.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. posne2.
       AUTHOR. Thomas. 

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       
       WORKING-STORAGE SECTION.
       01 WS-NBR   PIC S9(02).


       PROCEDURE DIVISION.
           
           PERFORM 0100-SAISIE-NBR-DEB
              THRU 0100-SAISIE-NBR-FIN.
          
           PERFORM 0200-TEST-SIGNE-DEB
              THRU 0200-TEST-SIGNE-FIN.
          

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
       0200-TEST-SIGNE-DEB.
       
           IF WS-NBR GREATER THAN 0 OR EQUAL 0

               DISPLAY "Le nombre saisi est positif."

           ELSE 
           
               DISPLAY "Le nombre saisi est négatif."
               
           END-IF.

       0200-TEST-SIGNE-FIN.


