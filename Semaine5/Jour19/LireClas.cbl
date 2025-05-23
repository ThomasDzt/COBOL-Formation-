      *Exercice : Lire un tableau multidimensionnel à partir d'un fichier
      * et rechercher des prénoms

       IDENTIFICATION DIVISION.
       PROGRAM-ID. LireClas.
       AUTHOR. ThomasD.


       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       SELECT FICHIER-CLASSE ASSIGN TO "input-classes.txt"
       ORGANIZATION IS LINE SEQUENTIAL. 

      


      ******************************************************************
      *                           DATA DIVISION                        *
      ****************************************************************** 
       
       DATA DIVISION.
       FILE SECTION.

       FD FICHIER-CLASSE.
           01 F-LIGNE-CLASSE.
               05 F-TYPE-CLASSE.
                   10 F-CLASSE                 PIC X(03).
                   10 F-ELEVE.
                       15 FILLER               PIC X(02).
                       15 F-NOM-ELEVE          PIC X(09).
                       15 F-PRENOM-ELEVE       PIC X(08).

       WORKING-STORAGE SECTION.
       
       01 WS-TABLEAU-ELEVES.
           05 WS-CLASSE   OCCURS 2 TIMES.

               10 WS-NOM-CLASSE               PIC X(03).
               10 WS-ELEVE OCCURS 8 TIMES.
                   15 WS-NOM-ELEVE            PIC X(09).
                   15 WS-PRENOM-ELEVE         PIC X(08).



       77 WS-INDEX-CLASSE          PIC 9       VALUE 1.
       77 WS-MAX-CLASSE            PIC 9       VALUE 2.


       77 WS-INDEX-ELEVE           PIC 9       VALUE 1.
       77 WS-MAX-ELEVE             PIC 9       VALUE 8.

       77 WS-INDEX-ELEVE-CM1       PIC 9       VALUE 1.
       77 WS-MAX-ELEVE-CM1         PIC 9       VALUE 4.

       77 WS-INDEX-ELEVE-CM2       PIC 9       VALUE 1.
       77 WS-MAX-ELEVE-CM2         PIC 9       VALUE 8.

       01 WS-FIN-LECTURE           PIC X       VALUE "N".

       01 WS-NOM-SAISI             PIC X(09).
       01 WS-NOM-TROUVE            PIC X(09).
       01 WS-PRENOM-AFFICHE        PIC X(30).

      ******************************************************************
      *                        PROCEDURE DIVISION                      *
      ****************************************************************** 
 
       PROCEDURE DIVISION. 
       PERFORM 0100-LECTURE-DEBUT
          THRU 0100-LECTURE-FIN.
       
       PERFORM 0200-CHERCHE-NOM-DEBUT
          THRU 0200-CHERCHE-NOM-FIN.

       STOP RUN.

      ******************************************************************
      *                           PARAGRAPHES                          *
      ******************************************************************

       0100-LECTURE-DEBUT.
       
       DISPLAY "Ouverture du fichier : "
       OPEN INPUT FICHIER-CLASSE.

       PERFORM UNTIL WS-FIN-LECTURE = "Y"
           READ FICHIER-CLASSE

               AT END 
                MOVE "Y" TO WS-FIN-LECTURE

               NOT AT END 
                IF F-CLASSE = "CM1" 
      
                   
                 MOVE F-CLASSE 
                 TO WS-NOM-CLASSE(1)

                 MOVE F-NOM-ELEVE 
                 TO WS-NOM-ELEVE(1,WS-INDEX-ELEVE-CM1)

                 MOVE F-PRENOM-ELEVE 
                 TO WS-PRENOM-ELEVE(1,WS-INDEX-ELEVE-CM1)

                 ADD 1 TO WS-INDEX-ELEVE-CM1

                ELSE 
      
                  MOVE F-CLASSE
                  TO WS-NOM-CLASSE(2)

                  MOVE F-NOM-ELEVE 
                  TO WS-NOM-ELEVE(2,WS-INDEX-ELEVE-CM2)

                  MOVE F-PRENOM-ELEVE 
                  TO WS-PRENOM-ELEVE(2,WS-INDEX-ELEVE-CM2)
                
                  ADD 1 TO WS-INDEX-ELEVE-CM2
       
                END-IF 
                   
           END-READ

       END-PERFORM.
       
       PERFORM VARYING WS-INDEX-CLASSE FROM 1 BY 1
               UNTIL WS-INDEX-CLASSE > WS-MAX-CLASSE

           PERFORM VARYING WS-INDEX-ELEVE FROM 1 BY 1
               UNTIL WS-INDEX-ELEVE > WS-MAX-ELEVE

               DISPLAY WS-NOM-CLASSE(WS-INDEX-CLASSE)
               SPACES WITH NO ADVANCING 
                       WS-NOM-ELEVE(WS-INDEX-CLASSE,WS-INDEX-ELEVE)
               SPACES WITH NO ADVANCING
                       WS-PRENOM-ELEVE(WS-INDEX-CLASSE,WS-INDEX-ELEVE)

           END-PERFORM 
       END-PERFORM.
       CLOSE FICHIER-CLASSE.



       0100-LECTURE-FIN.
       EXIT.

      *--------------------------------------

       0200-CHERCHE-NOM-DEBUT.
       DISPLAY "Entrez un nom : ".
       ACCEPT WS-NOM-SAISI.
       
       DISPLAY "Prenom(s) :".
       PERFORM VARYING WS-INDEX-CLASSE FROM 1 BY 1
               UNTIL WS-INDEX-CLASSE > WS-MAX-CLASSE
       
           PERFORM VARYING WS-INDEX-ELEVE FROM 1 BY 1
               UNTIL WS-INDEX-ELEVE > WS-MAX-ELEVE

            IF 
             WS-NOM-SAISI = WS-NOM-ELEVE(WS-INDEX-CLASSE,WS-INDEX-ELEVE)
             MOVE WS-PRENOM-ELEVE(WS-INDEX-CLASSE,WS-INDEX-ELEVE)
             TO   WS-NOM-TROUVE

      *      STRING FUNCTION TRIM(WS-PRENOM-AFFICHE) " " WS-NOM-TROUVE 
      *       INTO WS-PRENOM-AFFICHE
      *      END-STRING  
             DISPLAY  WS-NOM-TROUVE
             
           
            END-IF 
           
           END-PERFORM
       END-PERFORM.

     

       0200-CHERCHE-NOM-FIN.
       EXIT. 
