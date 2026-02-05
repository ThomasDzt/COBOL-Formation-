      *Lire un fichier inventaire.txt, extraire les articles en rupture
      * (STOCK = 0) et les écrire dans rupture.txt

       IDENTIFICATION DIVISION.
       PROGRAM-ID. rupture2.
       AUTHOR. Thomas.
       DATE-WRITTEN. 05/02/2026 (fr).


       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       SELECT FICHIER-INVENTAIRE ASSIGN TO "inventaire.txt"
       ORGANIZATION IS LINE SEQUENTIAL.

       SELECT FICHIER-RUPTURE ASSIGN TO "rupture2.txt"
       ORGANIZATION IS LINE SEQUENTIAL.


       DATA DIVISION.

       FILE SECTION.
       FD FICHIER-INVENTAIRE.
           01  F-LIGNE-INV         PIC X(30).

       FD FICHIER-RUPTURE.
           01 F-LIGNE-RUP          PIC X(12).


       WORKING-STORAGE SECTION.

       01 WS-TABLEAU.
           05  WS-LIGNE OCCURS 15 TIMES.
               10  WS-OBJET        PIC X(10).
               10  WS-STOCK        PIC 9(02).

       77 WS-IDX                   PIC 9(02).
       77 WS-IDX2                  PIC 9(02).
       01 WS-MAX                   PIC 9(02).

       01 WS-FIN-LECTURE           PIC X.
           88 WS-FIN-LECTURE-N             VALUE "N".
           88 WS-FIN-LECTURE-O             VALUE "O".

       
       01 WS-ENTETE.
           05  WS-ENTETE-ARTICLE   PIC X(08). *> taille variable selon
           05  WS-ENTETE-STOCK     PIC X(08). *> le texte à saisir.


       01 WS-TEMP                  PIC X(10).

       01 WS-TEXTE-OUVERTURE       PIC X(23).
       01 WS-TEXTE-FERMETURE       PIC X(21).
       01 WS-TEXTE-CONTENU         PIC X(21).


       PROCEDURE DIVISION.
           
           PERFORM 0050-INITIALISATION-DEB
              THRU 0050-INITIALISATION-FIN.

           PERFORM 0100-LECTURE-INVENTAIRE-DEB
              THRU 0100-LECTURE-INVENTAIRE-FIN.

           PERFORM 0200-TRI-INVENTAIRE-DEB
              THRU 0200-TRI-INVENTAIRE-FIN.

           PERFORM 0300-AFFICHE-INVENTAIRE-DEB
              THRU 0300-AFFICHE-INVENTAIRE-FIN.

           PERFORM 0400-ECRITURE-FICHIER-DEB
              THRU 0400-ECRITURE-FICHIER-FIN.

           STOP RUN.

      ******************************************************************
      *                          PARAGRAPHES                           *
      ******************************************************************
           
       0050-INITIALISATION-DEB.
           
           MOVE 15 TO WS-MAX.
           SET WS-FIN-LECTURE-N TO TRUE.
           INITIALIZE WS-IDX.
           
           MOVE "Ouverture du fichier : " TO WS-TEXTE-OUVERTURE.
           MOVE "Fermeture du fichier."   TO WS-TEXTE-FERMETURE.
           MOVE "Contenu du fichier : "   TO WS-TEXTE-CONTENU.
           MOVE "Article "                TO WS-ENTETE-ARTICLE.
           MOVE "Stock"                   TO WS-ENTETE-STOCK.

           
           EXIT.

       0050-INITIALISATION-FIN.
      *-----------------------------------------------------------------

       0100-LECTURE-INVENTAIRE-DEB.
           
           OPEN INPUT FICHIER-INVENTAIRE.
           DISPLAY WS-TEXTE-OUVERTURE.
           
           PERFORM UNTIL WS-FIN-LECTURE-O
               
               READ FICHIER-INVENTAIRE

                   AT END
                       SET WS-FIN-LECTURE-O TO TRUE
       
                   NOT AT END  
                       IF WS-IDX <= WS-MAX 
                           
                           ADD 1 TO WS-IDX 
                           
                           MOVE F-LIGNE-INV(1:10) TO WS-OBJET(WS-IDX)
                           MOVE F-LIGNE-INV(11:2) TO WS-STOCK(WS-IDX)
                       END-IF  

               END-READ
           END-PERFORM.
           
           CLOSE FICHIER-INVENTAIRE.
           DISPLAY WS-TEXTE-FERMETURE.

           EXIT.


       0100-LECTURE-INVENTAIRE-FIN.
      *-----------------------------------------------------------------

       0200-TRI-INVENTAIRE-DEB.
           
           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > WS-MAX - 1

               PERFORM VARYING WS-IDX2 FROM 1 BY 1 
               UNTIL WS-IDX2 > WS-MAX - WS-IDX 
                   
                   IF WS-OBJET(WS-IDX2 + 1) < WS-OBJET(WS-IDX2)
                       
                       MOVE WS-OBJET(WS-IDX2 + 1) TO WS-TEMP 
                       MOVE WS-OBJET(WS-IDX2) TO WS-OBJET(WS-IDX2 + 1)
                       MOVE WS-TEMP TO WS-OBJET(WS-IDX2)

                       MOVE WS-STOCK(WS-IDX2 + 1) TO WS-TEMP 
                       MOVE WS-STOCK(WS-IDX2) TO WS-STOCK(WS-IDX2 + 1)
                       MOVE WS-TEMP TO WS-STOCK(WS-IDX2)


                   END-IF 
               END-PERFORM  
           END-PERFORM.

           EXIT.

       0200-TRI-INVENTAIRE-FIN.
      *-----------------------------------------------------------------
       
       0300-AFFICHE-INVENTAIRE-DEB.

           DISPLAY WS-TEXTE-CONTENU.           
           DISPLAY WS-ENTETE-ARTICLE
                   WS-ENTETE-STOCK.

           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > WS-MAX 
               
               DISPLAY WS-OBJET(WS-IDX) 
                       WS-STOCK(WS-IDX)

           END-PERFORM.
           EXIT.

       0300-AFFICHE-INVENTAIRE-FIN.
      *-----------------------------------------------------------------

       0400-ECRITURE-FICHIER-DEB.

           OPEN OUTPUT FICHIER-RUPTURE.
           DISPLAY WS-TEXTE-OUVERTURE.
               
           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > WS-MAX
               
               IF WS-STOCK(WS-IDX) NOT = 0
                   MOVE WS-OBJET(WS-IDX) TO F-LIGNE-RUP(1:10)
                   MOVE WS-STOCK(WS-IDX) TO F-LIGNE-RUP(11:2)

                   WRITE F-LIGNE-RUP 

               END-IF 


           END-PERFORM.

           CLOSE FICHIER-RUPTURE.
           DISPLAY WS-TEXTE-FERMETURE.


           EXIT.

       0400-ECRITURE-FICHIER-FIN.

