      * Créer un programme qui permet à l'utilisateur de gérer une 
      * to-do liste avec les fonctionnalités suivantes : 
      * - Ajouter une tâche
      * - Afficher les tâches
      * - Supprimer une tâche
      * - Quitter le programme

       IDENTIFICATION DIVISION.
       PROGRAM-ID. todo.
       AUTHOR. Thomas.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS-LISTE-TACHE.
           05 WS-TACHE OCCURS 10 TIMES.
               10 WS-NOM-TACHE             PIC X(50).
               10 WS-TACHE-EXISTE          PIC X       VALUE "N".
                   88 WS-TACHE-EXISTE-O                VALUE "O".
                   88 WS-TACHE-EXISTE-N                VALUE "N".
       
       
       77 WS-IDX               PIC 9(02).
       
       01 WS-SAISIE            PIC X(50).

       01 WS-TACHE-AJOUT               PIC X.
           88 WS-TACHE-AJOUT-O                     VALUE "O".
           88 WS-TACHE-AJOUT-N                     VALUE "N".


       01 WS-QUITTER                   PIC X.
           88 WS-QUITTER-O                         VALUE "O".
           88 WS-QUITTER-N                         VALUE "N".

       01 WS-RETOUR                    PIC X.
           88 WS-RETOUR-O                          VALUE "O".
           88 WS-RETOUR-N                          VALUE "N".

       01 WS-ERR-SAISIE                PIC X.
           88 WS-ERR-SAISIE-O                      VALUE "O".
           88 WS-ERR-SAISIE-N                      VALUE "N".


       01 WS-CHOIX             PIC 9.
       01 WS-NUM-TACHE         PIC 9(02).


       01 WS-VIDE              PIC X(19)       VALUE SPACES.
       01 WS-VIDE-2            PIC X(16)       VALUE SPACES.

       01 WS-CADRE             PIC X(50)       VALUE ALL "=".
       


       PROCEDURE DIVISION.

           PERFORM 0100-MENU-DEB
              THRU 0100-MENU-FIN.

           
           STOP RUN.
       
      ******************************************************************
      *                         PARAGRAPHES                            *
      ******************************************************************
       
       0100-MENU-DEB.
           
           SET WS-QUITTER-N TO TRUE.

           PERFORM UNTIL WS-QUITTER-O

               PERFORM 0110-AFFICHE-MENU-DEB
                  THRU 0110-AFFICHE-MENU-FIN
       
               PERFORM 0120-CHOIX-TODO-DEB
                  THRU 0120-CHOIX-TODO-FIN

           END-PERFORM.
           EXIT.
           
       0100-MENU-FIN.

      *-----------------------------------------------------------------

       0110-AFFICHE-MENU-DEB.

           DISPLAY WS-CADRE.
           DISPLAY "=" WS-VIDE "To-Do List" WS-VIDE "=".
           DISPLAY WS-CADRE.
           
           DISPLAY SPACES.
           DISPLAY SPACES.

           DISPLAY WS-VIDE-2 "1-Ajouter une tache".
           DISPLAY SPACES.

           DISPLAY WS-VIDE-2 "2-Afficher les taches".
           DISPLAY SPACES.

           DISPLAY WS-VIDE-2 "3-Supprimer une tache".
           DISPLAY SPACES.

           DISPLAY WS-VIDE-2 "4-Quitter le programme".

           DISPLAY SPACES.
           DISPLAY SPACES.
           DISPLAY WS-CADRE.

           DISPLAY "Choisissez une option : " WITH NO ADVANCING.
           EXIT.

       0110-AFFICHE-MENU-FIN.

      *-----------------------------------------------------------------
       
       0120-CHOIX-TODO-DEB.
           
           ACCEPT WS-CHOIX.
           EVALUATE WS-CHOIX
       
                   WHEN 1
                       PERFORM 0200-AJOUT-TACHE-DEB
                          THRU 0200-AJOUT-TACHE-FIN
       
                   WHEN 2
                       PERFORM 0300-AFFICHE-TACHE-DEB
                          THRU 0300-AFFICHE-TACHE-FIN

      *            WHEN 3
      *                PERFORM 0400-SUPPRIM-TACHE-DEB
      *                   THRU 0400-SUPPRIM-TACHE-FIN

                   WHEN 4
                       DISPLAY "Fermeture du programme."
                       SET WS-QUITTER-O TO TRUE 

           END-EVALUATE.

           EXIT.

       0120-CHOIX-TODO-FIN.

      *-----------------------------------------------------------------
       
       0200-AJOUT-TACHE-DEB.

           SET WS-RETOUR-N TO TRUE.

           PERFORM UNTIL WS-RETOUR-O 

               DISPLAY "Saisissez la tache à ajouter : "
               ACCEPT WS-SAISIE
               
               PERFORM 0210-INSERTION-TACHE-DEB
                  THRU 0210-INSERTION-TACHE-FIN
               
               SET WS-ERR-SAISIE-O TO TRUE 

               PERFORM UNTIL WS-ERR-SAISIE-N

                   DISPLAY "Revenir au menu principal ? (O/N)"
                   ACCEPT WS-RETOUR

                   IF WS-RETOUR NOT = "O" AND WS-RETOUR NOT = "N"
                       DISPLAY "Erreur de saisie"
                   ELSE 
                       SET WS-ERR-SAISIE-N TO TRUE 
                   END-IF 

               END-PERFORM     
           END-PERFORM.

           EXIT.
       0200-AJOUT-TACHE-FIN.

      *-----------------------------------------------------------------
       
       0210-INSERTION-TACHE-DEB.
           
           SET WS-TACHE-AJOUT-N TO TRUE.

           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 10 
                   OR WS-TACHE-AJOUT-O
               
               IF WS-TACHE-EXISTE(WS-IDX) = "N"
                   MOVE WS-SAISIE TO WS-NOM-TACHE(WS-IDX)
                   MOVE "O" TO WS-TACHE-EXISTE(WS-IDX)
                   SET WS-TACHE-AJOUT-O TO TRUE 
               END-IF 

           END-PERFORM.

           EXIT.

       0210-INSERTION-TACHE-FIN.

      *-----------------------------------------------------------------
       
       0300-AFFICHE-TACHE-DEB.

           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 10
               
               IF WS-TACHE-EXISTE(WS-IDX)= "O"
                   DISPLAY WS-NOM-TACHE(WS-IDX)
               END-IF 
               
           END-PERFORM.

           EXIT.

       0300-AFFICHE-TACHE-FIN.


