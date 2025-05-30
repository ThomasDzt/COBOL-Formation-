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
       01 WS-QUITTER  PIC X   VALUE "n".
           88 WS-QUITTER-N    VALUE "n".
           88 WS-QUITTER-O    VALUE "O".
           

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
           DISPLAY "            Quitter (Q/q)     ".
           DISPLAY "                           ".
           


       1000-MENU-FIN.
           EXIT.

      *-----------------------------------------------------------------
       2000-CRUD-DEBUT.
       
       SET WS-QUITTER-N TO TRUE.

       PERFORM UNTIL WS-QUITTER-O
           
           DISPLAY "Choisir une option "
           ACCEPT WS-CRUD
           EVALUATE WS-CRUD
               
               WHEN "C" 
                  
                  PERFORM 2050-SAISIE-INDIV-DEBUT
                     THRU 2050-SAISIE-INDIV-FIN
                  
                  PERFORM 2100-CREER-INDIV-DEBUT
                     THRU 2100-CREER-INDIV-FIN
               
      
               WHEN "R"
                  
                  PERFORM 2060-DEMANDE-ID-DEBUT
                     THRU 2060-DEMANDE-ID-FIN
                  
                  PERFORM 2200-LIRE-INDIV-DEBUT
                     THRU 2200-LIRE-INDIV-FIN
                  
      
               WHEN "U"
      
                  PERFORM 2060-DEMANDE-ID-DEBUT
                     THRU 2060-DEMANDE-ID-FIN
      
                  PERFORM 2050-SAISIE-INDIV-DEBUT
                     THRU 2050-SAISIE-INDIV-FIN               
                  
                  PERFORM 2300-MODIFIER-INDIV-DEBUT
                     THRU 2300-MODIFIER-INDIV-FIN
      
      
               WHEN "D"
      
                  PERFORM 2060-DEMANDE-ID-DEBUT
                     THRU 2060-DEMANDE-ID-FIN
      
                  PERFORM 2400-SUPPRIMER-INDIV-DEBUT
                     THRU 2400-SUPPRIMER-INDIV-FIN
      

              WHEN "Q"

                 SET WS-QUITTER-O TO TRUE 

           END-EVALUATE

           DISPLAY "Quitter (O/n) ?"
           ACCEPT WS-QUITTER

       

       END-PERFORM.
       

       2000-CRUD-FIN.
       EXIT.

      *-----------------------------------------------------------------

       2050-SAISIE-INDIV-DEBUT.
       
       DISPLAY "Entrez le nom de l'individu : ".
       ACCEPT INDIVIDU-NOM.
       DISPLAY "Entrez le prénom de l'individu : ".
       ACCEPT INDIVIDU-PRENOM.
       DISPLAY "Entrez le numéro de l'individu : ".
       ACCEPT INDIVIDU-TEL.


       2050-SAISIE-INDIV-FIN.
       EXIT.

      *-----------------------------------------------------------------
       2060-DEMANDE-ID-DEBUT.
       
       DISPLAY "Entrez l'id de l'individu voulu : ".
       ACCEPT INDIVIDU-ID.

       2060-DEMANDE-ID-FIN.
       EXIT.
      *-----------------------------------------------------------------


       2100-CREER-INDIV-DEBUT.
       
       EXEC SQL
          INSERT INTO individus (nom, prenom, telephone)
          VALUES (:INDIVIDU-NOM, :INDIVIDU-PRENOM,
                 :INDIVIDU-TEL)
       END-EXEC.
              
       IF SQLCODE = 0
          DISPLAY "Insertion réussie."
       ELSE
          DISPLAY "Erreur d'insertion SQLCODE: " SQLCODE
          EXEC SQL 
           ROLLBACK 
          END-EXEC 
       END-IF.


       2100-CREER-INDIV-FIN.
       EXIT.
       
      *-----------------------------------------------------------------

       2200-LIRE-INDIV-DEBUT.
       
       EXEC SQL 
          SELECT nom, prenom, telephone 
          INTO :INDIVIDU-NOM, :INDIVIDU-PRENOM, :INDIVIDU-TEL 
          FROM individus
          WHERE id = :INDIVIDU-ID
       END-EXEC.
              
       IF SQLCODE = 0
          DISPLAY "Lecture effectuée."
          DISPLAY "Nom : " INDIVIDU-NOM
          SPACES WITH NO ADVANCING 
                  "Prénom : " INDIVIDU-PRENOM
          SPACES WITH NO ADVANCING
                  "Téléphone : " INDIVIDU-TEL
       
       ELSE
          DISPLAY "Erreur de lecture SQLCODE: " SQLCODE
          EXEC SQL 
           ROLLBACK 
          END-EXEC 
       END-IF.

       2200-LIRE-INDIV-FIN.
       EXIT.


      *-----------------------------------------------------------------
       2300-MODIFIER-INDIV-DEBUT.
       
       EXEC SQL 
          UPDATE individus
          SET nom = :INDIVIDU-NOM, 
          prenom = :INDIVIDU-PRENOM,
          telephone = :INDIVIDU-TEL
          WHERE id = :INDIVIDU-ID
       END-EXEC.

       IF SQLCODE = 0
          DISPLAY "Modification effectuée."
          DISPLAY "Nom : " INDIVIDU-NOM
          SPACES WITH NO ADVANCING 
                  "Prénom : " INDIVIDU-PRENOM
          SPACES WITH NO ADVANCING
                  "Téléphone : " INDIVIDU-TEL
       
       ELSE
          DISPLAY "Erreur de modification SQLCODE: " SQLCODE
          EXEC SQL 
           ROLLBACK 
          END-EXEC 
       END-IF.


       2300-MODIFIER-INDIV-FIN.
       EXIT.

      *-----------------------------------------------------------------
       2400-SUPPRIMER-INDIV-DEBUT.

       EXEC SQL
          DELETE FROM individus
          WHERE id = :INDIVIDU-ID  
       END-EXEC.

       IF SQLCODE = 0
          DISPLAY "Suppression effectuée."
       
       ELSE
          DISPLAY "Erreur de suppression SQLCODE: " SQLCODE
          EXEC SQL 
           ROLLBACK 
          END-EXEC 
       END-IF.


       2400-SUPPRIMER-INDIV-FIN.
       EXIT.
      *-----------------------------------------------------------------

