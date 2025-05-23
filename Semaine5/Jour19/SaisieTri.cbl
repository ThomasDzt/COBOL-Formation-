      *Exercice : Saisie d'une tableau multidimensionnel depuis le terminal
      *puis écriture dans un fichier et tri dans l'odre alphabétique 

       IDENTIFICATION DIVISION.
       PROGRAM-ID. SaisieTri.
       AUTHOR. ThomasD.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

       SELECT FICHIER-TRI ASSIGN TO "output-classes.txt"
       ORGANIZATION IS LINE SEQUENTIAL.


      ******************************************************************
      *                           DATA DIVISION                        *
      ****************************************************************** 

       DATA DIVISION.
       FILE SECTION.
       FD FICHIER-TRI.
           01 F-LIGNE-CLASSE.
               05 F-TYPE-CLASSE.
                   10 F-CLASSE                 PIC X(04).
                   10 F-ELEVE.
                       
                       15 F-NOM-ELEVE          PIC X(09).
                       15 F-PRENOM-ELEVE       PIC X(08).


       WORKING-STORAGE SECTION.
       
       01 WS-TABLEAU-ELEVES.
           05 WS-CLASSE   OCCURS 2 TIMES.
               10 WS-ELEVE OCCURS 6 TIMES.
                   15 WS-NOM-ELEVE            PIC X(15).
                   15 WS-PRENOM-ELEVE         PIC X(15). 


       77 WS-INDEX-CLASSE      PIC 9       VALUE 1.
       77 WS-MAX-CLASSE        PIC 9       VALUE 2.

       77 WS-INDEX-ELEVE       PIC 9       VALUE 1.
       77 WS-MAX-ELEVE         PIC 9       VALUE 6.


      ******************************************************************
      *                        PROCEDURE DIVISION                      *
      ****************************************************************** 
 
       PROCEDURE DIVISION.

       PERFORM 0100-SAISIE-TABLEAU-DEBUT
          THRU 0100-SAISIE-TABLEAU-FIN.

      *PERFORM 0200-AFFICHE-TABLEAU-DEBUT
      *   THRU 0200-AFFICHE-TABLEAU-FIN.
       
       PERFORM 0300-TRI-TABLEAU-DEBUT
          THRU 0300-TRI-TABLEAU-FIN.

       PERFORM 0400-ECRITURE-DEBUT
          THRU 0400-ECRITURE-FIN.

       STOP RUN.

       


      ******************************************************************
      *                           PARAGRAPHES                          *
      ****************************************************************** 

       0100-SAISIE-TABLEAU-DEBUT.

       PERFORM VARYING WS-INDEX-CLASSE FROM 1 BY 1 
               UNTIL   WS-INDEX-CLASSE > WS-MAX-CLASSE

           PERFORM VARYING WS-INDEX-ELEVE FROM 1 BY 1 
                   UNTIL   WS-INDEX-ELEVE > WS-MAX-ELEVE 

             DISPLAY "Entrez le nom et le prenom de l'eleve " 
                  WS-INDEX-ELEVE
                  " de CM" 
                  WS-INDEX-CLASSE

             ACCEPT WS-NOM-ELEVE(WS-INDEX-CLASSE,WS-INDEX-ELEVE)
               
             ACCEPT WS-PRENOM-ELEVE(WS-INDEX-CLASSE,WS-INDEX-ELEVE)
     
             DISPLAY "Nom : " 
                     WS-NOM-ELEVE(WS-INDEX-CLASSE,WS-INDEX-ELEVE)
                     SPACES WITH NO ADVANCING 
                     "Prenom : "
                     WS-PRENOM-ELEVE(WS-INDEX-CLASSE,WS-INDEX-ELEVE)

           END-PERFORM 
       END-PERFORM.




       0100-SAISIE-TABLEAU-FIN.
       EXIT.

      *------------------------------------------------------

      *0200-AFFICHE-TABLEAU-DEBUT.
      *PERFORM VARYING WS-INDEX-CLASSE FROM 1 BY 1 
      *        UNTIL   WS-INDEX-CLASSE > WS-MAX-CLASSE

      *    PERFORM VARYING WS-INDEX-ELEVE FROM 1 BY 1 
      *            UNTIL   WS-INDEX-ELEVE > WS-MAX-ELEVE

      *     DISPLAY "Classe : CM" WS-INDEX-CLASSE
      *     DISPLAY "Eleve : "  WS-ELEVE(WS-INDEX-CLASSE,WS-INDEX-ELEVE)
      *    END-PERFORM 
      *END-PERFORM.

      *0200-AFFICHE-TABLEAU-FIN.
      *EXIT.
      *------------------------------------------------------
       0300-TRI-TABLEAU-DEBUT.

       PERFORM VARYING WS-INDEX-CLASSE FROM 1 BY 1 
               UNTIL   WS-INDEX-CLASSE > WS-MAX-CLASSE

           SORT WS-ELEVE(WS-INDEX-CLASSE) ASCENDING 

           PERFORM VARYING WS-INDEX-ELEVE FROM 1 BY 1 
                   UNTIL   WS-INDEX-ELEVE > WS-MAX-ELEVE

            DISPLAY "Classe : CM" WS-INDEX-CLASSE
            DISPLAY "Eleve : "  WS-ELEVE(WS-INDEX-CLASSE,WS-INDEX-ELEVE)

           END-PERFORM 
           
       END-PERFORM.
       
       0300-TRI-TABLEAU-FIN.
       EXIT.

      *------------------------------------------------------

       0400-ECRITURE-DEBUT.
       DISPLAY "Ouverture du fichier : ".
       OPEN OUTPUT FICHIER-TRI.
       DISPLAY "Ecriture du fichier : ".
       
       PERFORM VARYING WS-INDEX-CLASSE FROM 1 BY 1 
               UNTIL   WS-INDEX-CLASSE > WS-MAX-CLASSE
       
           IF WS-INDEX-CLASSE = 1
            PERFORM VARYING WS-INDEX-ELEVE FROM 1 BY 1 
                    UNTIL   WS-INDEX-ELEVE > WS-MAX-ELEVE
 
                MOVE "CM1"
                TO   F-CLASSE
 
                MOVE WS-NOM-ELEVE(WS-INDEX-CLASSE,WS-INDEX-ELEVE)
                TO   F-NOM-ELEVE
 
                MOVE WS-PRENOM-ELEVE(WS-INDEX-CLASSE,WS-INDEX-ELEVE)
                TO   F-PRENOM-ELEVE
 
                WRITE F-LIGNE-CLASSE
 
            END-PERFORM 
           END-IF 
           
           IF WS-INDEX-CLASSE = 2
            PERFORM VARYING WS-INDEX-ELEVE FROM 1 BY 1 
                    UNTIL   WS-INDEX-ELEVE > WS-MAX-ELEVE
 
                MOVE "CM2"
                TO   F-CLASSE
 
                MOVE WS-NOM-ELEVE(WS-INDEX-CLASSE,WS-INDEX-ELEVE)
                TO   F-NOM-ELEVE
 
                MOVE WS-PRENOM-ELEVE(WS-INDEX-CLASSE,WS-INDEX-ELEVE)
                TO   F-PRENOM-ELEVE
 
                WRITE F-LIGNE-CLASSE
 
            END-PERFORM
           END-IF 
           
       END-PERFORM.
       
       DISPLAY "Fermeture du fichier".
       CLOSE FICHIER-TRI.



       0400-ECRITURE-FIN.
       EXIT.
