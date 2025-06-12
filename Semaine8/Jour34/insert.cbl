       IDENTIFICATION DIVISION.
       PROGRAM-ID. insert.
       AUTHOR. ThomasD.


      ******************************************************************
      *                         DATA DIVISION                          * 
      ******************************************************************
       DATA DIVISION.

       WORKING-STORAGE SECTION.
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       
       01 WS-NOM-UTILISATEUR       PIC X(50).
       01 WS-MDP-UTILISATEUR       PIC X(50).

       EXEC SQL END DECLARE SECTION END-EXEC.

       EXEC SQL INCLUDE SQLCA END-EXEC.
       
       LINKAGE SECTION.


      * Déclaration des variables correspondant aux attributs de ma table SQL

      *COPY user ==:PREFIX:== BY ==LK==.
       01 LK-NOM-UTILISATEUR       PIC X(50).
       01 LK-MDP-UTILISATEUR       PIC X(50).





      ******************************************************************
      *                      PROCEDURE DIVISION                        * 
      ****************************************************************** 
       
       PROCEDURE DIVISION USING LK-NOM-UTILISATEUR,
                                LK-MDP-UTILISATEUR.
       
       PERFORM 3 TIMES
           DISPLAY "Saisir un nom d'utilisateur : "
           ACCEPT WS-NOM-UTILISATEUR
           DISPLAY "Saisir un mot de passe pour cet utilisateur : "
           ACCEPT WS-MDP-UTILISATEUR
       
           EXEC SQL 
               INSERT INTO utilisateurs(nom, mdp)
               VALUES (:WS-NOM-UTILISATEUR, :WS-MDP-UTILISATEUR)
           END-EXEC 
           
           IF SQLCODE = 0
              DISPLAY "Insertion réussie." 
              EXEC SQL COMMIT END-EXEC 

           ELSE
              DISPLAY "Erreur d'insertion SQLCODE: " SQLCODE
              EXEC SQL ROLLBACK END-EXEC 
           END-IF 

           MOVE WS-NOM-UTILISATEUR TO LK-NOM-UTILISATEUR
           MOVE WS-MDP-UTILISATEUR TO LK-MDP-UTILISATEUR

       END-PERFORM.

       END PROGRAM insert.
