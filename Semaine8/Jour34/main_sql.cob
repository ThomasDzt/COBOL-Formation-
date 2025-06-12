       IDENTIFICATION DIVISION.
       PROGRAM-ID. main_sql.
       AUTHOR. ThomasD.


      ******************************************************************
      *                         DATA DIVISION                          * 
      ******************************************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.

OCESQL*EXEC SQL BEGIN DECLARE SECTION END-EXEC.

      * Déclaration des variables correspondant aux attributs de ma table SQL
       01 WS-ID-UTILISATEUR        PIC 9(10).
       
       COPY user REPLACING ==:PREFIX:== BY ==WS==.

      * Déclaration des variables correspondant aux identifiants PSQL et à ma base de données
       01  WS-IDENTIFIANT       PIC X(30) VALUE "postgres".
       01  WS-MOT-PASSE         PIC X(30) VALUE "mdp".
       01  WS-NOM-BASE          PIC X(15) VALUE "exo_database". 
OCESQL*EXEC SQL END DECLARE SECTION END-EXEC.
       
       01 WS-LONGUEUR-MDP          PIC 9(02).

OCESQL*EXEC SQL INCLUDE SQLCA END-EXEC.
OCESQL     copy "sqlca.cbl".



      ******************************************************************
      *                      PROCEDURE DIVISION                        * 
      ****************************************************************** 
       
OCESQL*
       PROCEDURE DIVISION.

       DISPLAY "Connexion à la base de données...".
OCESQL*EXEC SQL 
OCESQL*    CONNECT :WS-IDENTIFIANT 
OCESQL*    IDENTIFIED BY :WS-MOT-PASSE 
OCESQL*    USING :WS-NOM-BASE
OCESQL*END-EXEC.
OCESQL     CALL "OCESQLConnect" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE WS-IDENTIFIANT
OCESQL          BY VALUE 30
OCESQL          BY REFERENCE WS-MOT-PASSE
OCESQL          BY VALUE 30
OCESQL          BY REFERENCE WS-NOM-BASE
OCESQL          BY VALUE 15
OCESQL     END-CALL.

       IF SQLCODE NOT = 0
           DISPLAY "Erreur de connexion SQLCODE: " SQLCODE
      *    STOP RUN 
       END-IF.

       PERFORM 0100-INSERTION-DEBUT
          THRU 0100-INSERTION-FIN.


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

       0100-INSERTION-DEBUT.
       CALL "insert" USING WS-NOM-UTILISATEUR
                           WS-MDP-UTILISATEUR
                           
       
       END-CALL.


       0100-INSERTION-FIN.
       EXIT.
