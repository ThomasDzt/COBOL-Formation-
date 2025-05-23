      *Reprise de l'exercice assurances 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. assur2.
       AUTHOR. ThomasD.
 
 
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
 
       SELECT FICHIER-ASSURANCES ASSIGN TO "assurances.csv"
       ORGANIZATION IS LINE SEQUENTIAL.
 
       SELECT FICHIER-RAPPORT-ASSURANCES 
       ASSIGN TO "rapport-assurances2.dat"
       ORGANIZATION IS LINE SEQUENTIAL.
       

       DATA DIVISION.
      
       FILE SECTION.
 
       FD FICHIER-ASSURANCES.
           01  F-LIGNE-ASSURANCES          PIC X(121).

       FD FICHIER-RAPPORT-ASSURANCES.
           01 F-LIGNE-RAPPORT-ASSURANCES   PIC X(121).
       

       WORKING-STORAGE SECTION. 

       01 WS-TABLEAU-ASSURANCES    OCCURS 36 TIMES.
           05 WS-ASSURANCES                PIC X(91).

           05 WS-DATE-DEBUT.
               10 WS-ANNEE-DEBUT           PIC X(4).
               10 FILLER                   PIC X       VALUE "/".
               10 WS-MOIS-DEBUT            PIC X(2).
               10 FILLER                   PIC X       VALUE "/".
               10 WS-JOUR-DEBUT            PIC X(3).
           

           05 WS-DATE-FIN.
              10 WS-ANNEE-FIN              PIC X(4).
              10 FILLER                    PIC X       VALUE "/".
              10 WS-MOIS-FIN               PIC X(2).
              10 FILLER                    PIC X       VALUE "/". 
              10 WS-JOUR-FIN               PIC X(3).
           
           05 WS-ASSURANCES2               PIC X(16).
          
          

       77 WS-INDEX-TABLEAU             PIC 9(2)        VALUE 1.
       77 WS-MAX-TABLEAU               PIC 9(2)        VALUE 36.


       01 WS-FIN-LECTURE               PIC X           VALUE "N".


       PROCEDURE DIVISION.

       DISPLAY "Ouverture du fichier".
       OPEN INPUT FICHIER-ASSURANCES.

       DISPLAY "Lecture du fichier ligne par ligne".

       PERFORM UNTIL WS-FIN-LECTURE = "Y"
           
        READ FICHIER-ASSURANCES

           AT END 
            MOVE "Y" TO WS-FIN-LECTURE

           NOT AT END 
            IF WS-INDEX-TABLEAU <= WS-MAX-TABLEAU
             MOVE F-LIGNE-ASSURANCES 
             TO WS-ASSURANCES(WS-INDEX-TABLEAU)
             MOVE F-LIGNE-ASSURANCES(91:4)
             TO   WS-ANNEE-DEBUT(WS-INDEX-TABLEAU)
             MOVE F-LIGNE-ASSURANCES(95:2)
             TO   WS-ANNEE-DEBUT(WS-INDEX-TABLEAU)
             MOVE F-LIGNE-ASSURANCES(97:3)
             TO   WS-ANNEE-DEBUT(WS-INDEX-TABLEAU)
             MOVE F-LIGNE-ASSURANCES(100:9)
             TO   WS-DATE-FIN(WS-INDEX-TABLEAU)
             MOVE F-LIGNE-ASSURANCES(109:11)
             TO   WS-ASSURANCES2(WS-INDEX-TABLEAU)
             ADD 1 TO WS-INDEX-TABLEAU
            END-IF 
        END-READ

       END-PERFORM.

       CLOSE FICHIER-ASSURANCES.

       PERFORM VARYING WS-INDEX-TABLEAU FROM 1 BY 1 
               UNTIL WS-INDEX-TABLEAU > WS-MAX-TABLEAU

          IF WS-INDEX-TABLEAU = 3 OR 7     
           DISPLAY "enregistrement n° " WS-INDEX-TABLEAU
           DISPLAY WS-TABLEAU-ASSURANCES(WS-INDEX-TABLEAU)
          END-IF 

       END-PERFORM.

       DISPLAY "Fin de lecture".
       DISPLAY "Fermeture du fichier lu".


      * OPEN OUTPUT FICHIER-RAPPORT-ASSURANCES.
      * DISPLAY "Ecriture du fichier".*

      * PERFORM VARYING WS-INDEX-TABLEAU FROM 1 BY 1 
      *         UNTIL WS-INDEX-TABLEAU > WS-MAX-TABLEAU
      *     MOVE WS-ASSURANCES(1:90)
      *     TO   F-LIGNE-RAPPORT-ASSURANCES
      *     MOVE WS-ASSURANCES(91:9)
      *     TO   
      * END-PERFORM.*

       STOP RUN.
     