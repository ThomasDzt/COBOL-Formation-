      *Exercice : Lire un fichier eleves et créer un fichier réussite avec uniquement les élèves ayant eu plus de 10.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. reussite.
       AUTHOR. ThomasD.


       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

      *Création de l'alias du fichier eleves.txt que l'on va lire  
       SELECT FICHIER-ELEVES ASSIGN TO "eleves.txt"

      *Lecture du fichier ligne par ligne 
       ORGANIZATION IS LINE SEQUENTIAL.

       SELECT FICHIER-REUSSITE ASSIGN TO "reussite.txt"
       ORGANIZATION IS LINE SEQUENTIAL.




       DATA DIVISION.
       FILE SECTION.

      *Description du fichier (de l'alias du fichier) utilisé 
       FD FICHIER-ELEVES.

           01 F-LIGNE-ELEVES.
               05 F-LIGNE-NOM      PIC X(10).
               05 F-LIGNE-NOTE     PIC 9(2).


       FD FICHIER-REUSSITE.
           
           01 F-LIGNE-REUSSITE.
               05 F-REUSSITE-NOM   PIC X(10).
               05 F-REUSSITE-NOTE  PIC 9(2).




       WORKING-STORAGE SECTION.
       
      *Création du tableau dans lequel on va stocker les données lues
      *pour les afficher 
       
       
       01 WS-TABLEAU-ELEVES  OCCURS 15 TIMES.
           05 WS-NOM      PIC X(10).
           05 WS-NOTE     PIC 9(2).


      *Création de l'index pour le tableau et d'une variable indiquant
      *la valeur maximale que celui-ci peut prendre  

       77  WS-INDEX-TABLEAU  PIC 9(2)    VALUE 1.

       77  WS-MAX-TABLEAU    PIC 9(2)    VALUE 15.

      *Création d'une variable permettant la sortie de boucle à la fin 
      *lecture du fichier 
       01  WS-FIN-LECTURE    PIC X       VALUE "N".





       PROCEDURE DIVISION.

      *Ouverture du fichier txt pour la lecture
       DISPLAY "Ouverture du fichier :"
       OPEN INPUT FICHIER-ELEVES.

      *Boucle pour lire le fichier ligne par ligne jusqu'à la dernière
       DISPLAY "Lecture du fichier ligne par ligne :"
       PERFORM UNTIL WS-FIN-LECTURE = "Y"
           
           READ FICHIER-ELEVES

      *On termine la boucle à la fin de lecture du fichier 
             AT END 
               MOVE "Y" TO WS-FIN-LECTURE

      *On ajoute les données de chaque ligne 
      *au tableau créé pour l'affichage et on incrémente l'index 

             NOT AT END
               IF WS-INDEX-TABLEAU <= WS-MAX-TABLEAU 

                   MOVE F-LIGNE-NOM 
                    TO  WS-NOM(WS-INDEX-TABLEAU)

                   MOVE F-LIGNE-NOTE 
                    TO  WS-NOTE(WS-INDEX-TABLEAU) 
                   
                   ADD 1 TO WS-INDEX-TABLEAU 

               END-IF

           END-READ 

       END-PERFORM.

       CLOSE FICHIER-ELEVES.


        
      *Affichage du tableau avec les données du fichier lu 

       DISPLAY "   Nom    " WITH NO ADVANCING "Note"
       
       PERFORM VARYING WS-INDEX-TABLEAU FROM 1 BY 1 
                                UNTIL WS-INDEX-TABLEAU > WS-MAX-TABLEAU
           
           DISPLAY WS-NOM(WS-INDEX-TABLEAU) 
           SPACES WITH NO ADVANCING 


           DISPLAY WS-NOTE(WS-INDEX-TABLEAU)

       END-PERFORM.
       
       DISPLAY "Fin de lecture".


       
       MOVE 1 TO WS-INDEX-TABLEAU.

      *Ouverture de l'alias du fichier reussite.txt

       OPEN OUTPUT FICHIER-REUSSITE.

      *Ajout des élèves ayant plus de 10 au fichier reussite

       PERFORM VARYING WS-INDEX-TABLEAU FROM 1 BY 1 
               UNTIL   WS-INDEX-TABLEAU > WS-MAX-TABLEAU

           IF WS-NOTE(WS-INDEX-TABLEAU) > 10 
           

               MOVE WS-NOM(WS-INDEX-TABLEAU)
                TO  F-REUSSITE-NOM 

               MOVE WS-NOTE(WS-INDEX-TABLEAU)
                TO  F-REUSSITE-NOTE 
           
                WRITE F-LIGNE-REUSSITE
           END-IF 
           
           

       END-PERFORM.

      *Fermeture du fichier

       CLOSE FICHIER-REUSSITE.
       
      *Fin de programme 
       STOP RUN.


