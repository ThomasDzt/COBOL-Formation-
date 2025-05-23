      *Exercice : Lecture du fichier train.dat et affichage 
       IDENTIFICATION DIVISION.
       PROGRAM-ID. train.
       AUTHOR. ThomasD & Benoit.


       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      
      *Création d'un alias pour le fichier "train.dat", lecture séquentielle.
       SELECT FICHIER-TRAIN ASSIGN TO "train.dat"
       ORGANIZATION IS LINE SEQUENTIAL.

       SELECT FICHIER-TRAIN2 ASSIGN TO 'train2.dat'
       ORGANIZATION IS LINE SEQUENTIAL.


      ****************************************************************** 
      *                        DATA DIVISION 
      ****************************************************************** 

       DATA DIVISION.

       FILE SECTION.
      *Description du fichier 

       FD FICHIER-TRAIN.
      *Copie du fichier .cpy dans notre File Description 
           COPY "train-record.cpy".

      *Création du fichier de sortie "train2.dat"
       FD FICHIER-TRAIN2.
           01 F-TRAIN2-LIGNE.
              03 F-TRAIN2-TYPE                         PIC X(22).
              
              03 F-ENTETE-STATION                      PIC X(16).
              03 F-TRAIN2-STATION-DEPART               PIC X(18).


              03 F-ENTETE-DEPART                       PIC X(14).
              03 F-TRAIN2-DEPART-HH                    PIC 9(02).
              03 F-FILL-01                             PIC X.
              03 F-TRAIN2-DEPART-MM                    PIC 9(02).
              03 F-FILL-02                             PIC X(03).


              03 F-ENTETE-DUREE                        PIC X(14).
              03 F-TRAIN2-DUREE                        PIC 9(02).


              03 F-ENTETE-ARRETS                       PIC X(10).
              03 F-TRAIN2-NOMBRE-ARRET                 PIC 9(02).


              03 F-ENTETE-ARRIVEE                      PIC X(17).
              03 F-TRAIN2-ARRIVEE-HH                   PIC 9(02).
              03 F-FILL-03                             PIC X.
              03 F-TRAIN2-ARRIVEE-MM                   PIC 9(02).
              03 F-FILL-04                             PIC X.


           01 F-TRAIN2-TOTAL                           PIC X(20).                         
       
       WORKING-STORAGE SECTION.
      *Création des variables dans lesquelles on va stocker les données de l'alias 
       01 WS-TRAIN-PLANNING. 
           02 LIGNE-TRAIN-PLANNING OCCURS 46 TIMES.
              03 WS-RECORD-TYPE                PIC XXX.
              88 WS-TGV                                    VALUE 'TGV'.
              88 WS-CORAIL                                 VALUE 'COR'.
              88 WS-TER                                    VALUE 'TER'.
              
              03 WS-STATION-DEPART             PIC X(18).
           
              03 WS-TRAIN-TIME.
                   05 WS-TRAIN-TIME-HH         PIC 99.
                   05 WS-TRAIN-TIME-MM         PIC 99.
           

               03 WS-TRAIN-ARRIVEE.
                   05 WS-TRAIN-ARRIVEE-HH      PIC 99.
                   05 WS-TRAIN-ARRIVEE-MM      PIC 99.

              03 WS-TRAIN-NBRE-HEURES          PIC 99.
              03 WS-CALCUL-TRAIN-ARRIVEE-HH    PIC 99.
              03 WS-RESTE-PAR-24               PIC 99.

              03 WS-TRAIN-HALT-FLAG            PIC X   OCCURS 10 TIMES.
              88 WS-TRAIN-STOPS-HERE                       VALUE 'H'.
              88 WS-TRAIN-SERVICE                          VALUE 'S'.
              88 WS-TRAIN-FRETE                            VALUE 'F'. 

              03 WS-NOMBRE-ARRET               PIC 9(2)    VALUE 0.
      
       

      *Création des index pour parcourir le tableau  
       77 WS-INDEX-TRAIN-PLANNING  PIC 9(2)    VALUE 1.
       77 WS-MAX-INDEX-PLANNING    PIC 9(2)    VALUE 46.

      *Création des index pour parcourir le groupe de variables correspondant au flag sur les arrêts 
       77 WS-INDEX-HALT-FLAG       PIC 9(2)    VALUE 1.

       77 WS-MAX-HALT-FLAG         PIC 9(2)    VALUE 10.
                  
       
      *Création de la variable de contrôle de fin de lecture du fichier 
       01 WS-FIN-LECTURE           PIC X       VALUE "N".



      ****************************************************************** 
      *                     PROCEDURE DIVISION 
      ****************************************************************** 

       PROCEDURE DIVISION.

       PERFORM 0100-LECTURE-DEBUT 
          THRU 0100-LECTURE-FIN.


       PERFORM 0200-AFFICHE-DEBUT 
          THRU 0200-AFFICHE-FIN.

       PERFORM 0300-COMPTE-ARRET-DEBUT
          THRU 0300-COMPTE-ARRET-FIN.

       PERFORM 0400-HEURE-ARRIVEE-DEBUT
          THRU 0400-HEURE-ARRIVEE-FIN.

       PERFORM 0500-AFFICHE2-DEBUT
          THRU 0500-AFFICHE2-FIN. 

       PERFORM 0600-ECRITURE-DEBUT
          THRU 0600-ECRITURE-FIN.

       STOP RUN. 


      ****************************************************************** 
      *                            PARAGRAPHES 
      ******************************************************************

       0100-LECTURE-DEBUT.

       DISPLAY "Ouverture du fichier".
       OPEN INPUT FICHIER-TRAIN.

       DISPLAY "Lecture du fichier".

      *Boucle de lecture du fichier : tant que la dernière ligne 
      *n'est pas atteinte  
       PERFORM UNTIL WS-FIN-LECTURE = "Y"
           READ FICHIER-TRAIN

      *A la fin de la lecture, on change la valeur de notre variable de contrôle 
               AT END
               MOVE "Y" TO WS-FIN-LECTURE

      *Tant qu'on lit le fichier, on ajoute les données de chaque ligne du fichier dans un tableau 
               NOT AT END
               IF WS-INDEX-TRAIN-PLANNING <= WS-MAX-INDEX-PLANNING
                   MOVE RECORD-TYPE 
                   TO   WS-RECORD-TYPE(WS-INDEX-TRAIN-PLANNING)

                   MOVE STATION-DEPART 
                   TO   WS-STATION-DEPART(WS-INDEX-TRAIN-PLANNING)
                    
                   MOVE TRAIN-TIME-HH 
                   TO   WS-TRAIN-TIME-HH(WS-INDEX-TRAIN-PLANNING)

                   MOVE TRAIN-TIME-MM 
                   TO   WS-TRAIN-TIME-MM(WS-INDEX-TRAIN-PLANNING)

                   MOVE TRAIN-NBRE-HEURES 
                   TO   WS-TRAIN-NBRE-HEURES(WS-INDEX-TRAIN-PLANNING)

      *Boucle pour ajouter la donnée du fichier à chaque occurence du flag 
                   PERFORM VARYING WS-INDEX-HALT-FLAG FROM 1 BY 1 
                           UNTIL WS-INDEX-HALT-FLAG > WS-MAX-HALT-FLAG

                    IF TRAIN-HALT-FLAG(WS-INDEX-HALT-FLAG) = "H"
                     MOVE TRAIN-HALT-FLAG(WS-INDEX-HALT-FLAG) 
                     TO   
                     WS-TRAIN-HALT-FLAG(WS-INDEX-TRAIN-PLANNING,
                     WS-INDEX-HALT-FLAG) 
                        
                    END-IF  
                   END-PERFORM
                   
      *Itération de l'index du tableau 
                   ADD 1 TO WS-INDEX-TRAIN-PLANNING
               END-IF  
           END-READ 
       END-PERFORM. 

       DISPLAY "Fermeture du fichier".
       CLOSE FICHIER-TRAIN.

      

       0100-LECTURE-FIN.
       EXIT.

      *-----------------------------------------------
       0200-AFFICHE-DEBUT.

      *Affichage du type de train, de la gare et l'heure de départ 
       DISPLAY "N° "
               "Typ " 
               "Gare depart      "
               "Heure depart"
       PERFORM VARYING WS-INDEX-TRAIN-PLANNING FROM 1 BY 1 
               UNTIL   WS-INDEX-TRAIN-PLANNING > WS-MAX-INDEX-PLANNING

               DISPLAY WS-INDEX-TRAIN-PLANNING
               SPACES WITH NO ADVANCING 
               DISPLAY WS-RECORD-TYPE(WS-INDEX-TRAIN-PLANNING) 
               SPACES WITH NO ADVANCING 
                       WS-STATION-DEPART(WS-INDEX-TRAIN-PLANNING) 
               SPACES WITH NO ADVANCING 
                       WS-TRAIN-TIME-HH(WS-INDEX-TRAIN-PLANNING) 
                       ":"
                       WS-TRAIN-TIME-MM(WS-INDEX-TRAIN-PLANNING) 

       END-PERFORM.

      
       DISPLAY "Fin de lecture".

       0200-AFFICHE-FIN .
       EXIT.

       
      *-----------------------------------------------

       0300-COMPTE-ARRET-DEBUT.
       
      *Boucle sur tout le tableau : décompte à chaque ligne du nombre d'arrêts 
       PERFORM VARYING WS-INDEX-TRAIN-PLANNING FROM 1 BY 1 
               UNTIL   WS-INDEX-TRAIN-PLANNING > WS-MAX-INDEX-PLANNING

           PERFORM VARYING WS-INDEX-HALT-FLAG FROM 1 BY 1 
                   UNTIL WS-INDEX-HALT-FLAG > WS-MAX-HALT-FLAG
       
               IF WS-TRAIN-HALT-FLAG(WS-INDEX-TRAIN-PLANNING,
                  WS-INDEX-HALT-FLAG) = "H"
                  ADD 1 TO WS-NOMBRE-ARRET(WS-INDEX-TRAIN-PLANNING) 
                            
               END-IF
                
           END-PERFORM
           DISPLAY "N° d'enregistrement : " WS-INDEX-TRAIN-PLANNING
           SPACES WITH NO ADVANCING 
           "Nombre d'arrets : " WS-NOMBRE-ARRET(WS-INDEX-TRAIN-PLANNING)
       END-PERFORM.


       0300-COMPTE-ARRET-FIN.
       EXIT.

      *-----------------------------------------------

      *Boucle pour calculer l'heure d'arrivée pour chaque train 
       0400-HEURE-ARRIVEE-DEBUT.
       PERFORM VARYING WS-INDEX-TRAIN-PLANNING FROM 1 BY 1 
               UNTIL   WS-INDEX-TRAIN-PLANNING > WS-MAX-INDEX-PLANNING

      *Addition de l'heure de départ et de la durée du trajet 
      *pour obtenir l'heure d'arrivée

           COMPUTE 
           WS-CALCUL-TRAIN-ARRIVEE-HH(WS-INDEX-TRAIN-PLANNING) = 
           WS-TRAIN-TIME-HH(WS-INDEX-TRAIN-PLANNING) + 
           WS-TRAIN-NBRE-HEURES(WS-INDEX-TRAIN-PLANNING)
           
      *Récupération du reste de la division du résultat obtenu par 24 
      *afin de prévoir le cas où le résultat est supérieur ou égal à 24

           COMPUTE WS-RESTE-PAR-24(WS-INDEX-TRAIN-PLANNING) = 
           FUNCTION MOD 
           (WS-CALCUL-TRAIN-ARRIVEE-HH(WS-INDEX-TRAIN-PLANNING) 24)

           IF WS-CALCUL-TRAIN-ARRIVEE-HH(WS-INDEX-TRAIN-PLANNING) >= 24
                
               MOVE WS-RESTE-PAR-24(WS-INDEX-TRAIN-PLANNING)
               TO   WS-TRAIN-ARRIVEE-HH(WS-INDEX-TRAIN-PLANNING)

           ELSE 
               MOVE WS-CALCUL-TRAIN-ARRIVEE-HH(WS-INDEX-TRAIN-PLANNING)
               TO   WS-TRAIN-ARRIVEE-HH(WS-INDEX-TRAIN-PLANNING) 

           END-IF 

      *Récupération des minutes pour l'heure d'arrivée 
           MOVE WS-TRAIN-TIME-MM(WS-INDEX-TRAIN-PLANNING) 
           TO   WS-TRAIN-ARRIVEE-MM(WS-INDEX-TRAIN-PLANNING)

      *Affichage des heures d'arrivée de chaque train 
           DISPLAY 
           "N° enregistrement : " 
           WS-INDEX-TRAIN-PLANNING

           SPACES WITH NO ADVANCING 

           " Heure d'arrivee : "
           WS-TRAIN-ARRIVEE-HH(WS-INDEX-TRAIN-PLANNING)
           ":"
           WS-TRAIN-ARRIVEE-MM(WS-INDEX-TRAIN-PLANNING)
       END-PERFORM.

       

       0400-HEURE-ARRIVEE-FIN.
       EXIT.

      *----------------------------------------------- 

      *Affichage de l'heure d'arrivée et du nombre d'arrêts pour le premier train 
       0500-AFFICHE2-DEBUT.
       MOVE 1 TO WS-INDEX-TRAIN-PLANNING.
       DISPLAY 
       "N° enregistrement : " 
       WS-INDEX-TRAIN-PLANNING
       
       
       " Heure d'arrivee : "
       WS-TRAIN-ARRIVEE-HH(WS-INDEX-TRAIN-PLANNING)
       ":"
       WS-TRAIN-ARRIVEE-MM(WS-INDEX-TRAIN-PLANNING)

       " Nombre d'arrets : "
       WS-NOMBRE-ARRET(WS-INDEX-TRAIN-PLANNING).
           




       0500-AFFICHE2-FIN.
       EXIT.

      *----------------------------------------------- 
       0600-ECRITURE-DEBUT.

      *Ouverture du fichier dans lequel on va écrire 
       OPEN OUTPUT FICHIER-TRAIN2.

       MOVE ":" TO F-FILL-01 F-FILL-03.
       MOVE "h" TO F-FILL-02 F-FILL-04. 
        

      *Ecriture du fichier "train2.dat" avec entêtes à chaque ligne
       PERFORM VARYING WS-INDEX-TRAIN-PLANNING FROM 1 BY 1
               UNTIL WS-INDEX-TRAIN-PLANNING > WS-MAX-INDEX-PLANNING

           EVALUATE TRUE

               WHEN WS-RECORD-TYPE(WS-INDEX-TRAIN-PLANNING) = "TGV"
                   MOVE "Train grande vitesse " TO F-TRAIN2-TYPE 

               WHEN WS-RECORD-TYPE(WS-INDEX-TRAIN-PLANNING) = "TER"           
                   MOVE "Train regional " TO F-TRAIN2-TYPE

                   
               WHEN OTHER
                   MOVE "Corail " TO F-TRAIN2-TYPE
               
           END-EVALUATE 

              
           MOVE "Station depart: " TO F-ENTETE-STATION

           MOVE WS-STATION-DEPART(WS-INDEX-TRAIN-PLANNING) 
           TO F-TRAIN2-STATION-DEPART

           MOVE "Heure depart: " TO F-ENTETE-DEPART

           MOVE WS-TRAIN-TIME-HH(WS-INDEX-TRAIN-PLANNING) 
           TO F-TRAIN2-DEPART-HH

           MOVE "Duree trajet: " TO F-ENTETE-DUREE

           MOVE WS-TRAIN-TIME-MM(WS-INDEX-TRAIN-PLANNING) 
           TO F-TRAIN2-DEPART-MM

           MOVE "  Arrets: " TO F-ENTETE-ARRETS

           MOVE WS-TRAIN-NBRE-HEURES(WS-INDEX-TRAIN-PLANNING) 
           TO F-TRAIN2-DUREE

           MOVE "  Heure arrivee: " TO F-ENTETE-ARRIVEE
           
           MOVE WS-NOMBRE-ARRET(WS-INDEX-TRAIN-PLANNING) 
           TO F-TRAIN2-NOMBRE-ARRET

           MOVE WS-TRAIN-ARRIVEE-HH(WS-INDEX-TRAIN-PLANNING) 
           TO F-TRAIN2-ARRIVEE-HH

           MOVE WS-TRAIN-ARRIVEE-MM(WS-INDEX-TRAIN-PLANNING) 
           TO F-TRAIN2-ARRIVEE-MM
       
       WRITE F-TRAIN2-LIGNE
       END-PERFORM.

      *Ajout de la ligne du total de trains
       MOVE "Total trains : 46" TO F-TRAIN2-TOTAL.
       WRITE F-TRAIN2-TOTAL.

      *Fermeture du fichier 
       CLOSE FICHIER-TRAIN2.


       0600-ECRITURE-FIN.
       EXIT.



