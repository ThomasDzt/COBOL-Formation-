      *écrire un programme qui dmeande à l'utilisateur d'entrer 5 nombres et affiche le plus petit des 5
       IDENTIFICATION DIVISION.
       PROGRAM-ID. highest.
       AUTHOR. ThomasD & Lucas.


       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *un nombre de 3 chiffre qui correspond au minimum
       01 WS-MIN    PIC 9(3).
      *un nombre qui correspond au nombre que l'utilisateur vient d'entrer
       01 WS-VAR.

       PROCEDURE DIVISION. 

      *on demande à l'utilisateur d'entrer un nombre
       DISPLAY "Saisir un nombre".
      
      *on enregistre ce nombre dans nos 2 variable numériques
       ACCEPT WS-VAR.
       MOVE WS-VAR TO WS-MIN.

      *on demande à l'utilisateur d'entrer un second nombre et on l'enregistre dans la variable prévu à cet effet
       DISPLAY "Saisir un autre nombre".
       ACCEPT WS-VAR.

      *on compare le minimum actuelle avec le nombre qui vient d'être entrer
      *le plus petit des 2 devient le minimum et est enregistré dans la variable correspondante
       IF WS-VAR < WS-MIN 
           MOVE WS-VAR TO WS-MIN
       
       ELSE 
           CONTINUE
       END-IF.

      *on demande ensuite un 3ème chiffre à l'utilisateur
       DISPLAY "Saisir un autre nombre".
       ACCEPT WS-VAR.

      *on regarde le minimum entre le minimum actuelle et le nombre qu vient d'être enregistré
      *le plus petit des 2 devient le minimum
       
       IF WS-VAR < WS-MIN 
           MOVE WS-VAR TO WS-MIN
       
       ELSE 
           CONTINUE
       END-IF.

      *on refait cela encore 2 fois
       
       DISPLAY "Saisir un autre nombre".
       ACCEPT WS-VAR.
       
       IF WS-VAR < WS-MIN 
           MOVE WS-VAR TO WS-MIN
       
       ELSE 
           CONTINUE
       END-IF.


       DISPLAY "Saisir un autre nombre".
       ACCEPT WS-VAR.
       
       IF WS-VAR < WS-MIN 
           MOVE WS-VAR TO WS-MIN
       
       ELSE 
           CONTINUE
       END-IF.
       
      

      *on affiche maintenant le plus petit nombre que l'utilisateur a entrer
       DISPLAY WS-MIN.
      *on arrête le programme
       STOP RUN.