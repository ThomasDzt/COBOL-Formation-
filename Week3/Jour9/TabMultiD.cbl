      *Exercice : Saisir les notes de 3 élèves pour 4 matières dans un tableau multidimensionnel

       IDENTIFICATION DIVISION.
       PROGRAM-ID. TabMultiD.
       AUTHOR. ThomasD.


       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *Création d'un tableau de notes pour 3 élèves dans 4 matières 
       01 WS-TABLEAU.
           03 WS-ELEVE OCCURS 3 TIMES.
               05 WS-NOTE PIC 9(2).
               05 WS-NOM  PIC X(20).

           03 WS-MATIERE OCCURS 4 TIMES.
               05 WS-NOTE2 PIC 9(2).
               05 WS-NOM2  PIC X(20).

      *Création des index pour le tableau multidimensionnel 
       77 WS-INDEX1 PIC 9.
       77 WS-INDEX2 PIC 9.



       PROCEDURE DIVISION.

      *Saisie des différentes notes lorsqu'on parcourt le tableau à l'aide de deux boucles

       PERFORM VARYING WS-INDEX1 FROM 1 BY 1 UNTIL WS-INDEX1 > 3
           PERFORM VARYING WS-INDEX2 FROM 1 BY 1 UNTIL WS-INDEX2 > 4
               
               DISPLAY "Saisir une note :"
               ACCEPT WS-NOTE2(WS-INDEX2) 
           
           END-PERFORM 
           

       END-PERFORM.

      *Affichage du tableau

       DISPLAY "Tableau de notes".
       DISPLAY WS-TABLEAU.


      *Affichage des notes dans le tableau par élève et par matière
      
       PERFORM VARYING WS-INDEX1 FROM 1 BY 1 UNTIL WS-INDEX1 > 3
           
           DISPLAY "Eleve " WS-INDEX1 
           DISPLAY "Nom " WS-NOM(WS-INDEX1) 

           PERFORM VARYING WS-INDEX2 FROM 1 BY 1 UNTIL WS-INDEX2 > 4

               DISPLAY "Matière " WS-INDEX2
               DISPLAY "Note " WS-NOTE2(WS-INDEX2)
               
           END-PERFORM 
           
       END-PERFORM.

       STOP RUN.
               

