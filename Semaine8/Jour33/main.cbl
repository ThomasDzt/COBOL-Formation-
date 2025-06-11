       IDENTIFICATION DIVISION.
       PROGRAM-ID. Main.
       AUTHOR. ThomasD.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

      *Création de l'alias pour le fichier d'entrée, les enregistrements sont lus de manière séquentielle
       SELECT FICHIER-ENTREE ASSIGN TO "users.dat"
       ORGANIZATION IS LINE SEQUENTIAL
       FILE STATUS IS F-STATUT-ENTREE.

       SELECT FICHIER-SORTIE ASSIGN TO "errors.log"
       ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       
      *Description du fichier d'entrée, les enregistrements contiennent 1 à 100 caractères
       FILE SECTION.
       FD FICHIER-ENTREE
           RECORD CONTAINS 2 TO 100 CHARACTERS 
           RECORDING MODE IS V.
           
       01  F-ENTREE-100    PIC X(100).
       

       FD FICHIER-SORTIE
           RECORD CONTAINS 60 CHARACTERS
           RECORDING MODE IS F.

       01 F-SORTIE          PIC X(60).


       WORKING-STORAGE SECTION.
       
      *Copie des variables de uservar.cpy 
       COPY uservar.
       
       01  WS-INDEX    PIC 9(02)    VALUE 1.
       01  WS-MAX      PIC 9(02)    VALUE 12.


       01 WS-COMPTEUR    PIC 9.
       
      *Définition de la variable de contrôle de statut du fichier 
      *Utile pour définir la fin de boucle de lecture du fichier
       01  F-STATUT-ENTREE      PIC X(02) VALUE SPACE.
           88 F-STATUT-ENTREE-OK    VALUE '00'.        
           88 F-STATUT-ENTREE-FF    VALUE '10'.

       
       PROCEDURE DIVISION.
       
       PERFORM 0100-LECTURE-DEBUT
          THRU 0100-LECTURE-FIN.
       
       PERFORM 0200-AFFICHAGE-DEBUT
          THRU 0200-AFFICHAGE-FIN.

       PERFORM 0300-VALIDATION-DEBUT
          THRU 0300-VALIDATION-FIN.
       
       PERFORM 0400-ECRITURE-DEBUT
          THRU 0400-ECRITURE-FIN.

       STOP RUN.

      ****************************************************************** 
      *                          PARAGRAPHES                           *
      ****************************************************************** 
      
       0100-LECTURE-DEBUT.
       
       DISPLAY "Ouverture du fichier : "
       OPEN INPUT FICHIER-ENTREE.

       PERFORM UNTIL F-STATUT-ENTREE-FF
         READ FICHIER-ENTREE
           AT END 
             DISPLAY "Fin de fichier atteinte"
             DISPLAY "Statut : " F-STATUT-ENTREE 
             DISPLAY "Lecture du fichier"
               
           NOT AT END
             PERFORM 0150-TRAITEMENT-LECT-DEBUT  
                THRU 0150-TRAITEMENT-LECT-FIN

         END-READ 
       END-PERFORM.
       
       DISPLAY "Fin de lecture du fichier".
       CLOSE FICHIER-ENTREE.
       DISPLAY "Fermeture du fichier".


       0100-LECTURE-FIN.
       EXIT.
      *-----------------------------------------------------------------
       0150-TRAITEMENT-LECT-DEBUT.
       
       IF  WS-INDEX <= WS-MAX
           MOVE F-ENTREE-100(1:10) 
           TO   WS-ID-UTILISATEUR(WS-INDEX)
           
           MOVE F-ENTREE-100(11:50) 
           TO   WS-NOM-UTILISATEUR(WS-INDEX)
           
           MOVE F-ENTREE-100(61:30) 
           TO   WS-EMAIL-UTILISATEUR(WS-INDEX)

           ADD 1 TO WS-INDEX

       END-IF.
       
       0150-TRAITEMENT-LECT-FIN.
       EXIT.
      *-----------------------------------------------------------------
       0200-AFFICHAGE-DEBUT.
       PERFORM VARYING WS-INDEX FROM 1 BY 1 
               UNTIL WS-INDEX > WS-MAX
       
           DISPLAY WS-ID-UTILISATEUR(WS-INDEX)
           SPACES WITH NO ADVANCING 
       
           DISPLAY WS-NOM-UTILISATEUR(WS-INDEX)
           SPACES WITH NO ADVANCING 
       
           DISPLAY WS-EMAIL-UTILISATEUR(WS-INDEX)
       
       END-PERFORM.
       
       0200-AFFICHAGE-FIN.
       EXIT.
      *-----------------------------------------------------------------
       0300-VALIDATION-DEBUT.
       
       PERFORM VARYING WS-INDEX FROM 1 BY 1 
               UNTIL WS-INDEX > WS-MAX

           CALL "validate" USING WS-ID-UTILISATEUR(WS-INDEX),
                                 WS-EMAIL-UTILISATEUR(WS-INDEX), 
                                 WS-COMPTEUR
           END-CALL

           DISPLAY "RETURN-CODE : " RETURN-CODE
           MOVE RETURN-CODE TO WS-RETURN-CODE(WS-INDEX)
            
       
       END-PERFORM.


       0300-VALIDATION-FIN.
       EXIT.
      *-----------------------------------------------------------------
       0400-ECRITURE-DEBUT.

       OPEN OUTPUT FICHIER-SORTIE.
       
       PERFORM VARYING WS-INDEX FROM 1 BY 1 
               UNTIL WS-INDEX > WS-MAX

           IF WS-RETURN-CODE(WS-INDEX) = 1
                STRING "[Ligne " WS-INDEX "] " 
                       "Erreur : " 
                       "Email invalide " 
                       WS-EMAIL-UTILISATEUR(WS-INDEX) 

                INTO F-SORTIE
                END-STRING 
                WRITE F-SORTIE 
           END-IF

       END-PERFORM.

       CLOSE FICHIER-SORTIE.
       
       0400-ECRITURE-FIN.
       EXIT.

