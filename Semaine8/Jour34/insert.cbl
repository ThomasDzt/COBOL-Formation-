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
       
      *01 WS-IDX PIC 9(02).

       LINKAGE SECTION.


      * Déclaration des variables correspondant aux attributs de ma table SQL

      *COPY user ==:PREFIX:== BY ==LK==.
       01 LK-NOM-UTILISATEUR       PIC X(50).
       01 LK-MDP-UTILISATEUR       PIC X(50).





      ******************************************************************
      *                      PROCEDURE DIVISION                        * 
      ****************************************************************** 
       
       PROCEDURE DIVISION USING LK-NOM-UTILISATEUR
                                LK-MDP-UTILISATEUR.
                                
       
       PERFORM 0100-SAISIE-INSER-DEBUT
          THRU 0100-SAISIE-INSER-FIN.

       
       EXIT PROGRAM.
      ******************************************************************
      *                         PARAGRAPHES                            * 
      ******************************************************************
       
       0100-SAISIE-INSER-DEBUT.

       PERFORM 3 TIMES
           DISPLAY "Saisir un nom d'utilisateur : "
           ACCEPT WS-NOM-UTILISATEUR
           DISPLAY "Saisir un mot de passe pour cet utilisateur : "
           ACCEPT WS-MDP-UTILISATEUR
           
           PERFORM 0150-INSERT-SQL-DEBUT
              THRU 0150-INSERT-SQL-FIN

          

           MOVE WS-NOM-UTILISATEUR TO LK-NOM-UTILISATEUR
           MOVE WS-MDP-UTILISATEUR TO LK-MDP-UTILISATEUR

       END-PERFORM.
       0100-SAISIE-INSER-FIN.
       EXIT.
      *-----------------------------------------------------------------
       0150-INSERT-SQL-DEBUT.
       EXEC SQL 
           INSERT INTO utilisateurs(nom, mdp)
           VALUES (:WS-NOM-UTILISATEUR, :WS-MDP-UTILISATEUR)
       END-EXEC 
           
       IF SQLCODE = 0
          DISPLAY "Insertion réussie." 
          EXEC SQL COMMIT END-EXEC 

       ELSE
          DISPLAY "Erreur d'insertion SQLCODE: " SQLCODE
          DISPLAY "Longueur insuffisante de mot de passe "
          EXEC SQL ROLLBACK END-EXEC 
       END-IF. 

       0150-INSERT-SQL-FIN.
       EXIT.
       
      *-----------------------------------------------------------------
       END PROGRAM insert.
       
