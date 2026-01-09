      * Lecture d’un fichier texte – Liste de personnes (personnes.txt)

       IDENTIFICATION DIVISION.
       PROGRAM-ID. lirepers.
       AUTHOR. Thomas.
       DATE-WRITTEN. 06/01/2026 (fr).

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       
       SELECT FICHIER-PERSONNES ASSIGN TO "personnes.txt"
       ORGANIZATION IS LINE SEQUENTIAL.
       

       DATA DIVISION.
                  
       FILE SECTION.
       FD FICHIER-PERSONNES.
       01 F-LIGNE     PIC X(50).

       WORKING-STORAGE SECTION.

       01 WS-TABLEAU-PERSONNES.
           05 WS-LIGNE-TABLEAU OCCURS 10 TIMES.
               10 WS-NOM           PIC X(15).
               10 WS-PRENOM        PIC X(15).
               10 WS-DATE.
                   15 WS-JOUR      PIC 9(02).
                   15 FILLER       PIC X       VALUE "/".
                   15 WS-MOIS      PIC 9(02).
                   15 FILLER       PIC X       VALUE "/".
                   15 WS-ANNEE     PIC 9(04).

               10 WS-AGE           PIC 9(02).
               

       77 WS-IDX                   PIC 9(02).
       77 WS-IDX2                  PIC 9(02).
       
       01 WS-TEMP                  PIC X(15).
       01 WS-MAX                   PIC 9(02).
       
       01 WS-FIN-LECTURE           PIC X.
           88  WS-FIN-LECTURE-N                VALUE "N".   
           88  WS-FIN-LECTURE-O                VALUE "O".  

       01 WS-ENTETE.
           05 WS-ENTETE-NOM        PIC X(15)   VALUE "Nom".    
           05 WS-ENTETE-PRENOM     PIC X(15)   VALUE "Prénom".    
           05 WS-ENTETE-DATE       PIC X(10)   VALUE "Date".    

       01 WS-CHERCHE-NOM           PIC X(15).

       01 WS-NOM-TROUVE           PIC X.
           88  WS-NOM-TROUVE-N                VALUE "N".   
           88  WS-NOM-TROUVE-O                VALUE "O". 

      *01 WS-CHOIX           PIC X.
      *    88  WS-CHOIX-N                VALUE "N".   
      *    88  WS-CHOIX-O                VALUE "O". 

       PROCEDURE DIVISION.

           PERFORM 0100-LIRE-FICHIER-DEB
              THRU 0100-LIRE-FICHIER-FIN.
           
           PERFORM 0200-TRI-FICHIER-DEB 
              THRU 0200-TRI-FICHIER-FIN.
           
           PERFORM 0300-AFFICHE-TABLEAU-DEB
              THRU 0300-AFFICHE-TABLEAU-FIN.

           PERFORM 0400-RECHERCHE-NOM-DEB
              THRU 0400-RECHERCHE-NOM-FIN.

           STOP RUN.

      ******************************************************************
      *                          PARAGRAPHES                           *
      ****************************************************************** 
       
       0100-LIRE-FICHIER-DEB.
           
           SET WS-FIN-LECTURE-N TO TRUE.
           INITIALIZE WS-IDX.
           MOVE 10 TO WS-MAX.

           DISPLAY "Ouverture du fichier : ".
           OPEN INPUT FICHIER-PERSONNES.

           DISPLAY "Lecture du fichier : ".

           PERFORM UNTIL WS-FIN-LECTURE-O
           
               READ FICHIER-PERSONNES
                   AT END 
                       SET WS-FIN-LECTURE-O TO TRUE
                       DISPLAY "Fin de lecture."

                   NOT AT END
                       IF WS-IDX <= WS-MAX 

                           ADD 1 TO WS-IDX

                           MOVE F-LIGNE(1:15) TO WS-NOM(WS-IDX) 
                           MOVE F-LIGNE(16:15) TO WS-PRENOM(WS-IDX) 
                           MOVE F-LIGNE(31:2) TO WS-MOIS(WS-IDX)  
                           MOVE F-LIGNE(33:2) TO WS-JOUR(WS-IDX) 
                           MOVE F-LIGNE(35:4) TO WS-ANNEE(WS-IDX) 

                       END-IF 
               END-READ 
           END-PERFORM.
           
           DISPLAY "Fermeture du fichier."
           CLOSE FICHIER-PERSONNES.

           EXIT.
       0100-LIRE-FICHIER-FIN.

      *-----------------------------------------------------------------

       0200-TRI-FICHIER-DEB.
           

           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > WS-MAX - 1
               PERFORM VARYING WS-IDX2 FROM 1 BY 1 
               UNTIL WS-IDX2 > WS-MAX - WS-IDX 

                   IF WS-NOM(WS-IDX2 + 1) < WS-NOM(WS-IDX2)
                       MOVE WS-NOM(WS-IDX2 + 1) TO WS-TEMP 
                       MOVE WS-NOM(WS-IDX2) TO WS-NOM(WS-IDX2 + 1) 
                       MOVE WS-TEMP TO WS-NOM(WS-IDX2)


                       MOVE WS-PRENOM(WS-IDX2 + 1) TO WS-TEMP 
                       MOVE WS-PRENOM(WS-IDX2) TO WS-PRENOM(WS-IDX2 + 1) 
                       MOVE WS-TEMP TO WS-PRENOM(WS-IDX2) 


                       MOVE WS-DATE(WS-IDX2 + 1) TO WS-TEMP 
                       MOVE WS-DATE(WS-IDX2) TO WS-DATE(WS-IDX2 + 1) 
                       MOVE WS-TEMP TO WS-DATE(WS-IDX2)

                   END-IF 
      *            DISPLAY "Nom idx :" WS-NOM(WS-IDX2)
      *            DISPLAY "Nom idx2 +1 :" WS-NOM(WS-IDX2 + 1)

               END-PERFORM

           END-PERFORM.



           EXIT.

       0200-TRI-FICHIER-FIN.

      *----------------------------------------------------------------- 

       0300-AFFICHE-TABLEAU-DEB.
           
           DISPLAY "Contenu du fichier : ".
           DISPLAY WS-ENTETE-NOM 
                   WS-ENTETE-PRENOM WITH NO ADVANCING
                   WS-ENTETE-DATE.

           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > WS-MAX 
               DISPLAY WS-NOM(WS-IDX) 
                       WS-PRENOM(WS-IDX) WITH NO ADVANCING
                       WS-DATE(WS-IDX) 
               
           END-PERFORM.
           
           EXIT.
       0300-AFFICHE-TABLEAU-FIN.

      *----------------------------------------------------------------- 

       0400-RECHERCHE-NOM-DEB.

           DISPLAY "Saisir le nom recherché : ".
           ACCEPT WS-CHERCHE-NOM.
           SET WS-NOM-TROUVE-N TO TRUE.

           PERFORM UNTIL WS-NOM-TROUVE-O
               PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > WS-MAX 
                   
                   IF FUNCTION UPPER-CASE(WS-CHERCHE-NOM)=WS-NOM(WS-IDX)

                        COMPUTE WS-AGE(WS-IDX) = 2026 - WS-ANNEE(WS-IDX)
                           DISPLAY "Nom : " WS-NOM(WS-IDX)
                           DISPLAY "Prenom : " WS-PRENOM(WS-IDX)
                           DISPLAY "Age : " WS-AGE(WS-IDX)
                       
                       SET WS-NOM-TROUVE-O TO TRUE 
                   END-IF 
               END-PERFORM
           END-PERFORM.

           EXIT.

       0400-RECHERCHE-NOM-FIN.



