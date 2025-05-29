       IDENTIFICATION DIVISION.
       PROGRAM-ID. inserindi.
       AUTHOR. ThomasD.

      ******************************************************************
      *                         DATA DIVISION                          * 
      ******************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * Déclaration des variables correspondant aux attributs de ma table SQL
OCESQL*EXEC SQL BEGIN DECLARE SECTION END-EXEC.

       01  INDIVIDU-ID      PIC 9(04).
       01  INDIVIDU-NOM     PIC X(50).
       01  INDIVIDU-PRENOM  PIC X(50).
       01  INDIVIDU-TEL     PIC X(10).
       

      * Déclaration des variables correspondant aux identifiants PSQL et à ma base de données       
       01  USERNAME       PIC X(30) VALUE "postgres".
       01  PASSWD         PIC X(30) VALUE "mdp".
       01  DBNAME         PIC X(10) VALUE "testdb". 

OCESQL*EXEC SQL END DECLARE SECTION END-EXEC.

OCESQL*EXEC SQL INCLUDE SQLCA END-EXEC.
OCESQL     copy "sqlca.cbl".
       
       01 WS-CRUD   PIC X.
       01 WS-CONTINUE  PIC X.
           88 WS-CONTINUE-Y    VALUE "Y".
           88 WS-CONTINUE-N    VALUE "n".
           

      ******************************************************************
      *                      PROCEDURE DIVISION                        * 
      ****************************************************************** 
OCESQL*
OCESQL 01  SQ0001.
OCESQL     02  FILLER PIC X(068) VALUE "INSERT INTO individus (nom, pr"
OCESQL  &  "enom, telephone) VALUES ( $1, $2, $3 )".
OCESQL     02  FILLER PIC X(1) VALUE X"00".
OCESQL*
OCESQL 01  SQ0002.
OCESQL     02  FILLER PIC X(058) VALUE "SELECT nom, prenom, telephone "
OCESQL  &  "FROM individus WHERE id = $1".
OCESQL     02  FILLER PIC X(1) VALUE X"00".
OCESQL*
OCESQL 01  SQ0003.
OCESQL     02  FILLER PIC X(072) VALUE "UPDATE individus SET nom = $1,"
OCESQL  &  " prenom = $2, telephone = $3 WHERE id = $4".
OCESQL     02  FILLER PIC X(1) VALUE X"00".
OCESQL*
OCESQL 01  SQ0004.
OCESQL     02  FILLER PIC X(035) VALUE "DELETE FROM individus WHERE id"
OCESQL  &  " = $1".
OCESQL     02  FILLER PIC X(1) VALUE X"00".
OCESQL*
       PROCEDURE DIVISION.

       DISPLAY "Connexion à la base de données...".
OCESQL*EXEC SQL
OCESQL*     CONNECT :USERNAME IDENTIFIED BY :PASSWD USING :DBNAME
OCESQL*END-EXEC.
OCESQL     CALL "OCESQLConnect" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE USERNAME
OCESQL          BY VALUE 30
OCESQL          BY REFERENCE PASSWD
OCESQL          BY VALUE 30
OCESQL          BY REFERENCE DBNAME
OCESQL          BY VALUE 10
OCESQL     END-CALL.

       IF SQLCODE NOT = 0
           DISPLAY "Erreur de connexion SQLCODE: " SQLCODE
           STOP RUN 
       END-IF.

       

       PERFORM 1000-MENU-DEBUT
          THRU 1000-MENU-FIN.
      
       PERFORM 2000-CRUD-DEBUT
          THRU 2000-CRUD-FIN.
       
       
       
OCESQL*EXEC SQL COMMIT END-EXEC.
OCESQL     CALL "OCESQLStartSQL"
OCESQL     END-CALL
OCESQL     CALL "OCESQLExec" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE "COMMIT" & x"00"
OCESQL     END-CALL
OCESQL     CALL "OCESQLEndSQL"
OCESQL     END-CALL.
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

OCESQL*       EXEC SQL
OCESQL*          INSERT INTO individus (nom, prenom, telephone)
OCESQL*          VALUES (:INDIVIDU-NOM, :INDIVIDU-PRENOM,
OCESQL*                 :INDIVIDU-TEL)
OCESQL*       END-EXEC
OCESQL     CALL "OCESQLStartSQL"
OCESQL     END-CALL
OCESQL     CALL "OCESQLSetSQLParams" USING
OCESQL          BY VALUE 16
OCESQL          BY VALUE 50
OCESQL          BY VALUE 0
OCESQL          BY REFERENCE INDIVIDU-NOM
OCESQL     END-CALL
OCESQL     CALL "OCESQLSetSQLParams" USING
OCESQL          BY VALUE 16
OCESQL          BY VALUE 50
OCESQL          BY VALUE 0
OCESQL          BY REFERENCE INDIVIDU-PRENOM
OCESQL     END-CALL
OCESQL     CALL "OCESQLSetSQLParams" USING
OCESQL          BY VALUE 16
OCESQL          BY VALUE 10
OCESQL          BY VALUE 0
OCESQL          BY REFERENCE INDIVIDU-TEL
OCESQL     END-CALL
OCESQL     CALL "OCESQLExecParams" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE SQ0001
OCESQL          BY VALUE 3
OCESQL     END-CALL
OCESQL     CALL "OCESQLEndSQL"
OCESQL     END-CALL
              
              IF SQLCODE = 0
                 DISPLAY "Insertion réussie."
              ELSE
                 DISPLAY "Erreur d'insertion SQLCODE: " SQLCODE
              END-IF
           

           WHEN "R"
              
              DISPLAY "Entrez l'id de l'individu voulu : "
              ACCEPT INDIVIDU-ID

OCESQL*       EXEC SQL 
OCESQL*          SELECT nom, prenom, telephone 
OCESQL*          INTO :INDIVIDU-NOM, :INDIVIDU-PRENOM, :INDIVIDU-TEL 
OCESQL*          FROM individus
OCESQL*          WHERE id = :INDIVIDU-ID
OCESQL*       END-EXEC
OCESQL     CALL "OCESQLStartSQL"
OCESQL     END-CALL
OCESQL     CALL "OCESQLSetResultParams" USING
OCESQL          BY VALUE 16
OCESQL          BY VALUE 50
OCESQL          BY VALUE 0
OCESQL          BY REFERENCE INDIVIDU-NOM
OCESQL     END-CALL
OCESQL     CALL "OCESQLSetResultParams" USING
OCESQL          BY VALUE 16
OCESQL          BY VALUE 50
OCESQL          BY VALUE 0
OCESQL          BY REFERENCE INDIVIDU-PRENOM
OCESQL     END-CALL
OCESQL     CALL "OCESQLSetResultParams" USING
OCESQL          BY VALUE 16
OCESQL          BY VALUE 10
OCESQL          BY VALUE 0
OCESQL          BY REFERENCE INDIVIDU-TEL
OCESQL     END-CALL
OCESQL     CALL "OCESQLSetSQLParams" USING
OCESQL          BY VALUE 1
OCESQL          BY VALUE 4
OCESQL          BY VALUE 0
OCESQL          BY REFERENCE INDIVIDU-ID
OCESQL     END-CALL
OCESQL     CALL "OCESQLExecSelectIntoOne" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE SQ0002
OCESQL          BY VALUE 1
OCESQL          BY VALUE 3
OCESQL     END-CALL
OCESQL     CALL "OCESQLEndSQL"
OCESQL     END-CALL
              
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
              
OCESQL*       EXEC SQL 
OCESQL*          UPDATE individus
OCESQL*          SET nom = :INDIVIDU-NOM, 
OCESQL*          prenom = :INDIVIDU-PRENOM,
OCESQL*          telephone = :INDIVIDU-TEL
OCESQL*          WHERE id = :INDIVIDU-ID
OCESQL*       END-EXEC
OCESQL     CALL "OCESQLStartSQL"
OCESQL     END-CALL
OCESQL     CALL "OCESQLSetSQLParams" USING
OCESQL          BY VALUE 16
OCESQL          BY VALUE 50
OCESQL          BY VALUE 0
OCESQL          BY REFERENCE INDIVIDU-NOM
OCESQL     END-CALL
OCESQL     CALL "OCESQLSetSQLParams" USING
OCESQL          BY VALUE 16
OCESQL          BY VALUE 50
OCESQL          BY VALUE 0
OCESQL          BY REFERENCE INDIVIDU-PRENOM
OCESQL     END-CALL
OCESQL     CALL "OCESQLSetSQLParams" USING
OCESQL          BY VALUE 16
OCESQL          BY VALUE 10
OCESQL          BY VALUE 0
OCESQL          BY REFERENCE INDIVIDU-TEL
OCESQL     END-CALL
OCESQL     CALL "OCESQLSetSQLParams" USING
OCESQL          BY VALUE 1
OCESQL          BY VALUE 4
OCESQL          BY VALUE 0
OCESQL          BY REFERENCE INDIVIDU-ID
OCESQL     END-CALL
OCESQL     CALL "OCESQLExecParams" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE SQ0003
OCESQL          BY VALUE 4
OCESQL     END-CALL
OCESQL     CALL "OCESQLEndSQL"
OCESQL     END-CALL

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

OCESQL*       EXEC SQL
OCESQL*          DELETE FROM individus
OCESQL*          WHERE id = :INDIVIDU-ID  
OCESQL*       END-EXEC
OCESQL     CALL "OCESQLStartSQL"
OCESQL     END-CALL
OCESQL     CALL "OCESQLSetSQLParams" USING
OCESQL          BY VALUE 1
OCESQL          BY VALUE 4
OCESQL          BY VALUE 0
OCESQL          BY REFERENCE INDIVIDU-ID
OCESQL     END-CALL
OCESQL     CALL "OCESQLExecParams" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE SQ0004
OCESQL          BY VALUE 1
OCESQL     END-CALL
OCESQL     CALL "OCESQLEndSQL"
OCESQL     END-CALL

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










