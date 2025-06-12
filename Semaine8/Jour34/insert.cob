       IDENTIFICATION DIVISION.
       PROGRAM-ID. insert.
       AUTHOR. ThomasD.


      ******************************************************************
      *                         DATA DIVISION                          * 
      ******************************************************************
       DATA DIVISION.

       WORKING-STORAGE SECTION.
OCESQL*EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       
       01 WS-NOM-UTILISATEUR       PIC X(50).
       01 WS-MDP-UTILISATEUR       PIC X(50).

OCESQL*EXEC SQL END DECLARE SECTION END-EXEC.

OCESQL*EXEC SQL INCLUDE SQLCA END-EXEC.
OCESQL     copy "sqlca.cbl".
       
OCESQL*
OCESQL 01  SQ0001.
OCESQL     02  FILLER PIC X(052) VALUE "INSERT INTO utilisateurs(nom, "
OCESQL  &  "mdp) VALUES ( $1, $2 )".
OCESQL     02  FILLER PIC X(1) VALUE X"00".
OCESQL*
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
       
OCESQL*    EXEC SQL 
OCESQL*        INSERT INTO utilisateurs(nom, mdp)
OCESQL*        VALUES (:WS-NOM-UTILISATEUR, :WS-MDP-UTILISATEUR)
OCESQL*    END-EXEC 
OCESQL     CALL "OCESQLStartSQL"
OCESQL     END-CALL
OCESQL     CALL "OCESQLSetSQLParams" USING
OCESQL          BY VALUE 16
OCESQL          BY VALUE 50
OCESQL          BY VALUE 0
OCESQL          BY REFERENCE WS-NOM-UTILISATEUR
OCESQL     END-CALL
OCESQL     CALL "OCESQLSetSQLParams" USING
OCESQL          BY VALUE 16
OCESQL          BY VALUE 50
OCESQL          BY VALUE 0
OCESQL          BY REFERENCE WS-MDP-UTILISATEUR
OCESQL     END-CALL
OCESQL     CALL "OCESQLExecParams" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE SQ0001
OCESQL          BY VALUE 2
OCESQL     END-CALL
OCESQL     CALL "OCESQLEndSQL"
OCESQL     END-CALL
           
           IF SQLCODE = 0
              DISPLAY "Insertion réussie." 
OCESQL*       EXEC SQL COMMIT END-EXEC 
OCESQL     CALL "OCESQLStartSQL"
OCESQL     END-CALL
OCESQL     CALL "OCESQLExec" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE "COMMIT" & x"00"
OCESQL     END-CALL
OCESQL     CALL "OCESQLEndSQL"
OCESQL     END-CALL

           ELSE
              DISPLAY "Erreur d'insertion SQLCODE: " SQLCODE
OCESQL*       EXEC SQL ROLLBACK END-EXEC 
OCESQL     CALL "OCESQLStartSQL"
OCESQL     END-CALL
OCESQL     CALL "OCESQLExec" USING
OCESQL          BY REFERENCE SQLCA
OCESQL          BY REFERENCE "ROLLBACK" & x"00"
OCESQL     END-CALL
OCESQL     CALL "OCESQLEndSQL"
OCESQL     END-CALL
           END-IF 

           MOVE WS-NOM-UTILISATEUR TO LK-NOM-UTILISATEUR
           MOVE WS-MDP-UTILISATEUR TO LK-MDP-UTILISATEUR

       END-PERFORM.

       END PROGRAM insert.
