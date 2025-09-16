      * Demander à l'utilisateur de saisir un nombre entier entre 1 et 
      * 3999, puis afficher ce nombre en chiffres romains.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. chiffrom.
       AUTHOR. Thomas.
       DATE-WRITTEN. 16/09/2025 (fr).


       ENVIRONMENT DIVISION.


       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
       01 WS-NOMBRE    PIC 9(04).

       01 WS-TAB-ROM.
           05  WS-LIGNE OCCURS 13 TIMES. *> 13 symboles 
               10 WS-VALEUR      PIC 9(04). *> 1000, 900, 500, 100,...1.
               10 WS-SYMBOLE     PIC X(02). *> M, CM, CD, C,...I.
           
          
       01 WS-IDX       PIC 9(02).
       
       01 WS-QUOT      PIC 9(02).
       


       PROCEDURE DIVISION.

           PERFORM 0100-INITIALISE-DEB
              THRU 0100-INITIALISE-FIN.



           STOP RUN.


      ******************************************************************
      *                          PARAGRAPHES                           *
      ******************************************************************
       
       0100-INITIALISE-DEB.
           
           MOVE 1000 TO WS-VALEUR(1).
           MOVE "M"  TO WS-SYMBOLE(1).

           MOVE 900  TO WS-VALEUR(2).
           MOVE "CM" TO WS-SYMBOLE(2).

           MOVE 500 TO WS-VALEUR(3).
           MOVE "D" TO WS-SYMBOLE(3).

           MOVE 400  TO WS-VALEUR(4).
           MOVE "CD" TO WS-SYMBOLE(4).

           MOVE 100 TO WS-VALEUR(5).
           MOVE "C" TO WS-SYMBOLE(5).

           MOVE 90   TO WS-VALEUR(6).
           MOVE "XC" TO WS-SYMBOLE(6).

           MOVE 50  TO WS-VALEUR(7).
           MOVE "L" TO WS-SYMBOLE(7).

           MOVE 40   TO WS-VALEUR(8).
           MOVE "XL" TO WS-SYMBOLE(8).

           MOVE 10  TO WS-VALEUR(9).
           MOVE "X" TO WS-SYMBOLE(9).

           MOVE 9    TO WS-VALEUR(10).
           MOVE "IX" TO WS-SYMBOLE(10).

           MOVE 5    TO WS-VALEUR(11).
           MOVE "V"  TO WS-SYMBOLE(11).

           MOVE 4    TO WS-VALEUR(12).
           MOVE "IV" TO WS-SYMBOLE(12).

           MOVE 1   TO WS-VALEUR(13).
           MOVE "I" TO WS-SYMBOLE(13).

           
           EXIT.
       0100-INITIALISE-FIN.












