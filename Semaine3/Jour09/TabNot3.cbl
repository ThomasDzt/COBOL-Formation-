      *Exercice : Saisir 3 notes dans un tableau via ACCEPT
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TabNot3.
       AUTHOR. ThomasD.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS-TABLEAU.
           03 WS-ELEVE OCCURS 3 TIMES.
               05 WS-NOTE PIC 9(2).
               05 WS-NOM  PIC X(20).

       77 WS-INDEX    PIC 9.


       PROCEDURE DIVISION.

       PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX > 3
           
           DISPLAY "Saisir le nom de l'élève :"
           ACCEPT WS-NOM(WS-INDEX)
           DISPLAY "Saisir la note :"
           ACCEPT WS-NOTE(WS-INDEX)
           

       END-PERFORM.

       DISPLAY "Tableau de notes".
       DISPLAY WS-TABLEAU.
       


       PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX > 3
           
           DISPLAY "WS-ELEVE" WS-INDEX
           DISPLAY WS-NOM(WS-INDEX) 
           DISPLAY WS-NOTE(WS-INDEX)
           

       END-PERFORM.

       STOP RUN.


  
       
