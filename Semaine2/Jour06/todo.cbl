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

      * Liste des tâches à créer. 
       01 WS-LISTE-TACHE.
           05 WS-TACHE OCCURS 10 TIMES.  *> on prévoit 10 taches max
               10 WS-NOM-TACHE             PIC X(50). 

      * Flag pour vérifier l'existence de la tache. 
               10 WS-TACHE-EXISTE          PIC X       VALUE "N".
                   88 WS-TACHE-EXISTE-O                VALUE "O".
                   88 WS-TACHE-EXISTE-N                VALUE "N".
       
      * Index pour parcourir la liste des taches.
       77 WS-IDX               PIC 9(02).
       
      * Saisie de la tache par l'utilisateur.
       01 WS-SAISIE            PIC X(50).

      * Flag pour confirmer l'ajout d'une tache et contrôler la fin de 
      * boucle sur l'ajout de tache.
       01 WS-TACHE-AJOUT               PIC X.
           88 WS-TACHE-AJOUT-O                     VALUE "O".
           88 WS-TACHE-AJOUT-N                     VALUE "N".

      * Flag pour quitter le programme.
       01 WS-QUITTER                   PIC X.
           88 WS-QUITTER-O                         VALUE "O".
           88 WS-QUITTER-N                         VALUE "N".

      * Flag pour retourner au menu principal.
       01 WS-RETOUR                    PIC X.
           88 WS-RETOUR-O                          VALUE "O".
           88 WS-RETOUR-N                          VALUE "N".

      * Flag pour contrôler la saisie lorsqu'on demande à l'utilisateur
      * s'il veut revenir au menu principal ou quitter le programme.
       01 WS-ERR-SAISIE                PIC X.
           88 WS-ERR-SAISIE-O                      VALUE "O".
           88 WS-ERR-SAISIE-N                      VALUE "N".

      * Variable représentant l''option choisie par l'utilisateur. 
       01 WS-CHOIX             PIC 9.

      * Permet d'identifier la tache à supprimer. 
       01 WS-NUM-TACHE         PIC 9(02).

      * Variables d'affichage.
       01 WS-VIDE              PIC X(19)       VALUE SPACES.
       01 WS-VIDE-2            PIC X(16)       VALUE SPACES.

       01 WS-CADRE             PIC X(50)       VALUE ALL "=".
       


       PROCEDURE DIVISION.

      * Boucle principale du programme. 
           PERFORM 0100-MENU-DEB
              THRU 0100-MENU-FIN.

           
           STOP RUN.
       
      ******************************************************************
      *                         PARAGRAPHES                            *
      ******************************************************************
       
       0100-MENU-DEB.
           
           SET WS-QUITTER-N TO TRUE.

           PERFORM UNTIL WS-QUITTER-O

      * Affiche le menu principal. 
               PERFORM 0110-AFFICHE-MENU-DEB
                  THRU 0110-AFFICHE-MENU-FIN

      * Evalue l'option choisie par l'utilisateur.
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

                   WHEN 3
                       PERFORM 0400-SUPPRIM-TACHE-DEB
                          THRU 0400-SUPPRIM-TACHE-FIN

                   WHEN 4
                       PERFORM 0500-QUITTER-PROG-DEB
                          THRU 0500-QUITTER-PROG-FIN
                       
                   WHEN OTHER 
                       DISPLAY "Erreur : veuillez saisir une des "
                               "options proposées."

           END-EVALUATE.

           EXIT.

       0120-CHOIX-TODO-FIN.

      *-----------------------------------------------------------------
       
       0200-AJOUT-TACHE-DEB.

           SET WS-RETOUR-N TO TRUE.
       
      * Boucle tant que l'utilisateur ne choisit de retourner au menu
      * principal.
           PERFORM UNTIL WS-RETOUR-O 

               DISPLAY "Saisissez la tache à ajouter : "
               ACCEPT WS-SAISIE
               
               PERFORM 0210-INSERTION-TACHE-DEB
                  THRU 0210-INSERTION-TACHE-FIN

      * Demande à l'utilisateur s'il veur retourner au menu principal.         
               PERFORM 0220-RETOUR-MENU-DEB
                  THRU 0220-RETOUR-MENU-FIN

           END-PERFORM.

           EXIT.
       0200-AJOUT-TACHE-FIN.

      *-----------------------------------------------------------------

       0210-INSERTION-TACHE-DEB.
           
           SET WS-TACHE-AJOUT-N TO TRUE.

      * Parcourt la liste des tâches et ajoute la tache saisie dès 
      * qu'un emplacement vide est trouvé. 
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
           
           0220-RETOUR-MENU-DEB.

           SET WS-ERR-SAISIE-O TO TRUE. 

      * Contrôle la saisie de l'utilisateur et boucle tant qu'elle n'est
      * pas correcte. 
           PERFORM UNTIL WS-ERR-SAISIE-N

               DISPLAY "Revenir au menu principal ? (O/N)"
               ACCEPT WS-RETOUR
       
               IF WS-RETOUR NOT = "O" AND WS-RETOUR NOT = "N"
                   DISPLAY "Erreur de saisie"
               ELSE 
                   SET WS-ERR-SAISIE-N TO TRUE 
               END-IF 

           END-PERFORM.

           EXIT.
           0220-RETOUR-MENU-FIN.

      *-----------------------------------------------------------------
       
       0300-AFFICHE-TACHE-DEB.
           
      * Affiche l'ensemble des tâches rédigées par l'utilisateur. 
           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 10
               
               IF WS-TACHE-EXISTE(WS-IDX)= "O"
                   DISPLAY "Tache n°" WS-IDX ": " WS-NOM-TACHE(WS-IDX)
               END-IF 

           END-PERFORM.

           EXIT.

       0300-AFFICHE-TACHE-FIN.

      *-----------------------------------------------------------------

       0400-SUPPRIM-TACHE-DEB.
           
           SET WS-RETOUR-N TO TRUE.

      * Boucle tant que l'utilisateur ne choisit de retourner au menu
      * principal.
           PERFORM UNTIL WS-RETOUR-O 

      * Supprime la tache indiquée. 
               DISPLAY "Saisissez le n° de la tache à supprimer : "
               WITH NO ADVANCING 
               ACCEPT WS-NUM-TACHE

               MOVE SPACES TO WS-NOM-TACHE(WS-NUM-TACHE)

      * Boucle pour réorganiser la liste des taches après suppression
      * d'une tache. A chaque supression, les taches suivant la tache 
      * supprimée sont "remontées" afin de combler le vide.          
               PERFORM VARYING WS-IDX FROM WS-NUM-TACHE BY 1 
               UNTIL WS-TACHE-EXISTE(WS-IDX)= "N"
                   
                   MOVE WS-NOM-TACHE(WS-IDX + 1) TO WS-NOM-TACHE(WS-IDX)

                   IF WS-NOM-TACHE(WS-IDX + 1) = SPACES 
                       MOVE "N" TO WS-TACHE-EXISTE(WS-IDX)

                   END-IF 
               END-PERFORM 
               
               PERFORM 0220-RETOUR-MENU-DEB
                  THRU 0220-RETOUR-MENU-FIN

           END-PERFORM.
           EXIT.
       0400-SUPPRIM-TACHE-FIN.
      *-----------------------------------------------------------------
       
       0500-QUITTER-PROG-DEB.

      * Demande à l'utilisateur s'il veur quitter le programme.    
           SET WS-ERR-SAISIE-O TO TRUE. 

      * Contrôle la saisie de l'utilisateur et boucle tant qu'elle n'est
      * pas correcte.
           PERFORM UNTIL WS-ERR-SAISIE-N

               DISPLAY "Voulez-vous quitter le programme ? (O/N)"
               ACCEPT WS-QUITTER
           
               IF WS-QUITTER NOT = "O" AND WS-QUITTER NOT = "N"
                   DISPLAY "Erreur de saisie"
               ELSE 
                   SET WS-ERR-SAISIE-N TO TRUE 
               END-IF
           
               IF WS-QUITTER-O
                   DISPLAY "Fermeture du programme."
               END-IF
           
           END-PERFORM.

           EXIT.

       0500-QUITTER-PROG-FIN.

      *-----------------------------------------------------------------

