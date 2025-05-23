      * Exercice écriture de fichier 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. inversegens.
       AUTHOR. ThomasD.


       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL. 

      *Création de l'alias du fichier que l'on va lire 
       SELECT FICHIER-GENS ASSIGN TO "gens.txt"

      *Lecture du fichier ligne par ligne 
       ORGANIZATION IS LINE SEQUENTIAL.

      *Création de l'alias du fichier que l'on va écrire
       SELECT FICHIER-GENS-INVERSE ASSIGN TO "gens-inverse.txt"
       
      *Ecriture du fichier ligne par ligne 
       ORGANIZATION IS LINE SEQUENTIAL.


       DATA DIVISION.
       FILE SECTION.

      *Description du fichier (de l'alias du fichier) utilisé
       FD FICHIER-GENS.
       01 F-LIGNE-FICHIER.
           05 F-NOM-FICHIER        PIC X(12).
           05 F-PRENOM-FICHIER     PIC X(12).


       FD FICHIER-GENS-INVERSE.
       01 F-LIGNE-INVERSE.
           05 F-NOM-INVERSE        PIC X(12).
           05 F-PRENOM-INVERSE     PIC X(12).


       WORKING-STORAGE SECTION.

      *Création du tableau dans lequel on va stocker les données lues
      *pour les afficher
       01  WS-TABLEAU-GENS OCCURS 10 TIMES.
           05 WS-NOM       PIC X(12).
           05 WS-PRENOM    PIC X(12).




      *Création des index pour le tableau gens et le tableau copie et d'une variable indiquant
      *la valeur maximale que ceux-ci peuvent prendre 

       77  WS-INDEX-TABLEAU  PIC 9(2)    VALUE 1.

       77  WS-MAX-TABLEAU    PIC 9(2)    VALUE 10.

       77  WS-INDEX-INVERSE    PIC 9(2)    VALUE 1.

      *Création d'une variable permettant la sortie de boucle à la fin 
      *lecture du fichier 
       01  WS-FIN-LECTURE    PIC X       VALUE "N".

       


      
       




       PROCEDURE DIVISION.

      *Ouverture du fichier txt pour la lecture
       DISPLAY "Ouverture du fichier :"
       OPEN INPUT FICHIER-GENS.

      *Boucle pour lire le fichier ligne par ligne jusqu'à la dernière
       DISPLAY "Lecture du fichier ligne par ligne :"
       PERFORM UNTIL WS-FIN-LECTURE = "Y"

           READ FICHIER-GENS

      *On termine la boucle à la fin de lecture du fichier 
               AT END 
                   MOVE "Y" TO WS-FIN-LECTURE

      *On ajoute les données de chaque ligne 
      *au tableau créé pour l'affichage et on incrémente l'index
               NOT AT END
                 IF WS-INDEX-TABLEAU <= WS-MAX-TABLEAU 
                  MOVE F-NOM-FICHIER TO WS-NOM(WS-INDEX-TABLEAU)
                  MOVE F-PRENOM-FICHIER TO WS-PRENOM(WS-INDEX-TABLEAU)
                  ADD 1 TO WS-INDEX-TABLEAU
                 END-IF 

           END-READ 

       END-PERFORM.

       CLOSE FICHIER-GENS.

       
      *Affichage du tableau avec les données du fichier lu 
       PERFORM VARYING WS-INDEX-TABLEAU FROM 1 BY 1 
                                UNTIL WS-INDEX-TABLEAU > WS-MAX-TABLEAU
           
           DISPLAY "Nom    : " WS-NOM(WS-INDEX-TABLEAU) 
           SPACES WITH NO ADVANCING 


           DISPLAY "Prenom : " WS-PRENOM(WS-INDEX-TABLEAU)

       END-PERFORM.
       
       DISPLAY "Fin de lecture".



       OPEN OUTPUT FICHIER-GENS-INVERSE.

       PERFORM VARYING WS-INDEX-INVERSE FROM WS-MAX-TABLEAU BY -1 
                 UNTIL WS-INDEX-INVERSE < 1
           
           MOVE WS-NOM(WS-INDEX-INVERSE)
           TO   F-NOM-INVERSE

           MOVE WS-PRENOM(WS-INDEX-INVERSE) 
           TO   F-PRENOM-INVERSE

           WRITE F-LIGNE-INVERSE

       END-PERFORM.

       CLOSE FICHIER-GENS-INVERSE.

       STOP RUN. 
       