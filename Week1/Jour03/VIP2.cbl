      *Exercice : à quelle classe appartient le client ?
       IDENTIFICATION DIVISION.
       PROGRAM-ID. VIP2.
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


       IF WS-CLIENT NOT = WS-CLIVIP AND WS-CLISTD
           DISPLAY "Cette catégorie est inexistante."
           STOP RUN
       END-IF.
      *Saisie du solde du client
       DISPLAY "Quel est votre solde ?".
       ACCEPT WS-SOLDE.



       IF WS-CLIENT = WS-CLIVIP
           
           IF WS-SOLDE > 10000
               DISPLAY "Client premium"
                
           ELSE     
               DISPLAY "Client privilégié"
                   
           END-IF      
               
       
       ELSE IF WS-CLIENT = WS-CLISTD

           IF WS-SOLDE > 5000

               DISPLAY "Client fidèle"

           ELSE         
               DISPLAY "Client standard"   
                    
                   
           END-IF 
       

       
       END-IF.

       STOP RUN.
