      * programme qui affiche les nombres de 1 à 100 avec les exceptions
      * suivantes : 
      * Pour les multiples de 3, on affiche 'Fizz' à la place du nombre. 
      * Pour les multiples de 5, on affiche 'Buzz' à la place du nombre. 
      * Pour les multiples de 3 et 5, on affiche 'FizzBuzz' à la place. 

       IDENTIFICATION DIVISION.
       PROGRAM-ID. fizbuz2.
       AUTHOR. Thomas.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
       01 WS-IDX               PIC 9(03).
       01 WS-IDX-EDT           PIC Z(03).

       01 WS-FIZBUZ            PIC X(08).
       01 WS-QUOTIENT-3        PIC 9(02).
       01 WS-RESTE-3           PIC 9(01).
       01 WS-QUOTIENT-5        PIC 9(02).
       01 WS-RESTE-5           PIC 9(01).

       PROCEDURE DIVISION.

           PERFORM 0100-COMPTE-DEB
              THRU 0100-COMPTE-FIN.

           STOP RUN.

      ******************************************************************
      *                         PARAGRAPHES                            * 
      ******************************************************************
       
       0100-COMPTE-DEB.
           
           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 100
               
               PERFORM 0200-DIVISION-DEB
                  THRU 0200-DIVISION-FIN

               PERFORM 0300-FIZBUZ-DEB
                  THRU 0300-FIZBUZ-FIN
               
               DISPLAY FUNCTION TRIM (WS-FIZBUZ)

           END-PERFORM.

           EXIT.
       0100-COMPTE-FIN.

      *-----------------------------------------------------------------

       0200-DIVISION-DEB.
           
           DIVIDE WS-IDX BY 3 GIVING WS-QUOTIENT-3 REMAINDER WS-RESTE-3.

           DIVIDE WS-IDX BY 5 GIVING WS-QUOTIENT-5 REMAINDER WS-RESTE-5.

           EXIT.
       0200-DIVISION-FIN.
      *-----------------------------------------------------------------

       0300-FIZBUZ-DEB.
           
           EVALUATE TRUE 
                   
               WHEN WS-RESTE-3 = 0 OR WS-RESTE-5 = 0

                   EVALUATE TRUE 

                       WHEN WS-RESTE-5 NOT = 0
                           MOVE "Fizz" TO WS-FIZBUZ

                       WHEN WS-RESTE-3 NOT = 0
                           MOVE "Buzz" TO WS-FIZBUZ
                       
                       WHEN OTHER 
                           MOVE "FizzBuzz" TO WS-FIZBUZ
                           
                   END-EVALUATE 
                   
               WHEN OTHER 
                   MOVE WS-IDX TO WS-IDX-EDT
                   MOVE WS-IDX-EDT TO WS-FIZBUZ

           END-EVALUATE.
           
           EXIT.
       0300-FIZBUZ-FIN.
      *-----------------------------------------------------------------







     









