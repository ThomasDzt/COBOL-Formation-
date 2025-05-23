      *Exercice : Lire un fichier 'inventaire.txt', 
      *extraire les articles en rupture (`STOCK = 0`) et les écrire dans `rupture.txt`

       IDENTIFICATION DIVISION. 
       PROGRAM-ID. rupture.
       AUTHOR. ThomasD.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

      *Création de l'alias correspondant au fichier 'inventaire.txt' 
       SELECT FICHIER-INVENTAIRE ASSIGN TO "inventaire.txt"

      *Lecture du fichier ligne par ligne
       ORGANIZATION IS LINE SEQUENTIAL.

      *Création de l'alias correspondant au fichier qui va être créé
       SELECT FICHIER-RUPTURE ASSIGN TO "rupture.txt"

      *Ecriture du fichier ligne par ligne
       ORGANIZATION IS LINE SEQUENTIAL.



      *------------------------------DATA------------------------------- 
       DATA DIVISION.
       FILE SECTION.

      *Description des fichiers créés (groupe de variables article et stock)

       FD FICHIER-INVENTAIRE.
           01 F-LIGNE-INVENTAIRE.
               05 F-LIGNE-ARTICLE  PIC X(10).
               05 F-LIGNE-STOCK    PIC X(2).

       FD FICHIER-RUPTURE.
           01 F-LIGNE-RUPTURE.
               05 F-RUPTURE-ARTICLE  PIC X(10).
      *         05 F-RUPTURE-STOCK    PIC 9(2).
       
       WORKING-STORAGE SECTION.
      
      *Création du tableau dans lequel on va stocker les données lues
      *pour les afficher

       01 WS-TABLEAU-INVENTAIRE OCCURS 15 TIMES.

           05 WS-ARTICLE   PIC X(10).
           05 WS-STOCK     PIC 9(2).

       
      *Création de l'index pour le tableau et d'une variable indiquant
      *la valeur maximale que celui-ci peut prendre  

       77  WS-INDEX-TABLEAU  PIC 9(2)    VALUE 1.

       77  WS-MAX-TABLEAU    PIC 9(2)    VALUE 15. 


      *Création d'une variable permettant la sortie de boucle à la fin 
      *lecture du fichier 

       01  WS-FIN-LECTURE    PIC X       VALUE "N". 



      *--------------------------PROCEDURE------------------------------ 
       PROCEDURE DIVISION.

      *Ouverture du fichier txt pour la lecture
       DISPLAY "Ouverture du fichier :"
       OPEN INPUT FICHIER-INVENTAIRE.

      *Boucle pour lire le fichier ligne par ligne jusqu'à la dernière
       DISPLAY "Lecture du fichier ligne par ligne :"
       PERFORM UNTIL WS-FIN-LECTURE = "Y"
           
           READ FICHIER-INVENTAIRE

      *On termine la boucle à la fin de lecture du fichier 
             AT END 
               MOVE "Y" TO WS-FIN-LECTURE

      *On ajoute les données de chaque ligne 
      *au tableau créé pour l'affichage et on incrémente l'index 

             NOT AT END
               IF WS-INDEX-TABLEAU <= WS-MAX-TABLEAU 

                   MOVE F-LIGNE-ARTICLE 
                    TO  WS-ARTICLE(WS-INDEX-TABLEAU)

                   MOVE FUNCTION NUMVAL (F-LIGNE-STOCK) 
                    TO  WS-STOCK(WS-INDEX-TABLEAU) 
                   
                   ADD 1 TO WS-INDEX-TABLEAU 

               END-IF

           END-READ 

       END-PERFORM.

      *Fermeture du fichier  
       CLOSE FICHIER-INVENTAIRE.



      *Affichage du tableau avec les données du fichier lu 

       DISPLAY "Article  " WITH NO ADVANCING "Stock".
       
       PERFORM VARYING WS-INDEX-TABLEAU FROM 1 BY 1 
                                UNTIL WS-INDEX-TABLEAU > WS-MAX-TABLEAU
           
           DISPLAY WS-ARTICLE(WS-INDEX-TABLEAU) 
           SPACES WITH NO ADVANCING 


           DISPLAY WS-STOCK(WS-INDEX-TABLEAU)

       END-PERFORM.
       
       DISPLAY "Fin de lecture". 


      *Ouverture du fichier dans lequel on va écrire
       OPEN OUTPUT FICHIER-RUPTURE.

       MOVE 1 TO WS-INDEX-TABLEAU.

      *Extraction des articles en rupture de stock et écriture du fichier
       PERFORM VARYING WS-INDEX-TABLEAU FROM 1 BY 1 
               UNTIL   WS-INDEX-TABLEAU > WS-MAX-TABLEAU

           IF WS-STOCK(WS-INDEX-TABLEAU) = 0
               MOVE WS-ARTICLE(WS-INDEX-TABLEAU) 
                TO  F-RUPTURE-ARTICLE  

               WRITE F-LIGNE-RUPTURE
           END-IF

       END-PERFORM.        

      *Fermeture du fichier dans lequel on a écrit
       CLOSE FICHIER-RUPTURE.  

      *Fin de programme 
       STOP RUN. 

   