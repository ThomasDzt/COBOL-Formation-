      * Lire 2 fichiers (clients.txt, commandes.txt) et afficher les 
      * commandes par client (assume ID client commun).

      ******************************************************************
      *                            TRIGRAMMES                          *
      *----------------------------------------------------------------*
      * COM = COMMANDE ; CLI = CLIENT; 
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
           01 F-LIGNE-COM-CLI              PIC X(30).


       WORKING-STORAGE SECTION.
       
       01 WS-TABLEAU-COM.
           05 WS-LIGNE-COM OCCURS 17 TIMES.
           
      *    ID du client dans le fichier num-commandes
               10 WS-ID-COM                PIC X(03).
               10 WS-QUANTITE              PIC X(04).
               10 WS-NUMERO-COM            PIC X(04).

       01 WS-TABLEAU-CLI.
           05 WS-LIGNE-CLI OCCURS 10 TIMES.

      *    ID du client dans le fichier clients
               10 WS-ID-CLI                PIC X(08).
               10 WS-NOM                   PIC X(11).
               10 WS-PRENOM                PIC X(10).

       77 WS-IDX                           PIC 9(02).
       77 WS-IDX2                          PIC 9(02).      

       01 WS-MAX                           PIC 9(02).  

       01 WS-FIN-LECTURE                   PIC X.
           88 WS-FIN-LECTURE-N                         VALUE "N".
           88 WS-FIN-LECTURE-O                         VALUE "O".      

       01 WS-ENTETE-COM.
           05  WS-ENTETE-ID-COM            PIC X(03).
           05  WS-ENTETE-QUANTITE          PIC X(09).
           05  WS-ENTETE-NUMERO            PIC X(06).

       01 WS-ENTETE-CLI.
           05  WS-ENTETE-ID-CLI            PIC X(08).
           05  WS-ENTETE-NOM               PIC X(11).
           05  WS-ENTETE-PRENOM            PIC X(10).

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
           
           SET WS-FIN-LECTURE-N TO TRUE.
           INITIALIZE WS-IDX.
           MOVE 17 TO WS-MAX.

           MOVE "ID " TO WS-ENTETE-ID-COM.
           MOVE "Quantite " TO WS-ENTETE-QUANTITE.
           MOVE "Numero" TO WS-ENTETE-NUMERO.

           MOVE "ID " TO WS-ENTETE-ID-CLI.
           MOVE "Nom " TO WS-ENTETE-NOM.
           MOVE "Prenom " TO WS-ENTETE-PRENOM.


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
           
           OPEN INPUT FICHIER-COM.

           PERFORM UNTIL WS-FIN-LECTURE-O
               
               READ FICHIER-COM
                   AT END 
                       SET WS-FIN-LECTURE-O TO TRUE 
                   NOT AT END 
                       IF WS-IDX < WS-MAX 
                           ADD 1 TO WS-IDX 
                           MOVE F-LIGNE-COM(1:3) TO WS-ID-COM(WS-IDX)
                           
                       END-IF 
               END-READ
           END-PERFORM.



           EXIT.

       0250-LECTURE-FICHIER-COM-FIN.



