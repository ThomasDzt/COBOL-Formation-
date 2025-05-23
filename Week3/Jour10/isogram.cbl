      *Exercice : Créer un programme qui demande à l'utilisateur d'entrer un mot et de vérifier si celui-ci
      *un isogramme (mot dont les lettres n'apparaissent qu'une fois) 

       IDENTIFICATION DIVISION.
       PROGRAM-ID. isogram.
       AUTHOR.ThomasD.
       
       
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       
      *Variable correspondant au mot saisi par l'uti 
       01  WS-MOT-SAISI PIC X(10).

       01  WS-TABLEAU-LETTRE. 
           05 WS-LETTRE        PIC X OCCURS 10 TIMES.

       01  WS-LONGUEUR-MOT     PIC 9(2).
       01  WS-INDEX-LETTRE     PIC 9.
       01  WS-INDEX-LETTRE2    PIC 9.

       01  WS-ISOGRAM          PIC X    VALUE "Y".
           88  WS-ISOGRAM-Y             VALUE "Y".
           88  WS-ISOGRAM-N             VALUE "N".
       
       
       PROCEDURE DIVISION.

      *Demande de saisie du mot à l'utilisateur

       DISPLAY "Saisir un mot :".
       ACCEPT  WS-MOT-SAISI.
       MOVE FUNCTION UPPER-CASE(WS-MOT-SAISI) TO WS-MOT-SAISI.


      *On évalue la longueur de la chaîne de caractères 
       MOVE FUNCTION LENGTH (FUNCTION TRIM(WS-MOT-SAISI))
       TO WS-LONGUEUR-MOT.
      * DISPLAY "Le mot contient " WS-LONGUEUR-MOT " lettres.".
       
      *On effectue une boucle pour parcourir le tableau et on
      *ajoute les lettres du mot à chaque itération

       PERFORM VARYING WS-INDEX-LETTRE 
        FROM 1 BY 1 
        UNTIL WS-INDEX-LETTRE > WS-LONGUEUR-MOT
        OR WS-ISOGRAM = "N"

           MOVE WS-MOT-SAISI(WS-INDEX-LETTRE:1) 
           TO   WS-LETTRE(WS-INDEX-LETTRE) 
           
      *On compare la lettre ajoutée aux autres 
           PERFORM VARYING WS-INDEX-LETTRE2 
            FROM 1 BY 1 
            UNTIL WS-INDEX-LETTRE2 > WS-LONGUEUR-MOT 
            OR WS-ISOGRAM = "N"
           
            IF WS-LETTRE(WS-INDEX-LETTRE) = WS-LETTRE(WS-INDEX-LETTRE2)
             AND WS-INDEX-LETTRE NOT = WS-INDEX-LETTRE2 
             AND WS-LETTRE(WS-INDEX-LETTRE) NOT = SPACE 
               MOVE "N" TO WS-ISOGRAM
      *         DISPLAY WS-ISOGRAM 
            END-IF
             
           END-PERFORM 
               
       END-PERFORM.

       DISPLAY WS-MOT-SAISI.

      *On teste si le booléen  
       IF WS-ISOGRAM = "N"

           DISPLAY "Le mot saisi n'est pas un isogramme"

       ELSE

           DISPLAY "Le mot saisi est un isogramme"  

       END-IF.
               
       STOP RUN.
