      *Exercice : Saisir 5 notes dans un tableau, calculer et afficher la moyenne
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TabNot5.
       AUTHOR. ThomasD.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *Création du tableau de notes avec la moyenne
       01 WS-TABLEAU.
           
           05 WS-NOTE PIC 9(2) OCCURS 5 TIMES.
           05 WS-MEAN PIC 9(2).

      *Création de la variable index
       77 WS-INDEX    PIC 9.
       
      *Création de la variable somme pour calculer la moyenne
       01 WS-TOTAL-SUM PIC 9(2).


      
       PROCEDURE DIVISION.

      *Initialisation de la variable somme à 0
       MOVE 0 TO WS-TOTAL-SUM.

      *On parcourt le tableau pour entrer chaque note
       PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX > 5 
           DISPLAY "Saisir la note :"
           ACCEPT WS-NOTE(WS-INDEX)

      *Ajout de chaque note à la somme     
           ADD WS-NOTE(WS-INDEX) TO WS-TOTAL-SUM

       END-PERFORM.
       
      *Calcul de la moyenne des notes 
       COMPUTE WS-MEAN = WS-TOTAL-SUM / 5.


      *Affichage du tableau
       DISPLAY "Tableau de notes".
       DISPLAY WS-TABLEAU.


      *Lecture du tableau
       PERFORM VARYING WS-INDEX FROM 1 BY 1 UNTIL WS-INDEX > 5 
           DISPLAY "Note " WS-INDEX
           DISPLAY WS-NOTE(WS-INDEX)
       END-PERFORM.

       DISPLAY "Moyenne " WS-MEAN.

       STOP RUN.
