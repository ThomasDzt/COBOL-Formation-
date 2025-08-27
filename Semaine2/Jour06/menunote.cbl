      * Créer un programme qui permet à l'utilisateur de se déplacer 
      * dans un menu pour afficher la moyenne des notes, la note la plus 
      * basse et la note la plus haute parmi un ensemble de notes 
      * inscrites en dur. 
      * - Calculer et afficher la moyenne des notes.
      * - Afficher la note la plus basse.
      * - Afficher la note la plus haute.
      * - Quitter le programme

       IDENTIFICATION DIVISION.
       PROGRAM-ID. menunote.
       AUTHOR. Thomas.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      
       01 WS-ENSEMBLE-NOTES.
           05 WS-LISTE-NOTES OCCURS 10 TIMES.

      * Notes enregistrées après contrôle de saisie
               10 WS-NOTE          PIC 9(02)V9(02).

      * Notes saisies par l'utilisateur 
               10 WS-SAISIE-NOTE   PIC X(05).

      * Index pour parcourir la liste des notes.
       77 WS-IDX           PIC 9(02).

      * Moyenne des notes. 
       01 WS-MOY-NOTE      PIC 9(02)V9(02).

      * Somme des notes, utilisée pour le calcul de la moyenne. 
       01 WS-SOMME         PIC 9(03)V9(02).

      * Note minimale enregistrée dans la liste. 
       01 WS-NOTE-MIN      PIC 9(02)V9(02).

      * Note maximale enregistrée dans la liste. 
       01 WS-NOTE-MAX      PIC 9(02)V9(02). 

      * Variable représentant l''option choisie par l'utilisateur. 
       01 WS-CHOIX         PIC 9.

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


      * Variables d'affichage.
       01 WS-VIDE              PIC X(19)       VALUE SPACES.
       01 WS-VIDE-2            PIC X(09)       VALUE SPACES.

       01 WS-CADRE             PIC X(50)       VALUE ALL "=".




       PROCEDURE DIVISION.

      * Saisie des notes par l'utilisateur.
           PERFORM 0050-SAISIE-NOTE-DEB
              THRU 0050-SAISIE-NOTE-FIN.

      * Boucle principale du programme. 
           PERFORM 0100-MENU-DEB
              THRU 0100-MENU-FIN.


           STOP RUN.

      ******************************************************************
      *                         PARAGRAPHES                            *
      ******************************************************************
       
       0050-SAISIE-NOTE-DEB.

      * Boucle parcourant la liste des notes à saisir.
           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 10
               
      * Initialisation du flag de contrôle d'erreur de saisie.        
               SET WS-ERR-SAISIE-O TO TRUE 

      * Boucle se terminant lorsque la saisie est correcte.
               PERFORM UNTIL WS-ERR-SAISIE-N

                   DISPLAY "Entrez la note n° " WS-IDX " : " 
                   WITH NO ADVANCING 
                   ACCEPT WS-SAISIE-NOTE(WS-IDX)
                   
                   PERFORM 0055-CONTROLE-SAISIE-DEB
                      THRU 0055-CONTROLE-SAISIE-FIN 

               END-PERFORM 
           END-PERFORM.

           EXIT.

       0050-SAISIE-NOTE-FIN.

      *-----------------------------------------------------------------

       0055-CONTROLE-SAISIE-DEB.
      
      * Vérifie que des caractères numériques ont bien été entrés pour 
      * la variable de saisie et que le format de note a été respecté.
           IF WS-SAISIE-NOTE(WS-IDX)(1:2) IS NUMERIC 
           AND WS-SAISIE-NOTE(WS-IDX)(4:2) IS NUMERIC  
           AND WS-SAISIE-NOTE(WS-IDX)(3:1) = "."

      * Vérifie que la note saisie est bien comprise entre 0 et 20.         
               IF FUNCTION NUMVAL (WS-SAISIE-NOTE(WS-IDX)) >= 0 
               AND FUNCTION NUMVAL (WS-SAISIE-NOTE(WS-IDX)) <= 20

      * Après validation de la saisie, alimente la variable numérique 
      * correspondante.
                   MOVE FUNCTION NUMVAL (WS-SAISIE-NOTE(WS-IDX))
                   TO WS-NOTE(WS-IDX)
           
                   SET WS-ERR-SAISIE-N TO TRUE 

      * Si la note saisie n'est pas comprise entre 0 et 20.          
               ELSE 
                   DISPLAY "Note invalide : veuillez saisir une note"
                           " entre 00.00 et 20.00"
               END-IF 

      * Si la saisie n'est pas conforme.          
           ELSE 
               DISPLAY "Erreur de saisie, " 
                       "veuillez saisir une note au format XX.XX ."
       
           END-IF 

           EXIT.

       0055-CONTROLE-SAISIE-FIN.
      *-----------------------------------------------------------------

       0100-MENU-DEB.
           
           SET WS-QUITTER-N TO TRUE.

      * Boucle tant que l'utilisateur ne choisit pas de quitter le 
      * programme.
           PERFORM UNTIL WS-QUITTER-O

      * Affiche le menu principal. 
               PERFORM 0110-AFFICHE-MENU-DEB
                  THRU 0110-AFFICHE-MENU-FIN

      * Evalue l'option choisie par l'utilisateur.
               PERFORM 0120-CHOIX-MENU-DEB
                  THRU 0120-CHOIX-MENU-FIN

           END-PERFORM.
           EXIT.
           
       0100-MENU-FIN.

      *-----------------------------------------------------------------

       0110-AFFICHE-MENU-DEB.

           DISPLAY WS-CADRE.
           DISPLAY "=" WS-VIDE "Menu notes" WS-VIDE "=".
           DISPLAY WS-CADRE.
           
           DISPLAY SPACES.
           DISPLAY SPACES.

           DISPLAY WS-VIDE-2 "1-Afficher la moyenne des notes".
           DISPLAY SPACES.

           DISPLAY WS-VIDE-2 "2-Afficher la note la plus basse".
           DISPLAY SPACES.

           DISPLAY WS-VIDE-2 "3-Afficher la note la plus haute".
           DISPLAY SPACES.

           DISPLAY WS-VIDE-2 "4-Quitter le programme".

           DISPLAY SPACES.
           DISPLAY SPACES.
           DISPLAY WS-CADRE.

           DISPLAY "Choisissez une option : " WITH NO ADVANCING.
           EXIT.

       0110-AFFICHE-MENU-FIN.

      *-----------------------------------------------------------------
       
       0120-CHOIX-MENU-DEB.
           
           ACCEPT WS-CHOIX.
           EVALUATE WS-CHOIX
       
                   WHEN 1
                       PERFORM 0200-MOY-NOTES-DEB
                          THRU 0200-MOY-NOTES-FIN
       
                   WHEN 2
                       PERFORM 0300-NOTE-MIN-DEB
                          THRU 0300-NOTE-MIN-FIN

                   WHEN 3
                       PERFORM 0400-NOTE-MAX-DEB
                          THRU 0400-NOTE-MAX-FIN

                   WHEN 4
                       PERFORM 0500-QUITTER-PROG-DEB
                          THRU 0500-QUITTER-PROG-FIN
                       
                   WHEN OTHER 
                       DISPLAY "Erreur : veuillez saisir une des "
                               "options proposées."

           END-EVALUATE.

           EXIT.

       0120-CHOIX-MENU-FIN.

      *-----------------------------------------------------------------

       0200-MOY-NOTES-DEB.

      * Calcul de la moyenne des notes.
           PERFORM 0210-CALC-MOY-NOTE-DEB
              THRU 0210-CALC-MOY-NOTE-FIN.

           SET WS-RETOUR-N TO TRUE.
       
      * Boucle tant que l'utilisateur ne choisit de retourner au menu
      * principal.
           PERFORM UNTIL WS-RETOUR-O 

      * Affichage de la moyenne.
               PERFORM 0220-AFFICHE-MOY-NOTE-DEB
                  THRU 0220-AFFICHE-MOY-NOTE-FIN

      * Demande à l'utilisateur s'il veur retourner au menu principal.         
               PERFORM 0230-RETOUR-MENU-DEB
                  THRU 0230-RETOUR-MENU-FIN

           END-PERFORM.
           EXIT.

       0200-MOY-NOTES-FIN.

      *-----------------------------------------------------------------

       0210-CALC-MOY-NOTE-DEB.
           
      * Initialisation des variables à utiliser.
           INITIALIZE WS-SOMME.
           INITIALIZE WS-MOY-NOTE.

      * Somme des notes saisies.
           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 10
               ADD WS-NOTE(WS-IDX) TO WS-SOMME
           END-PERFORM. 

      * Calcul de la moyenne à l'aide de la somme.
           DIVIDE WS-SOMME BY 10 GIVING WS-MOY-NOTE.

           EXIT.

       0210-CALC-MOY-NOTE-FIN.

      *-----------------------------------------------------------------
       
       0220-AFFICHE-MOY-NOTE-DEB.

           DISPLAY "Moyenne des notes : " WITH NO ADVANCING 
                   WS-MOY-NOTE.

           EXIT.

       0220-AFFICHE-MOY-NOTE-FIN.
       
      *-----------------------------------------------------------------

       0230-RETOUR-MENU-DEB.

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
       0230-RETOUR-MENU-FIN.

      *-----------------------------------------------------------------

       0300-NOTE-MIN-DEB.
           
           PERFORM 0310-CHERCHE-MIN-DEB
              THRU 0310-CHERCHE-MIN-FIN.

           SET WS-RETOUR-N TO TRUE.
           
           PERFORM UNTIL WS-RETOUR-O 

               PERFORM 0320-AFFICHE-MIN-DEB
                  THRU 0320-AFFICHE-MIN-FIN

               PERFORM 0230-RETOUR-MENU-DEB
                  THRU 0230-RETOUR-MENU-FIN

           END-PERFORM.
            
           EXIT.

       0300-NOTE-MIN-FIN.

      *-----------------------------------------------------------------

       0310-CHERCHE-MIN-DEB.

      * Initialisation du minimum à la valeur maximale possible.
           MOVE 20 TO WS-NOTE-MIN.

      * Boucle de recherche de la note minimale, à chaque fois qu'une 
      * note est inférieure à la variable du minimum, cette dernière 
      * prend la valeur de la note.  
           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 10
               IF WS-NOTE(WS-IDX) < WS-NOTE-MIN
                   MOVE WS-NOTE(WS-IDX) TO WS-NOTE-MIN
               END-IF 
           END-PERFORM.

           EXIT.

       0310-CHERCHE-MIN-FIN.

      *-----------------------------------------------------------------

       0320-AFFICHE-MIN-DEB.

           DISPLAY "Note minimale : " WITH NO ADVANCING 
                   WS-NOTE-MIN.

           EXIT.

       0320-AFFICHE-MIN-FIN.

      *-----------------------------------------------------------------

       0400-NOTE-MAX-DEB.

           PERFORM 0410-CHERCHE-MAX-DEB
              THRU 0410-CHERCHE-MAX-FIN.
           
           SET WS-RETOUR-N TO TRUE.

           PERFORM UNTIL WS-RETOUR-O 

               PERFORM 0420-AFFICHE-MAX-DEB
                  THRU 0420-AFFICHE-MAX-FIN

               PERFORM 0230-RETOUR-MENU-DEB
                  THRU 0230-RETOUR-MENU-FIN

           END-PERFORM.

           EXIT.
       
       0400-NOTE-MAX-FIN.

      *-----------------------------------------------------------------

       0410-CHERCHE-MAX-DEB.

      * Initialisation du maximum à la valeur minimale possible.
           MOVE 0 TO WS-NOTE-MAX.

      * Boucle de recherche de la note maximale, à chaque fois qu'une 
      * note est supérieure à la variable du maximum, cette dernière 
      * prend la valeur de la note.  
           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 10
               IF WS-NOTE(WS-IDX) > WS-NOTE-MAX
                   MOVE WS-NOTE(WS-IDX) TO WS-NOTE-MAX
               END-IF 
           END-PERFORM.

           EXIT.

       0410-CHERCHE-MAX-FIN.

      *-----------------------------------------------------------------

       0420-AFFICHE-MAX-DEB.

           DISPLAY "Note maximale : " WITH NO ADVANCING 
                   WS-NOTE-MAX.

           EXIT.

       0420-AFFICHE-MAX-FIN.

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

