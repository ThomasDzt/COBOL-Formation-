      * Lire un fichier d'élèves eleves.txt (Nom, Note) et créer un 
      * fichier reussit2.txt avec uniquement les élèves ayant plus de 10

       IDENTIFICATION DIVISION.
       PROGRAM-ID. reussit2.
       AUTHOR. Thomas.
       DATE-WRITTEN. 20/01/2026 (fr).

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       SELECT FICHIER-ELEVES ASSIGN TO "eleves.txt"
       ORGANIZATION IS LINE SEQUENTIAL.

       SELECT FICHIER-REUSSI ASSIGN TO "reussit2.txt"
       ORGANIZATION IS LINE SEQUENTIAL.


       DATA DIVISION.

       FILE SECTION.

       FD FICHIER-ELEVES.
           
           01 F-LIGNE-ELEVE            PIC X(20).

       FD FICHIER-REUSSI.
           
           01 F-LIGNE-REUSSI           PIC X(12).


       WORKING-STORAGE SECTION.

       01 WS-TABLEAU.
           05 WS-LIGNE  OCCURS 15 TIMES.
               10 WS-NOM               PIC X(10).
               10 WS-NOTE              PIC 9(02).

       77 WS-IDX                       PIC 9(02).
       77 WS-IDX2                      PIC 9(02).
       77 WS-MAX                       PIC 9(02).

       01 WS-TEMP                      PIC X(10).

       01 WS-FIN-LECTURE               PIC X.
           88 WS-FIN-LECTURE-N                     VALUE "N".
           88 WS-FIN-LECTURE-O                     VALUE "O".

       01 WS-ENTETE.
           05 WS-ENTETE-NOM            PIC X(10)   VALUE "Nom".  
           05 WS-ENTETE-NOTE           PIC X(10)   VALUE "Note".  
       
       
       01 WS-TEXTE-OUVERTURE           PIC X(23).
       01 WS-TEXTE-FERMETURE           PIC X(21).
       01 WS-TEXTE-CONTENU             PIC X(21).

       PROCEDURE DIVISION.

           PERFORM 0100-LIRE-FICHIER-ELEVES-DEB
              THRU 0100-LIRE-FICHIER-ELEVES-FIN.
           
           PERFORM 0200-TRI-FICHIER-ELEVES-DEB
              THRU 0200-TRI-FICHIER-ELEVES-FIN.

           PERFORM 0300-AFFICHE-FICHIER-DEB
              THRU 0300-AFFICHE-FICHIER-FIN.
           
           PERFORM 0400-ECRIRE-FICHIER-REUSSI-DEB
              THRU 0400-ECRIRE-FICHIER-REUSSI-FIN.
       
           STOP RUN.
      
      ******************************************************************
      *                            PARAGRAPHES                         *
      ******************************************************************

       0100-LIRE-FICHIER-ELEVES-DEB.

           SET WS-FIN-LECTURE-N TO TRUE.
           INITIALIZE WS-IDX.
           MOVE 15 TO WS-MAX.
           MOVE "Ouverture du fichier : " TO WS-TEXTE-OUVERTURE.
           MOVE "Fermeture du fichier." TO WS-TEXTE-FERMETURE.


           DISPLAY WS-TEXTE-OUVERTURE.
           OPEN INPUT FICHIER-ELEVES.
           
           PERFORM UNTIL WS-FIN-LECTURE-O
               READ FICHIER-ELEVES 
                   AT END 
                       SET WS-FIN-LECTURE-O TO TRUE 

                   NOT AT END 
                       IF WS-IDX <= WS-MAX 
                           
                           ADD 1 TO WS-IDX 
                           MOVE F-LIGNE-ELEVE(1:10) TO WS-NOM(WS-IDX)
                           MOVE F-LIGNE-ELEVE(11:2) TO WS-NOTE(WS-IDX)

                       END-IF 
               END-READ 
           END-PERFORM.

           DISPLAY WS-TEXTE-FERMETURE.
           CLOSE FICHIER-ELEVES.

           EXIT.

       0100-LIRE-FICHIER-ELEVES-FIN.

      *-----------------------------------------------------------------
       
       0200-TRI-FICHIER-ELEVES-DEB.

           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > WS-MAX - 1
               PERFORM VARYING WS-IDX2 FROM 1 BY 1 
               UNTIL WS-IDX2 > WS-MAX - WS-IDX
                   
                   IF WS-NOM(WS-IDX2 + 1) < WS-NOM(WS-IDX2)

                       MOVE WS-NOM(WS-IDX2 + 1) TO WS-TEMP
                       MOVE WS-NOM(WS-IDX2) TO WS-NOM(WS-IDX2 + 1)
                       MOVE WS-TEMP TO WS-NOM(WS-IDX2)
                       
                       MOVE WS-NOTE(WS-IDX2 + 1) TO WS-TEMP
                       MOVE WS-NOTE(WS-IDX2) TO WS-NOTE(WS-IDX2 + 1)
                       MOVE WS-TEMP TO WS-NOTE(WS-IDX2)

                   END-IF 
               END-PERFORM 
           END-PERFORM.

           EXIT.

       0200-TRI-FICHIER-ELEVES-FIN.



      *-----------------------------------------------------------------

       0300-AFFICHE-FICHIER-DEB.
           
           MOVE "Contenu du fichier : " TO WS-TEXTE-CONTENU.

           DISPLAY WS-TEXTE-CONTENU.
           DISPLAY WS-ENTETE-NOM
                   WS-ENTETE-NOTE.

           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > WS-MAX 
               DISPLAY WS-NOM(WS-IDX)
                       WS-NOTE(WS-IDX)
                       
           END-PERFORM.

           EXIT.

       0300-AFFICHE-FICHIER-FIN.
      *-----------------------------------------------------------------

       0400-ECRIRE-FICHIER-REUSSI-DEB.
           
           SET WS-FIN-LECTURE-N TO TRUE.
           OPEN OUTPUT FICHIER-REUSSI.
           DISPLAY WS-TEXTE-OUVERTURE.
           
           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > WS-MAX 
               
               IF WS-NOTE(WS-IDX) > 10 
                   MOVE WS-NOM(WS-IDX) TO F-LIGNE-REUSSI(1:10)
                   MOVE WS-NOTE(WS-IDX) TO F-LIGNE-REUSSI(11:2)

                   WRITE F-LIGNE-REUSSI    

               END-IF 

           END-PERFORM.

           CLOSE FICHIER-REUSSI.
           DISPLAY WS-TEXTE-FERMETURE.
           EXIT. 

       0400-ECRIRE-FICHIER-REUSSI-FIN.
