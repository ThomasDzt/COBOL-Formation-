       IDENTIFICATION DIVISION.
       PROGRAM-ID. inserindi.
       AUTHOR. ThomasD.

      ******************************************************************
      *                         DATA DIVISION                          * 
      ******************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * Déclaration des variables correspondant aux attributs de ma table SQL
       EXEC SQL BEGIN DECLARE SECTION END-EXEC.

       01  INDIVIDU-ID      PIC 9(04).
       01  INDIVIDU-NOM     PIC X(50).
       01  INDIVIDU-PRENOM  PIC X(50).
       01  INDIVIDU-TEL     PIC X(10).
       

      * Déclaration des variables correspondant aux identifiants PSQL et à ma base de données       
       01  USERNAME       PIC X(30) VALUE "postgres".
       01  PASSWD         PIC X(30) VALUE "mdp".
       01  DBNAME         PIC X(10) VALUE "testdb". 

       EXEC SQL END DECLARE SECTION END-EXEC.

       EXEC SQL INCLUDE SQLCA END-EXEC.
       
       01 WS-CRUD   PIC X.
       01 WS-CONTINUE  PIC X.
           88 WS-CONTINUE-Y    VALUE "Y".
           88 WS-CONTINUE-N    VALUE "n".
           

      ******************************************************************
      *                      PROCEDURE DIVISION                        * 
      ****************************************************************** 
       PROCEDURE DIVISION.

       DISPLAY "Connexion à la base de données...".
       EXEC SQL
            CONNECT :USERNAME IDENTIFIED BY :PASSWD USING :DBNAME
       END-EXEC.

       IF SQLCODE NOT = 0
           DISPLAY "Erreur de connexion SQLCODE: " SQLCODE
           STOP RUN 
       END-IF.

       

       PERFORM 1000-MENU-DEBUT
          THRU 1000-MENU-FIN.
      
       PERFORM 2000-CRUD-DEBUT
          THRU 2000-CRUD-FIN.
       
       
       
       EXEC SQL COMMIT END-EXEC.
       STOP RUN.

      ******************************************************************
      *                         PARAGRAPHES                            * 
      ******************************************************************
       1000-MENU-DEBUT.

           DISPLAY "----------Choisir une opération----------".
           DISPLAY "                           ".
           DISPLAY "                           ".
           DISPLAY "             Créer (C/c)         ".
           DISPLAY "                           ".
           DISPLAY "             Lire  (R/r)         ".
           DISPLAY "                           ".
           DISPLAY "           Modifier (U/u)      ".
           DISPLAY "                           ".
           DISPLAY "           Supprimer (D/d)     ".
           DISPLAY "                           ".
           ACCEPT WS-CRUD.


       1000-MENU-FIN.
           EXIT.

      *-----------------------------------------------------------------
       2000-CRUD-DEBUT.
       
       EVALUATE WS-CRUD
           
           WHEN "C" 
              
              PERFORM 2500-SAISIE-INDIV-DEBUT
                 THRU 2500-SAISIE-INDIV-FIN

              EXEC SQL
                 INSERT INTO individus (nom, prenom, telephone)
                 VALUES (:INDIVIDU-NOM, :INDIVIDU-PRENOM,
                        :INDIVIDU-TEL)
              END-EXEC
              
              IF SQLCODE = 0
                 DISPLAY "Insertion réussie."
              ELSE
                 DISPLAY "Erreur d'insertion SQLCODE: " SQLCODE
              END-IF
           

           WHEN "R"
              
              DISPLAY "Entrez l'id de l'individu voulu : "
              ACCEPT INDIVIDU-ID

              EXEC SQL 
                 SELECT nom, prenom, telephone 
                 INTO :INDIVIDU-NOM, :INDIVIDU-PRENOM, :INDIVIDU-TEL 
                 FROM individus
                 WHERE id = :INDIVIDU-ID
              END-EXEC
              
              IF SQLCODE = 0
                 DISPLAY "Lecture effectuée."
                 DISPLAY "Nom : " INDIVIDU-NOM
                 SPACES WITH NO ADVANCING 
                         "Prénom : " INDIVIDU-PRENOM
                 SPACES WITH NO ADVANCING
                         "Téléphone : " INDIVIDU-TEL
              
              ELSE
                 DISPLAY "Erreur de lecture SQLCODE: " SQLCODE
              END-IF


           WHEN "U"

              DISPLAY "Entrez l'id de l'individu voulu : "
              ACCEPT INDIVIDU-ID

              DISPLAY "Entrez le nom voulu : "
              ACCEPT INDIVIDU-NOM

              DISPLAY "Entrez le prénom voulu : "
              ACCEPT INDIVIDU-PRENOM
              
              DISPLAY "Entrez le numéro de téléphone voulu : "
              ACCEPT INDIVIDU-TEL 
              
              EXEC SQL 
                 UPDATE individus
                 SET nom = :INDIVIDU-NOM, 
                 prenom = :INDIVIDU-PRENOM,
                 telephone = :INDIVIDU-TEL
                 WHERE id = :INDIVIDU-ID
              END-EXEC

              IF SQLCODE = 0
                 DISPLAY "Modification effectuée."
                 DISPLAY "Nom : " INDIVIDU-NOM
                 SPACES WITH NO ADVANCING 
                         "Prénom : " INDIVIDU-PRENOM
                 SPACES WITH NO ADVANCING
                         "Téléphone : " INDIVIDU-TEL
              
              ELSE
                 DISPLAY "Erreur de modification SQLCODE: " SQLCODE
              END-IF



           WHEN "D"

              DISPLAY "Entrez l'id de l'individu voulu : "
              ACCEPT INDIVIDU-ID

              EXEC SQL
                 DELETE FROM individus
                 WHERE id = :INDIVIDU-ID  
              END-EXEC

              IF SQLCODE = 0
                 DISPLAY "Suppression effectuée."
              
              ELSE
                 DISPLAY "Erreur de suppression SQLCODE: " SQLCODE
              END-IF


       END-EVALUATE.
       
       

       2000-CRUD-FIN.
       EXIT.

      *-----------------------------------------------------------------

       2500-SAISIE-INDIV-DEBUT.
       
       DISPLAY "Entrez le nom de l'individu : ".
       ACCEPT INDIVIDU-NOM.
       DISPLAY "Entrez le prénom de l'individu : ".
       ACCEPT INDIVIDU-PRENOM.
       DISPLAY "Entrez le numéro de l'individu : ".
       ACCEPT INDIVIDU-TEL.


       2500-SAISIE-INDIV-FIN.
       EXIT.

      *-----------------------------------------------------------------

       








