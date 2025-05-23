      *Exercice : à quelle classe appartient le client ?
       IDENTIFICATION DIVISION.
       PROGRAM-ID. VIP.
       AUTHOR. ThomasD.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      *Déclaration des variables alphabétiques
       01  WS-CLIENT    PIC X(10).
       01  WS-CLIVIP    PIC X(10)    VALUE "VIP".
       01  WS-CLISTD    PIC X(10)    VALUE "Standard".
      *Déclaration de la variable numérique
       01  WS-SOLDE     PIC 9(10).

       
       PROCEDURE DIVISION.
       
      *Saisie du type de client
       DISPLAY "Quel type de client êtes-vous ?".
       ACCEPT WS-CLIENT.

      *Saisie du solde du client
       DISPLAY "Quel est votre solde ?".
       ACCEPT WS-SOLDE.


       EVALUATE WS-CLIENT
           
           WHEN = WS-CLIVIP
           
               EVALUATE WS-SOLDE
                   WHEN > 10000
                   DISPLAY "Client premium"
                   WHEN OTHER 
                   DISPLAY "Client privilégié"
               END-EVALUATE

           WHEN = WS-CLISTD

               EVALUATE WS-SOLDE
                   WHEN > 5000
                   DISPLAY "Client fidèle"
                   WHEN OTHER 
                   DISPLAY "Client standard"
               END-EVALUATE

           WHEN OTHER 
           DISPLAY "Erreur"
       END-EVALUATE.

       STOP RUN.
