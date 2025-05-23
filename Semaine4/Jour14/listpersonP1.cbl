      *Exercice : Lecture d'un fichier texte- Liste de personnes
       IDENTIFICATION DIVISION.
       PROGRAM-ID. listpersonP1.
       AUTHOR. ThomasD.



       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       SELECT FICHIER-PERSONNES ASSIGN TO "personnes.txt"
       ORGANIZATION IS LINE SEQUENTIAL.


       DATA DIVISION.
       FILE SECTION.

       FD FICHIER-PERSONNES.
       01 F-LIGNE-FICHIER.
           05 F-NOM-FICHIER        PIC X(15). 
           05 F-PRENOM-FICHIER     PIC X(15).
           05 F-DATE-FICHIER       PIC X(8).



       WORKING-STORAGE SECTION.
       
       01  WS-TABLEAU-PERSONNES    OCCURS 10 TIMES.
           05 WS-NOM        PIC X(15).
           05 WS-PRENOM     PIC X(15).
           05 WS-DATE       PIC X(8).

       
       77  WS-INDEX-TABLEAU  PIC 9(2)    VALUE 1.
       77  WS-MAX-TABLEAU    PIC 9(2)    VALUE 10.

       01  WS-FIN-LECTURE    PIC X       VALUE "N".



       PROCEDURE DIVISION.

       DISPLAY "Ouverture du fichier :".
       OPEN INPUT FICHIER-PERSONNES.


       DISPLAY "Lecture du fichier :".

       PERFORM UNTIL WS-FIN-LECTURE = "Y"
           READ FICHIER-PERSONNES

             AT END 
               MOVE "Y" TO WS-FIN-LECTURE
             
             NOT AT END 
               IF WS-INDEX-TABLEAU <= WS-MAX-TABLEAU
               
                   MOVE F-NOM-FICHIER TO WS-NOM(WS-INDEX-TABLEAU)
                   MOVE F-PRENOM-FICHIER TO WS-PRENOM(WS-INDEX-TABLEAU)
                   MOVE F-DATE-FICHIER TO WS-DATE(WS-INDEX-TABLEAU)

                   ADD 1 TO WS-INDEX-TABLEAU 
               END-IF 

           END-READ 
    
       END-PERFORM.

       CLOSE FICHIER-PERSONNES.


       PERFORM VARYING WS-INDEX-TABLEAU FROM 1 BY 1 
               UNTIL WS-INDEX-TABLEAU > WS-MAX-TABLEAU

           DISPLAY "Nom    : " WS-NOM(WS-INDEX-TABLEAU) 
           SPACES WITH NO ADVANCING 


           DISPLAY "Prenom : " WS-PRENOM(WS-INDEX-TABLEAU)

       END-PERFORM.

       DISPLAY "Fin de lecture"

       STOP RUN.



