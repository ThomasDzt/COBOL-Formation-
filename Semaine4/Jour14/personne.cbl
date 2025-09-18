      * Exercice : Lecture d’un fichier texte – Liste de personnes

       IDENTIFICATION DIVISION.
       PROGRAM-ID. personne.
       AUTHOR. Thomas.
       DATE-WRITTEN. 18/09/2025 (fr).

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       SELECT FICHIER-PERSONNE ASSIGN TO "personnes.txt"
       ORGANIZATION IS LINE SEQUENTIAL.


       DATA DIVISION.

       FILE SECTION.

       FD FICHIER-PERSONNE.

       01 F-LIGNE  PIC X(50).


       WORKING-STORAGE SECTION.

       01 WS-TABLEAU-PERSONNE.
           05 WS-LIGNE OCCURS 10 TIMES INDEXED BY WS-IDX2.
               10 WS-NOM           PIC X(15).
               10 WS-PRENOM        PIC X(15).
               10 WS-DATE. 
                   15 WS-JOUR      PIC 9(02).
                   15 FILLER       PIC X           VALUE "/".
                   15 WS-MOIS      PIC 9(02).
                   15 FILLER       PIC X           VALUE "/".
                   15 WS-ANNEE     PIC 9(04).
       

       77 WS-IDX                   PIC 9(02).
      *77 WS-IDX2                  PIC 9(02).  *> Sans INDEXED BY 

       01 WS-MAX                   PIC 9(02).
           
       01 WS-CHERCHE-NOM           PIC X(15).
       01 WS-TEMP                  PIC X(15).


       01 WS-FIN-LECTURE           PIC X.
           88 WS-FIN-LECTURE-N                     VALUE "N".    
           88 WS-FIN-LECTURE-O                     VALUE "O".      

       01 WS-NOM-TROUVE            PIC X.
           88 WS-NOM-TROUVE-N                     VALUE "N".    
           88 WS-NOM-TROUVE-O                     VALUE "O".      


       01 WS-ENTETE.
           05 WS-ENTETE-NOM       PIC X(15)        VALUE "Nom".
           05 WS-ENTETE-PRENOM    PIC X(15)        VALUE "Prenom".
           05 WS-ENTETE-DATE      PIC X(10)        VALUE "Date".


       
       PROCEDURE DIVISION.

           PERFORM 0100-LECTURE-FICHIER-DEB
              THRU 0100-LECTURE-FICHIER-FIN.

           PERFORM 0200-TRI-TABLEAU-DEB
              THRU 0200-TRI-TABLEAU-FIN. 

           PERFORM 0300-AFFICHAGE-TABLEAU-DEB
              THRU 0300-AFFICHAGE-TABLEAU-FIN.  

           PERFORM 0400-RECHERCHE-NOM-DEB
              THRU 0400-RECHERCHE-NOM-FIN.

           STOP RUN.

      ******************************************************************
      *                          PARAGRAPHES                           * 
      ****************************************************************** 

       0100-LECTURE-FICHIER-DEB.
           
           SET WS-FIN-LECTURE-N TO TRUE.
           MOVE 10 TO WS-MAX.
           INITIALIZE WS-IDX.

           DISPLAY "Ouverture du fichier...".
           OPEN INPUT FICHIER-PERSONNE.
           
           DISPLAY "Lecture du fichier...".
           PERFORM UNTIL WS-FIN-LECTURE-O
               READ FICHIER-PERSONNE

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
           
           DISPLAY "Fermeture du fichier".
           CLOSE FICHIER-PERSONNE.
           EXIT.
       
       0100-LECTURE-FICHIER-FIN.
       
      *-----------------------------------------------------------------

       0200-TRI-TABLEAU-DEB.
           
      * Méthode 1 : Sans SORT (et donc sans INDEXED BY).

      *    PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > WS-MAX - 1
      *        
      *        
      *        PERFORM VARYING WS-IDX2 FROM 1 BY 1
      *        UNTIL WS-IDX2 > WS-MAX - WS-IDX  
      *            
      *            IF WS-NOM(WS-IDX2 + 1) < WS-NOM(WS-IDX2)

      *                MOVE WS-NOM(WS-IDX2 + 1) TO WS-TEMP
      *                MOVE WS-NOM(WS-IDX2) TO WS-NOM(WS-IDX2 + 1)
      *                MOVE WS-TEMP TO WS-NOM(WS-IDX2)

      *                MOVE WS-PRENOM(WS-IDX2 + 1) TO WS-TEMP
      *                MOVE WS-PRENOM(WS-IDX2) TO WS-PRENOM(WS-IDX2 + 1)
      *                MOVE WS-TEMP TO WS-PRENOM(WS-IDX2)
      *                
      *                MOVE WS-DATE(WS-IDX2 + 1) TO WS-TEMP
      *                MOVE WS-DATE(WS-IDX2) TO WS-DATE(WS-IDX2 + 1)
      *                MOVE WS-TEMP TO WS-DATE(WS-IDX2)
      *            END-IF 
      *        END-PERFORM 

      *    END-PERFORM.

      * Méthode 2 : Avec SORT

           SORT WS-LIGNE ON ASCENDING KEY WS-NOM.
           

           EXIT.
       0200-TRI-TABLEAU-FIN.


      *-----------------------------------------------------------------

       0300-AFFICHAGE-TABLEAU-DEB.
           
           DISPLAY "Affichage des données du fichier lu : ".
           DISPLAY WS-ENTETE-NOM  
                   WS-ENTETE-PRENOM WITH NO ADVANCING 
                   WS-ENTETE-DATE.

           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > WS-MAX 
               
               DISPLAY WS-NOM(WS-IDX) WITH NO ADVANCING
                       WS-PRENOM(WS-IDX) WITH NO ADVANCING
                       WS-DATE(WS-IDX)
           END-PERFORM.
           
           EXIT.
       0300-AFFICHAGE-TABLEAU-FIN.



      *-----------------------------------------------------------------

       0400-RECHERCHE-NOM-DEB.
       
           DISPLAY "Recherche par nom.".

           DISPLAY "Veuillez saisir un nom : ".
           ACCEPT WS-CHERCHE-NOM.

      * Méthode 1 : Sans SEARCH (et donc sans INDEXED BY).

      *    SET WS-NOM-TROUVE-N TO TRUE.

      *    PERFORM VARYING WS-IDX FROM 1 BY 1 
      *    UNTIL WS-IDX > WS-MAX 
      *    OR WS-NOM-TROUVE-O 
      *    
      *        IF FUNCTION UPPER-CASE (WS-CHERCHE-NOM) = WS-NOM(WS-IDX)
      *            DISPLAY "Personne correspondante trouvée."
      *            SET WS-NOM-TROUVE-O TO TRUE 

      *            DISPLAY WS-ENTETE-NOM WITH NO ADVANCING
      *                    WS-ENTETE-PRENOM WITH NO ADVANCING 
      *                    WS-ENTETE-DATE

      *            DISPLAY WS-NOM(WS-IDX) WITH NO ADVANCING
      *                    WS-PRENOM(WS-IDX) WITH NO ADVANCING
      *                    WS-DATE(WS-IDX)
      *        
      *        END-IF 
      *    END-PERFORM.


      * Méthode 2 : Avec SEARCH
           
           SEARCH WS-LIGNE 
               
               AT END 
                   DISPLAY "Aucune personne trouvée à ce nom."

               WHEN FUNCTION UPPER-CASE(WS-CHERCHE-NOM) =WS-NOM(WS-IDX2)
                   DISPLAY "Personne correspondante trouvée."
                   DISPLAY WS-NOM(WS-IDX2) WITH NO ADVANCING
                           WS-PRENOM(WS-IDX2) WITH NO ADVANCING
                           WS-DATE(WS-IDX2)
                   
               
           END-SEARCH.

           EXIT.

       0400-RECHERCHE-NOM-FIN.




