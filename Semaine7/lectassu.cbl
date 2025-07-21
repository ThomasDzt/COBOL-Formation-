       IDENTIFICATION DIVISION.
       PROGRAM-ID. lectassu.
       AUTHOR. ThomasD.


       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       SELECT FICHIER-ENTREE ASSIGN TO "datassur.csv"
       ORGANIZATION IS LINE SEQUENTIAL.

       SELECT FICHIER-SORTIE ASSIGN TO "rapport.csv"
       ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.

       FD FICHIER-ENTREE.

       01  F-LIGNE-FICHIER-ENTREE    PIC X(1000).

       FD FICHIER-SORTIE.
       01  F-LIGNE-FICHIER-SORTIE    PIC X(1000).


       WORKING-STORAGE SECTION.

       01 WS-TABLEAU-FICHIER.
           05 WS-LIGNE-TABLEAU    OCCURS 36 TIMES.
               10 WS-NUMERO                   PIC X(08).
               10 WS-NOM-CONTRAT              PIC X(14).
               10 WS-NOM-PRODUIT              PIC X(14).
               10 WS-NOM-CLIENT               PIC X(41).
               10 WS-STATUT                   PIC X(08).
   
               10 WS-DATE-DEBUT.
                   15 WS-JOUR-DEBUT             PIC X(02). 
                   15 FILLER                    PIC X     VALUE "/".
                   15 WS-MOIS-DEBUT             PIC X(02). 
                   15 FILLER                    PIC X     VALUE "/".
                   15 WS-ANNEE-DEBUT            PIC X(04). 
                   
               10 WS-DATE-FIN.
                   15 WS-JOUR-FIN             PIC X(02). 
                   15 FILLER                  PIC X       VALUE "/".
                   15 WS-MOIS-FIN             PIC X(02). 
                   15 FILLER                  PIC X       VALUE "/".
                   15 WS-ANNEE-FIN            PIC X(04).

               10 WS-MONTANT                  PIC X(09).
               10 WS-DEVISE                   PIC X(03).


       77 WS-INDEX    PIC 9(02)        VALUE 1.
       77 WS-MAX      PIC 9(02)        VALUE 36.
       
       01 WS-FIN-LECTURE  PIC X.
           88 WS-FIN-LECTURE-O     VALUE "O".
           88 WS-FIN-LECTURE-N     VALUE "N".


           
       01 WS-TITRE        PIC X(20)      VALUE "rapport de synthèse".
       01 WS-IDENTITE     PIC X(20).

       01 WS-DATE.
           05 WS-DATE-ANNEE          PIC X(04).
           05 FILLER                  PIC X     VALUE "/".
           05 WS-DATE-MOIS           PIC X(02). 
           05 FILLER                  PIC X     VALUE "/".
           05 WS-DATE-JOUR           PIC X(02). 



      

       PROCEDURE DIVISION.
       
       SET WS-FIN-LECTURE-N TO TRUE.
      
      *Lecture du fichier en entrée

       OPEN INPUT FICHIER-ENTREE.

       PERFORM UNTIL WS-FIN-LECTURE-O

           READ FICHIER-ENTREE
           AT END 
               SET WS-FIN-LECTURE-O TO TRUE

           NOT AT END 
               IF WS-INDEX <= WS-MAX 

                MOVE  F-LIGNE-FICHIER-ENTREE(1:8)
                TO    WS-NUMERO(WS-INDEX)
                   
                MOVE  F-LIGNE-FICHIER-ENTREE(10:14)
                TO    WS-NOM-CONTRAT(WS-INDEX)

                MOVE  F-LIGNE-FICHIER-ENTREE(25:14)
                TO    WS-NOM-PRODUIT(WS-INDEX)

                MOVE  F-LIGNE-FICHIER-ENTREE(40:41)
                TO    WS-NOM-CLIENT(WS-INDEX)


                MOVE  F-LIGNE-FICHIER-ENTREE(82:8)
                TO    WS-STATUT(WS-INDEX)
                
                MOVE  F-LIGNE-FICHIER-ENTREE(91:4)
                TO    WS-ANNEE-DEBUT(WS-INDEX)

                MOVE  F-LIGNE-FICHIER-ENTREE(95:2)
                TO    WS-MOIS-DEBUT(WS-INDEX)

                MOVE  F-LIGNE-FICHIER-ENTREE(97:2)
                TO    WS-JOUR-DEBUT(WS-INDEX)

                MOVE  F-LIGNE-FICHIER-ENTREE(100:4)
                TO    WS-ANNEE-FIN(WS-INDEX)

                MOVE  F-LIGNE-FICHIER-ENTREE(104:2)
                TO    WS-MOIS-FIN(WS-INDEX)

                MOVE  F-LIGNE-FICHIER-ENTREE(106:2)
                TO    WS-JOUR-FIN(WS-INDEX)

                MOVE  F-LIGNE-FICHIER-ENTREE(109:9)
                TO    WS-MONTANT(WS-INDEX)

                MOVE  F-LIGNE-FICHIER-ENTREE(119:3)
                TO    WS-DEVISE(WS-INDEX)
                
                ADD 1 TO WS-INDEX 
               END-IF 
           END-READ
       END-PERFORM.

       CLOSE FICHIER-ENTREE.



      *Affichage du fichier lu sur le terminal

       PERFORM VARYING WS-INDEX FROM 1 BY 1 
                       UNTIL  WS-INDEX > WS-MAX
           
           DISPLAY WS-NUMERO(WS-INDEX)
           SPACES WITH NO ADVANCING 
           
           DISPLAY WS-NOM-CONTRAT(WS-INDEX)
           SPACES WITH NO ADVANCING 

           DISPLAY WS-NOM-PRODUIT(WS-INDEX)
           SPACES WITH NO ADVANCING 

           DISPLAY WS-NOM-CLIENT(WS-INDEX)
           SPACES WITH NO ADVANCING 

           DISPLAY WS-STATUT(WS-INDEX)
           SPACES WITH NO ADVANCING 


           DISPLAY WS-DATE-DEBUT(WS-INDEX)
           SPACES WITH NO ADVANCING 

           DISPLAY WS-DATE-FIN(WS-INDEX)
           SPACES WITH NO ADVANCING 


           DISPLAY WS-MONTANT(WS-INDEX)
           SPACES WITH NO ADVANCING 

           DISPLAY WS-DEVISE(WS-INDEX)

           
       END-PERFORM.


      *Ecriture du fichier de sortie

       OPEN OUTPUT FICHIER-SORTIE.

       PERFORM VARYING WS-INDEX FROM 1 BY 1 
                       UNTIL  WS-INDEX > WS-MAX
       
                MOVE  WS-NUMERO(WS-INDEX)
                TO    F-LIGNE-FICHIER-SORTIE(1:8)
                   
                MOVE  WS-NOM-CONTRAT(WS-INDEX)
                TO    F-LIGNE-FICHIER-SORTIE(10:14)

                MOVE  WS-NOM-PRODUIT(WS-INDEX)
                TO    F-LIGNE-FICHIER-SORTIE(25:14)

                MOVE  WS-NOM-CLIENT(WS-INDEX)
                TO    F-LIGNE-FICHIER-SORTIE(40:41)


                MOVE  WS-STATUT(WS-INDEX)
                TO    F-LIGNE-FICHIER-SORTIE(82:8)
                
                MOVE  WS-DATE-DEBUT(WS-INDEX)
                TO    F-LIGNE-FICHIER-SORTIE(91:8)


                MOVE  WS-DATE-FIN(WS-INDEX)
                TO    F-LIGNE-FICHIER-SORTIE(100:8)


                MOVE  WS-MONTANT(WS-INDEX)
                TO    F-LIGNE-FICHIER-SORTIE(109:9)

                MOVE  WS-DEVISE(WS-INDEX)
                TO    F-LIGNE-FICHIER-SORTIE(119:3)
           
               WRITE F-LIGNE-FICHIER-SORTIE
       END-PERFORM.

       
       
       CLOSE FICHIER-SORTIE.
       STOP RUN.

