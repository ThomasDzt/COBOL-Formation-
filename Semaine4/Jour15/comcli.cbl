      * Lire 2 fichiers (clients.txt, commandes.txt) et afficher les 
      * commandes par client (assume ID client commun).

      ******************************************************************
      *                            TRIGRAMMES                          *
      *----------------------------------------------------------------*
      * COM = COMMANDE ; CLI = CLIENT; NUM = NUMERO
      ******************************************************************


       IDENTIFICATION DIVISION.    
       PROGRAM-ID. comcli.
       AUTHOR. Thomas.
       DATE-WRITTEN. 11/02/2026 (fr).


       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       
       SELECT FICHIER-COM ASSIGN TO "num-commandes.txt"
       ORGANIZATION IS LINE SEQUENTIAL.
       
       SELECT FICHIER-CLI ASSIGN TO "clients.txt"
       ORGANIZATION IS LINE SEQUENTIAL.
       
       SELECT FICHIER-COM-CLI ASSIGN TO "commande-client.txt"
       ORGANIZATION IS LINE SEQUENTIAL.


       DATA DIVISION.
       FILE SECTION.
       
       FD FICHIER-COM.
           01 F-LIGNE-COM                  PIC X(30).
       
       FD FICHIER-CLI.
           01 F-LIGNE-CLI                  PIC X(30).

       FD FICHIER-COM-CLI.
           01 F-LIGNE-COM-CLI              PIC X(31).


       WORKING-STORAGE SECTION.
       
       01 WS-TABLEAU-COM.
           05 WS-LIGNE-COM OCCURS 17 TIMES.
           
      *    ID du client dans le fichier num-commandes
               10 WS-ID-COM                PIC X(03).
               10 WS-QUANTITE              PIC X(04).
               10 WS-NUM-COM               PIC X(04).

       01 WS-TABLEAU-CLI.
           05 WS-LIGNE-CLI OCCURS 10 TIMES.

      *    ID du client dans le fichier clients
               10 WS-ID-CLI                PIC X(08).
               10 WS-NOM                   PIC X(11).
               10 WS-PRENOM                PIC X(10).

       77 WS-IDX                           PIC 9(02).
       77 WS-IDX2                          PIC 9(02).

       01 WS-MAX-COM                       PIC 9(02).  
       01 WS-MAX-CLI                       PIC 9(02).  
       
       01 WS-FIN-LECTURE                   PIC X.
           88 WS-FIN-LECTURE-N                         VALUE "N".
           88 WS-FIN-LECTURE-O                         VALUE "O".      

       01 WS-ENTETE-COM.
           05  WS-ENTETE-ID-COM            PIC X(03).
           05  WS-ENTETE-QUANTITE          PIC X(11).
           05  WS-ENTETE-NUM               PIC X(09).
           05  WS-ENTETE-TTR-COM           PIC X(11).

       01 WS-ENTETE-CLI.
           05  WS-ENTETE-ID-CLI            PIC X(08).
           05  WS-ENTETE-NOM               PIC X(11).
           05  WS-ENTETE-PRENOM            PIC X(10).
           05  WS-ENTETE-TTR-CLI           PIC X(09).


       PROCEDURE DIVISION.
           
           PERFORM 0100-INITIALISATION-DEB
              THRU 0100-INITIALISATION-FIN.

           PERFORM 0200-LECTURE-FICHIERS-DEB
              THRU 0200-LECTURE-FICHIERS-FIN.

           PERFORM 0300-AFFICHAGE-FICHIERS-DEB
              THRU 0300-AFFICHAGE-FICHIERS-FIN.

           PERFORM 0400-ECRITURE-COM-PAR-CLI-DEB
              THRU 0400-ECRITURE-COM-PAR-CLI-FIN.

           STOP RUN.


      ******************************************************************
      *                           PARAGRAPHES                          *
      ******************************************************************

       0100-INITIALISATION-DEB. 
           
           MOVE 17 TO WS-MAX-COM.
           MOVE 10 TO WS-MAX-CLI.


           MOVE "ID " TO WS-ENTETE-ID-COM.
           MOVE "Quantite : " TO WS-ENTETE-QUANTITE.
           MOVE "Numero : " TO WS-ENTETE-NUM.
           MOVE "Commande : " TO WS-ENTETE-TTR-COM.

           MOVE "ID " TO WS-ENTETE-ID-CLI.
           MOVE "Nom " TO WS-ENTETE-NOM.
           MOVE "Prenom " TO WS-ENTETE-PRENOM.
           MOVE "Client : " TO WS-ENTETE-TTR-CLI.
           

           EXIT.

       0100-INITIALISATION-FIN.

      *-----------------------------------------------------------------

       0200-LECTURE-FICHIERS-DEB.

           PERFORM 0250-LECTURE-FICHIER-COM-DEB
              THRU 0250-LECTURE-FICHIER-COM-FIN.

           PERFORM 0260-LECTURE-FICHIER-CLI-DEB
              THRU 0260-LECTURE-FICHIER-CLI-FIN.

           EXIT.

       0200-LECTURE-FICHIERS-FIN.

      *-----------------------------------------------------------------

       0250-LECTURE-FICHIER-COM-DEB.
           
           SET WS-FIN-LECTURE-N TO TRUE.
           INITIALIZE WS-IDX.
           
           DISPLAY "Ouverture du fichier num-commandes".
           OPEN INPUT FICHIER-COM.
           
           DISPLAY "Lecture du fichier : ".
           PERFORM UNTIL WS-FIN-LECTURE-O
               
               READ FICHIER-COM
                   AT END 
                       SET WS-FIN-LECTURE-O TO TRUE 
                   NOT AT END 
                       IF WS-IDX <= WS-MAX-COM 
                           ADD 1 TO WS-IDX 
                           MOVE F-LIGNE-COM(1:3) TO WS-ID-COM(WS-IDX)
                           MOVE F-LIGNE-COM(4:4) TO WS-QUANTITE(WS-IDX)
                           MOVE F-LIGNE-COM(8:4) TO WS-NUM-COM(WS-IDX)
                       END-IF 
               END-READ
           END-PERFORM.

           CLOSE FICHIER-COM.



           EXIT.

       0250-LECTURE-FICHIER-COM-FIN.

      *-----------------------------------------------------------------

       0260-LECTURE-FICHIER-CLI-DEB.
           
           SET WS-FIN-LECTURE-N TO TRUE.
           INITIALIZE WS-IDX.

           DISPLAY "Ouverture du fichier clients".
           OPEN INPUT FICHIER-CLI.
           
           DISPLAY "Lecture du fichier : ".
           PERFORM UNTIL WS-FIN-LECTURE-O
               
               READ FICHIER-CLI
                   AT END 
                       SET WS-FIN-LECTURE-O TO TRUE 
                   NOT AT END 
                       IF WS-IDX <= WS-MAX-CLI 
                           ADD 1 TO WS-IDX 
                           MOVE F-LIGNE-CLI(1:8) TO WS-ID-CLI(WS-IDX)
                           MOVE F-LIGNE-CLI(9:11) TO WS-NOM(WS-IDX)
                           MOVE F-LIGNE-CLI(20:10) TO WS-PRENOM(WS-IDX)
                       END-IF 
               END-READ
           END-PERFORM.

           CLOSE FICHIER-CLI.

           EXIT.

       0260-LECTURE-FICHIER-CLI-FIN.

      *-----------------------------------------------------------------
       
       0300-AFFICHAGE-FICHIERS-DEB.
           
           DISPLAY "Affichage des données lues et stockées : ".
           PERFORM 0350-AFFICHAGE-FICHIER-COM-DEB
              THRU 0350-AFFICHAGE-FICHIER-COM-FIN.

           PERFORM 0360-AFFICHAGE-FICHIER-CLI-DEB
              THRU 0360-AFFICHAGE-FICHIER-CLI-FIN.
           
           EXIT. 

       0300-AFFICHAGE-FICHIERS-FIN.
      *-----------------------------------------------------------------
       
       0350-AFFICHAGE-FICHIER-COM-DEB.
           
           DISPLAY WS-ENTETE-ID-COM WITH NO ADVANCING 
                   WS-ENTETE-QUANTITE WITH NO ADVANCING 
                   WS-ENTETE-NUM.


           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > WS-MAX-COM
               DISPLAY WS-ID-COM(WS-IDX) WITH NO ADVANCING 
                       WS-QUANTITE(WS-IDX) WITH NO ADVANCING
                       WS-NUM-COM(WS-IDX)
           END-PERFORM.

           EXIT.


       0350-AFFICHAGE-FICHIER-COM-FIN.

      *-----------------------------------------------------------------
       
       0360-AFFICHAGE-FICHIER-CLI-DEB.

           DISPLAY WS-ENTETE-ID-CLI WITH NO ADVANCING 
                   WS-ENTETE-NOM WITH NO ADVANCING 
                   WS-ENTETE-PRENOM.


           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > WS-MAX-CLI
               DISPLAY WS-ID-CLI(WS-IDX) WITH NO ADVANCING 
                       WS-NOM(WS-IDX) WITH NO ADVANCING
                       WS-PRENOM(WS-IDX)
           END-PERFORM.

           EXIT.
       0360-AFFICHAGE-FICHIER-CLI-FIN.
       
      *-----------------------------------------------------------------

       0400-ECRITURE-COM-PAR-CLI-DEB.

           DISPLAY "Ouverture du fichier à écrire : ".
           OPEN OUTPUT FICHIER-COM-CLI.
           
           
           MOVE SPACES TO F-LIGNE-COM-CLI(1:31)
           
           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > WS-MAX-CLI
               MOVE WS-ENTETE-TTR-CLI TO F-LIGNE-COM-CLI(1:9)
               MOVE WS-NOM(WS-IDX) TO F-LIGNE-COM-CLI(10:11)
               MOVE WS-PRENOM(WS-IDX) TO F-LIGNE-COM-CLI(21:10)
               WRITE F-LIGNE-COM-CLI
               
               MOVE SPACES TO F-LIGNE-COM-CLI(1:31)
               PERFORM 0450-TRAITEMENT-ECRITURE-DEB
                  THRU 0450-TRAITEMENT-ECRITURE-FIN
               
               WRITE F-LIGNE-COM-CLI

           END-PERFORM.
           DISPLAY "Fermeture du fichier.".
           CLOSE FICHIER-COM-CLI.

           EXIT.

       0400-ECRITURE-COM-PAR-CLI-FIN.


      *-----------------------------------------------------------------
       
       0450-TRAITEMENT-ECRITURE-DEB.
           
           PERFORM VARYING WS-IDX2 FROM 1 BY 1 UNTIL WS-IDX2 >WS-MAX-COM

               IF WS-ID-COM(WS-IDX2) = WS-ID-CLI(WS-IDX)
                   MOVE WS-ENTETE-QUANTITE TO F-LIGNE-COM-CLI(3:11)
                   MOVE WS-QUANTITE(WS-IDX2) TO F-LIGNE-COM-CLI(14:4)
                   MOVE WS-ENTETE-NUM TO F-LIGNE-COM-CLI(18:9)
                   MOVE WS-NUM-COM(WS-IDX2) TO F-LIGNE-COM-CLI(27:4)

                   WRITE F-LIGNE-COM-CLI
                   MOVE SPACES TO F-LIGNE-COM-CLI(1:31)
                   
               END-IF  
           END-PERFORM.


           EXIT.

       0450-TRAITEMENT-ECRITURE-FIN.

