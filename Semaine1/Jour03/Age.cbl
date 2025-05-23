       IDENTIFICATION DIVISION.
       PROGRAM-ID. Age.
       AUTHOR. ThomasD.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
      *Déclaration de la variable numérique âge
       01 WS-AGE PIC 9(3).

       PROCEDURE DIVISION.

      *Saisie de l'âge par l'utilisateur
           DISPLAY "Entrez votre âge".
           ACCEPT WS-AGE.


      *Test de l'âge de l'utilisateur et catégorisation
         
      *     IF WS-AGE LESS THAN 12 OR EQUAL TO 12
           EVALUATE WS-AGE
               WHEN <= 12
               DISPLAY "Vous êtes un enfant"

      *     ELSE IF WS-AGE GREATER THAN 12 AND LESS THAN 18
               WHEN > 12 AND < 18
               DISPLAY "Vous êtes un adolescent"

      *     ELSE IF WS-AGE GREATER THAN 18 AND LESS THAN 65 
      *     OR EQUAL TO 18
               WHEN >= 18 AND < 65
               DISPLAY "Vous êtes un adulte"

      *     ELSE IF WS-AGE GREATER THAN 65 OR WS-AGE EQUAL TO 65
               WHEN OTHER
               DISPLAY "Vous êtes un senior"

      *     END-IF.
           END-EVALUATE.
       STOP RUN.



