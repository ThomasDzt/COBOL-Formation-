       IDENTIFICATION DIVISION.
       PROGRAM-ID. insertusr.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01  UTILISATEUR-NOM     PIC X(100).
       01  UTILISATEUR-PRENOM  PIC X(100).
       01  UTILISATEUR-AGE     PIC 9(03).
       01  UTILISATEUR-NUM     PIC X(10).
       01  USERNAME       PIC X(30) VALUE "postgres".
       01  PASSWD         PIC X(30) VALUE "mdp".
       01  DBNAME         PIC X(10) VALUE "testdb".
       EXEC SQL END DECLARE SECTION END-EXEC.

       EXEC SQL INCLUDE SQLCA END-EXEC.

       PROCEDURE DIVISION.
       DISPLAY "Connexion à la base de données...".
       EXEC SQL
            CONNECT :USERNAME IDENTIFIED BY :PASSWD USING :DBNAME
       END-EXEC.
       IF SQLCODE NOT = 0
           DISPLAY "Erreur de connexion SQLCODE: " SQLCODE
           STOP RUN
       END-IF.

       DISPLAY "Entrez le nom de l'utilisateur : ".
       ACCEPT UTILISATEUR-NOM.
       DISPLAY "Entrez le prénom de l'utilisateur : ".
       ACCEPT UTILISATEUR-PRENOM.
       DISPLAY "Entrez l'âge de l'utilisateur : ".
       ACCEPT UTILISATEUR-AGE.
       DISPLAY "Entrez le numéro de l'utilisateur : ".
       ACCEPT UTILISATEUR-NUM.
       
       EXEC SQL
            INSERT INTO utilisateur (nom, prenom, age, numero)
            VALUES (:UTILISATEUR-NOM, :UTILISATEUR-PRENOM,
             :UTILISATEUR-AGE, :UTILISATEUR-NUM)
       END-EXEC.
       IF SQLCODE = 0
           DISPLAY "Insertion réussie."
       ELSE
           DISPLAY "Erreur d'insertion SQLCODE: " SQLCODE
       END-IF.

       EXEC SQL COMMIT END-EXEC.
       STOP RUN.
