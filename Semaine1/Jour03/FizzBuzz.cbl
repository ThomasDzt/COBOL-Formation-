      *Création du programme FizzBuzz
       IDENTIFICATION DIVISION.
       PROGRAM-ID.FizzBuzz.
       AUTHOR. ThomasD.


       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *Création de la variable numérique.
       01  WS-NUM        PIC 9(3)    VALUE 1.
       01  WS-REM1       PIC 9(3).
       01  WS-REM2       PIC 9(3).
       01  WS-RES1       PIC 9(3).
       01  WS-RES2       PIC 9(3).

       01 WS-TOP-FIZZ     PIC X    VALUE "N".
           88 FIZZ-OK              VALUE "O".
           88 FIZZ-KO              VALUE "N".
           

       01 WS-TOP-BUZZ     PIC X    VALUE "N".
           88 BUZZ-OK              VALUE "O".
           88 BUZZ-KO              VALUE "N".
           

       


       PROCEDURE DIVISION.
       

       PERFORM MD-FB UNTIL WS-NUM = 101.
       PERFORM FIN-TRAITEMENT.

       MD-FB .
           SET FIZZ-KO TO TRUE.    
           SET BUZZ-KO TO TRUE.
           
           DIVIDE WS-NUM BY 3 GIVING WS-RES1 REMAINDER WS-REM1
           END-DIVIDE.
        
           DIVIDE WS-NUM BY 5 GIVING WS-RES2 REMAINDER WS-REM2
           END-DIVIDE.

           EVALUATE  WS-REM1
                WHEN = 0 
                    
                    SET FIZZ-OK TO TRUE 
                    
                WHEN OTHER 
                    
                    CONTINUE
           END-EVALUATE.


           EVALUATE  WS-REM2
                WHEN = 0
                    
                    SET BUZZ-OK TO TRUE 
                    
                WHEN OTHER 
                    
                    CONTINUE
           END-EVALUATE.


           IF FIZZ-OK AND BUZZ-OK
               DISPLAY "FizzBuzz"
           END-IF.

           IF FIZZ-OK AND BUZZ-KO
               DISPLAY "Fizz"
           END-IF.

           IF FIZZ-KO AND BUZZ-OK
               DISPLAY "Buzz"
           END-IF.

           IF FIZZ-KO AND BUZZ-KO
               DISPLAY "WS-NUM : " WS-NUM
           END-IF.

           ADD 1 TO WS-NUM.
               
           
           EXIT.

       FIN-TRAITEMENT .

           STOP RUN.


