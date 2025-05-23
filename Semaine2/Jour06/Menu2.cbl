      *Exercice: Créer un programme qui gère une to-do list
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Menu.
       AUTHOR. ThomasD.

       ENVIRONMENT DIVISION.
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
      
      *Création d'une variable numérique indiquant la fonctionnalité
      * voulue
       01  WS-CASE     PIC 9.

      *Création des variables alphabétiques indiquant les tâches
       01  WS-TASK     PIC X(50).
       01  WS-TASK1    PIC X(50).
       01  WS-TASK2    PIC X(50).
       01  WS-TASK3    PIC X(50).
       01  WS-TASK4    PIC X(50).
       01  WS-TASK5    PIC X(50).

      *Sélection de tâche pour les différentes fonctionnalités
       
       01 WS-CHOICE    PIC 9.

      *Création d'une variable numérique déterminant la sortie de boucle de certaines fonctionnalités
       01 WS-STAY      PIC 9.
       01 WS-STAY-BIS  PIC 9.


       PROCEDURE DIVISION.
               
               
      *Création de la boucle permettant de rester dans le menu
       PERFORM UNTIL WS-CASE = 4
           PERFORM 0100-MENU-START 
              THRU 0100-MENU-END
       END-PERFORM.

       STOP RUN.

           
      ******************************************************************
       0100-MENU-START .
      
      *Saisie de la valeur associée à la fonctionnalité voulue
       DISPLAY "Choisir une fonctionnalité"
       DISPLAY "1- Ajouter une tâche"
       DISPLAY "2- Afficher les tâches"
       DISPLAY "3- Supprimer une tâche"
       DISPLAY "4- Quitter le programme".
       
       ACCEPT WS-CASE.
       
      *Création des instructions de la branche conditionnelle associée aux différentes fonctionnalités
           EVALUATE WS-CASE 
           
               WHEN 1 

      *Saisie de la tâche à rajouter
      
                   MOVE 1 TO WS-STAY
                   PERFORM UNTIL WS-STAY = 2

                       
                   
                       DISPLAY "Saisir une tâche:"
                       ACCEPT WS-TASK
                   
                       DISPLAY "Choisir où ajouter la tâche saisie:"
                       ACCEPT WS-CHOICE

                   
                       
                       IF WS-CHOICE > 0 AND < 6

                           EVALUATE TRUE 
                               WHEN WS-CHOICE = 1
                                   MOVE WS-TASK TO WS-TASK1
                       
                               WHEN WS-CHOICE = 2
                                   MOVE WS-TASK TO WS-TASK2

                               WHEN WS-CHOICE = 3
                                   MOVE WS-TASK TO WS-TASK3

                               WHEN WS-CHOICE = 4
                                   MOVE WS-TASK TO WS-TASK4

                               WHEN WS-CHOICE = 5
                                   MOVE WS-TASK TO WS-TASK5

                               WHEN OTHER
                                   CONTINUE
                           END-EVALUATE
                       
                           

                       ELSE 
                           MOVE 2 TO WS-STAY
                           EXIT
                       END-IF
                   END-PERFORM
                   
                   
               
               WHEN 2

      *Affichage des différentes tâches 
               
                   IF WS-TASK1 NOT = " "
                       DISPLAY "Tâche 1 " WS-TASK1
                   END-IF


                   IF WS-TASK2 NOT = " "
                       DISPLAY "Tâche 2 " WS-TASK2
                   END-IF 


                   IF WS-TASK3 NOT = " "
                       DISPLAY "Tâche 3 " WS-TASK3
                   END-IF


                   IF WS-TASK4 NOT = " "
                       DISPLAY "Tâche 4 " WS-TASK4
                   END-IF 


                   IF WS-TASK5 NOT = " " 
                       DISPLAY "Tâche 5 " WS-TASK5
                   END-IF 
                       
               


      *Suppression des tâches saisies

               WHEN 3

                   MOVE 1 TO WS-STAY-BIS
                   PERFORM UNTIL WS-STAY-BIS  = 2
                       
                       

                       DISPLAY "Suppression de tâches:"
                       MOVE " " TO WS-TASK

                       DISPLAY "Choisir quelle tâche supprimer:"
                       ACCEPT WS-CHOICE

                       IF WS-CHOICE > 0 AND < 6

                           EVALUATE TRUE 
                   
                               WHEN WS-CHOICE = 1
                                   MOVE WS-TASK TO WS-TASK1
                                   DISPLAY "Tâche 1 supprimée"
                       

                               WHEN WS-CHOICE = 2
                                   MOVE WS-TASK TO WS-TASK2
                                   DISPLAY "Tâche 2 supprimée"


                               WHEN WS-CHOICE = 3
                                   MOVE WS-TASK TO WS-TASK3
                                   DISPLAY "Tâche 3 supprimée"


                               WHEN WS-CHOICE = 4
                                   MOVE WS-TASK TO WS-TASK4
                                   DISPLAY "Tâche 4 supprimée"


                               WHEN WS-CHOICE = 5
                                   MOVE WS-TASK TO WS-TASK5
                                   DISPLAY "Tâche 5 supprimée"
   

                           END-EVALUATE          
     
                       ELSE 
                           MOVE 2 TO WS-STAY-BIS
                           EXIT

                       END-IF
                   END-PERFORM

               WHEN OTHER 
                   CONTINUE
           
           
           END-EVALUATE.


       0100-MENU-END .
           EXIT.
           