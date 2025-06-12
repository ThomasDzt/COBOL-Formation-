       IDENTIFICATION DIVISION.
       PROGRAM-ID. main_sql.
       AUTHOR. ThomasD.


      ******************************************************************
      *                         DATA DIVISION                          * 
      ******************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       EXEC SQL BEGIN DECLARE SECTION END-EXEC.

      * Déclaration des variables correspondant aux attributs de ma table SQL
       01 WS-ID-UTILISATEUR        PIC 9(10).
       
       COPY user REPLACING ==:PREFIX:== BY ==WS==.

      * Déclaration des variables correspondant aux identifiants PSQL et à ma base de données
       01  WS-IDENTIFIANT       PIC X(30) VALUE "postgres".
       01  WS-MOT-PASSE         PIC X(30) VALUE "mdp".
       01  WS-NOM-BASE          PIC X(15) VALUE "exo_database". 
       EXEC SQL END DECLARE SECTION END-EXEC.

       EXEC SQL INCLUDE SQLCA END-EXEC.



      ******************************************************************
      *                      PROCEDURE DIVISION                        * 
      ****************************************************************** 
       
       PROCEDURE DIVISION.

       DISPLAY "Connexion à la base de données...".
       EXEC SQL 
           CONNECT :WS-IDENTIFIANT 
           IDENTIFIED BY :WS-MOT-PASSE 
           USING :WS-NOM-BASE
       END-EXEC.

       IF SQLCODE NOT = 0
           DISPLAY "Erreur de connexion SQLCODE: " SQLCODE
      *    STOP RUN 
       END-IF.

       PERFORM 0100-INSERTION-DEBUT
          THRU 0100-INSERTION-FIN.


       EXEC SQL COMMIT END-EXEC. 
       
       STOP RUN.

      ******************************************************************
      *                         PARAGRAPHES                            * 
      ******************************************************************

       0100-INSERTION-DEBUT.
       CALL "insert" USING WS-NOM-UTILISATEUR,
                           WS-MDP-UTILISATEUR
       END-CALL.


       0100-INSERTION-FIN.
       EXIT.
