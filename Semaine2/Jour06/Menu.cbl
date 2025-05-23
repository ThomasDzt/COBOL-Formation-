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
       DISPLAY "Choisir une fonctionnalité".
       ACCEPT WS-CASE.
       
      *Création des instructions de la branche conditionnelle associée aux différentes fonctionnalités
           EVALUATE WS-CASE 
           
               WHEN 1 

      *Saisie de la tâche à rajouter

                   DISPLAY "Saisir une tâche:"
                   ACCEPT WS-TASK

                   EVALUATE TRUE 
                       WHEN WS-TASK1 = " "
                           MOVE WS-TASK TO WS-TASK1
                       
                       WHEN WS-TASK2 = " "
                           MOVE WS-TASK TO WS-TASK2

                       WHEN WS-TASK3 = " "
                           MOVE WS-TASK TO WS-TASK3

                       WHEN WS-TASK4 = " "
                           MOVE WS-TASK TO WS-TASK4

                       WHEN WS-TASK5 = " "
                           MOVE WS-TASK TO WS-TASK5

                       WHEN OTHER
                           MOVE WS-TASK TO WS-TASK5
                   END-EVALUATE
                   
                   
               
               WHEN 2

      *Affichage des différentes tâches 

                   DISPLAY "Tâche 1 " WS-TASK1
                   DISPLAY "Tâche 2 " WS-TASK2
                   DISPLAY "Tâche 3 " WS-TASK3
                   DISPLAY "Tâche 4 " WS-TASK4
                   DISPLAY "Tâche 5 " WS-TASK5


      *Suppression des tâches saisies

               WHEN 3

                   MOVE " " TO WS-TASK

                   EVALUATE TRUE 
                   
                       WHEN WS-TASK1 NOT = " "
                           MOVE WS-TASK TO WS-TASK1
                           DISPLAY "Tâche 1 supprimée"
                       

                       WHEN WS-TASK2 NOT = " "
                           MOVE WS-TASK TO WS-TASK2
                           DISPLAY "Tâche 2 supprimée"


                       WHEN WS-TASK3 NOT = " "
                           MOVE WS-TASK TO WS-TASK3
                           DISPLAY "Tâche 3 supprimée"


                       WHEN WS-TASK4 NOT = " "
                           MOVE WS-TASK TO WS-TASK4
                           DISPLAY "Tâche 4 supprimée"


                       WHEN WS-TASK5 NOT = " "
                           MOVE WS-TASK TO WS-TASK5
                           DISPLAY "Tâche 5 supprimée"
   

                   END-EVALUATE          
     

               WHEN OTHER 
                   CONTINUE
           
           
           END-EVALUATE.


       0100-MENU-END .
           EXIT.
           