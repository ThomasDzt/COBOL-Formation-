      *Exercice : Saisie d'un tableau multidimensionnel en le remplissant dans le terminal

       IDENTIFICATION DIVISION.
       PROGRAM-ID. SaisieClas.
       AUTHOR. ThomasD.


       ENVIRONMENT DIVISION.


      ******************************************************************
      *                           DATA DIVISION                        *
      ****************************************************************** 

       DATA DIVISION.
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
       

       PERFORM VARYING WS-INDEX-CLASSE FROM 1 BY 1 
               UNTIL   WS-INDEX-CLASSE > WS-MAX-CLASSE

           PERFORM VARYING WS-INDEX-ELEVE FROM 1 BY 1 
                   UNTIL   WS-INDEX-ELEVE > WS-MAX-ELEVE

           DISPLAY "Classe : CM" WS-INDEX-CLASSE
           DISPLAY "Eleve : "  WS-ELEVE(WS-INDEX-CLASSE,WS-INDEX-ELEVE)
           END-PERFORM 
       END-PERFORM.

       STOP RUN.
