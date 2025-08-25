      * Crée un programme qui demande à l'utilisateur d'entrer une série 
      * de nombres. La boucle continue jusqu'à ce que l'utilisateur 
      * entre 0. Le programme doit afficher le plus grand nombre parmi  
      * les entrées. 

       IDENTIFICATION DIVISION.
       PROGRAM-ID. maxunt0.
       AUTHOR. Thomas.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
      * Nombre saisi par l'utilisateur.
       01 WS-SSI-UTI   PIC X(10).
       
      * Nombre après contrôle de saisie. 
       01 WS-NBR       PIC 9(03)   VALUE 1.

      * Nombre maximum entré par l'utilisateur. 
       01 WS-MAX       PIC 9(03).

      * Nombre maximum édité pour affichage. 
       01 WS-MAX-EDI   PIC Z(03).
       

       PROCEDURE DIVISION.

           PERFORM 0100-BOUCLE-MAX-DEB
              THRU 0100-BOUCLE-MAX-FIN.
           
           PERFORM 0200-AFFICHE-MAX-DEB
              THRU 0200-AFFICHE-MAX-FIN.

           STOP RUN.

      ******************************************************************
      *                         PARAGRAPHES                            *
      ******************************************************************

      * Boucle jusqu'à ce que l'utilisateur entre 0.  
       0100-BOUCLE-MAX-DEB.

      * Initialisation du max à 0.     
           INITIALIZE WS-MAX. 

      * Boucle tant que le nombre entré n'est pas 0.
           PERFORM UNTIL WS-NBR = 0
       
               PERFORM 0150-SAISIE-NOMBRE-DEB
                  THRU 0150-SAISIE-NOMBRE-FIN

               PERFORM 0160-CONTROLE-SAISIE-DEB
                  THRU 0160-CONTROLE-SAISIE-FIN

               PERFORM 0170-ALIMENTATION-MAX-DEB
                  THRU 0170-ALIMENTATION-MAX-FIN

           END-PERFORM.

           EXIT.

       0100-BOUCLE-MAX-FIN.

      *-----------------------------------------------------------------
       
       0150-SAISIE-NOMBRE-DEB.

      * Saisie du nombre par l'utilisateur. 
           DISPLAY "Entrez un nombre (de longueur max 3) :".
           ACCEPT WS-SSI-UTI.

           EXIT.
       
       0150-SAISIE-NOMBRE-FIN.

      *-----------------------------------------------------------------

       0160-CONTROLE-SAISIE-DEB.
       
      * Contrôle de saisie sur le nombre entré : les valeurs saisies
      * doivent être numérique et de longueur inférieure ou égale à 3. 

           IF FUNCTION TRIM(WS-SSI-UTI) IS NUMERIC  
           AND FUNCTION LENGTH(FUNCTION TRIM(WS-SSI-UTI)) <= 3 

      * Affectation de la valeur contrôlée à une variable numérique.
               MOVE FUNCTION TRIM(WS-SSI-UTI) TO WS-NBR
               
      * Si la valeur saisie ne correspond pas aux conditions, un 
      * message d'erreur est affiché.

           ELSE 
               
               DISPLAY "Erreur, veuillez saisir un nombre de"
                       " longueur maximale 3"
           END-IF.

           EXIT.
           
       0160-CONTROLE-SAISIE-FIN.

      *-----------------------------------------------------------------

       0170-ALIMENTATION-MAX-DEB.

      * Alimentation de la variable correspondant au nombre maximal 
      * entré.
              
           IF WS-NBR > WS-MAX 
               MOVE WS-NBR TO WS-MAX
           END-IF. 

           EXIT.
       0170-ALIMENTATION-MAX-FIN.

      *-----------------------------------------------------------------
       0200-AFFICHE-MAX-DEB.

      * Edition et affichage du plus grand nombre saisi par
      * l'utilisateur.

           MOVE WS-MAX TO WS-MAX-EDI.
           DISPLAY "Plus grand nombre entré : " 
                   FUNCTION TRIM (WS-MAX-EDI).
           
           EXIT.

       0200-AFFICHE-MAX-FIN.

      *-----------------------------------------------------------------
      