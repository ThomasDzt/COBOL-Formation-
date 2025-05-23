       IDENTIFICATION DIVISION.
       PROGRAM-ID. Notes.
       AUTHOR.ThomasD.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01  WS-TABLEAU-NOTES.
           03 WS-NOTES PIC 9(2) OCCURS 100 TIMES.
           03 FILLER  PIC X(10).
           
           03 WS-DATE OCCURS 100 TIMES.
               05 WS-JOUR      PIC 9(2).
               05 FILLER  PIC X(1)    VALUE "/".
               05 WS-MOIS      PIC 9(2).
               05 FILLER  PIC X(1)    VALUE "/".
               05 WS-ANNEE     PIC 9(4).
               05 FILLER  PIC X(1).
           

       01  WS-INDEX-NOTES  PIC 9.
       01  WS-COMPTEUR     PIC 9(3)    VALUE ZERO.

       01  WS-ARRET   PIC X    VALUE "N".
           88 WS-ARRET-Y       VALUE "Y" OR "y".
           88 WS-ARRET-N       VALUE "N" OR "n".


       PROCEDURE DIVISION.
       
       PERFORM VARYING WS-INDEX-NOTES
               FROM 1 BY 1 UNTIL WS-ARRET = "Y" OR "y"
           
           ADD 1 TO WS-COMPTEUR 
           DISPLAY "Saisir une note"
           ACCEPT WS-NOTES(WS-INDEX-NOTES)
           DISPLAY "Saisir la date associée"
           ACCEPT WS-JOUR(WS-INDEX-NOTES)
           ACCEPT WS-MOIS(WS-INDEX-NOTES)
           ACCEPT WS-ANNEE(WS-INDEX-NOTES)

           DISPLAY "S'arrêter ?"
           ACCEPT WS-ARRET 

       END-PERFORM.

       PERFORM VARYING WS-INDEX-NOTES 
               FROM 1 BY 1 UNTIL WS-INDEX-NOTES > WS-COMPTEUR

           DISPLAY "Note : " WS-NOTES(WS-INDEX-NOTES) " le " 
           WS-DATE(WS-INDEX-NOTES)
       END-PERFORM.
       STOP RUN.
