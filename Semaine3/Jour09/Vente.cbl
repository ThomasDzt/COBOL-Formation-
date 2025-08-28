      * Saisir les ventes hebdomadaires de 4 produits. Chaque produit a  
      * un nom et un prix unitaire. Afficher, pour chaque produit, le 
      * nom, la quantité vendue, et le prix unitaire. Afficher la valeur 
      * total du stock.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. Vente.
       AUTHOR. ThomasD.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS-TAB-VENTE.
           03 WS-PRODUIT OCCURS 4 TIMES.
               05 WS-NOM                PIC X(10).
               05 WS-PRIX-UNIT          PIC 9(04)V9(02).
               05 WS-PRIX-UNIT-EDIT     PIC Z(04).9(02).

               05 WS-QTE-VENDUE         PIC 9(02).   
               05 WS-PRIX-VENTE         PIC 9(03)V9(02).


       01 WS-STOCK-TOTAL                PIC 9(03)V9(02).
       01 WS-ESPACE                     PIC X(05).
       77 WS-IDX                        PIC 9.

       PROCEDURE DIVISION.

           PERFORM 0100-INFOS-PRODUIT-DEB
              THRU 0100-INFOS-PRODUIT-FIN.

           PERFORM 0200-SAISIE-QTE-VENDUE-DEB
              THRU 0200-SAISIE-QTE-VENDUE-FIN.

           PERFORM 0300-AFFICHE-PRODUIT-DEB
              THRU 0300-AFFICHE-PRODUIT-FIN.

           PERFORM 0400-CALCUL-STOCK-DEB
              THRU 0400-CALCUL-STOCK-FIN.

           PERFORM 0500-AFFICHE-STOCK-DEB
              THRU 0500-AFFICHE-STOCK-FIN.           
       

           STOP RUN.   

      ******************************************************************
      *                          PARAGRAPHES                           *
      ******************************************************************

       0100-INFOS-PRODUIT-DEB.

           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 4
               
               DISPLAY "Entrez un nom d'article : "
               WITH NO ADVANCING 
               ACCEPT WS-NOM(WS-IDX)

               DISPLAY "Entrez le prix de l'article : " 
               WITH NO ADVANCING 
               ACCEPT WS-PRIX-UNIT(WS-IDX)
               
           END-PERFORM.
           EXIT.

       0100-INFOS-PRODUIT-FIN.

      *-----------------------------------------------------------------

       0200-SAISIE-QTE-VENDUE-DEB.
           
           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 4

               DISPLAY "Saisissez la quantité à acheter pour "
               WITH NO ADVANCING WS-NOM(WS-IDX) " : "
               WITH NO ADVANCING
               ACCEPT WS-QTE-VENDUE(WS-IDX)

           END-PERFORM.
           EXIT.

       0200-SAISIE-QTE-VENDUE-FIN.

      *-----------------------------------------------------------------

       0300-AFFICHE-PRODUIT-DEB.


           DISPLAY "Nom du produit "
           WITH NO ADVANCING WS-ESPACE
           WITH NO ADVANCING "Prix unit. "
           WITH NO ADVANCING WS-ESPACE
           WITH NO ADVANCING "Qte vendue ".
           
           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 4
               
               MOVE WS-PRIX-UNIT(WS-IDX) TO WS-PRIX-UNIT-EDIT(WS-IDX)

               DISPLAY FUNCTION TRIM(WS-NOM(WS-IDX)) 
               WITH NO ADVANCING WS-ESPACE
               WITH NO ADVANCING WS-PRIX-UNIT-EDIT(WS-IDX)
               WITH NO ADVANCING WS-ESPACE
               WITH NO ADVANCING WS-QTE-VENDUE(WS-IDX)
               
           END-PERFORM.
           EXIT.

       0300-AFFICHE-PRODUIT-FIN.

      *-----------------------------------------------------------------

       0400-CALCUL-STOCK-DEB.
           
           INITIALIZE WS-STOCK-TOTAL.

           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 4
               
               MULTIPLY WS-PRIX-UNIT(WS-IDX) BY WS-QTE-VENDUE(WS-IDX)
               GIVING WS-PRIX-VENTE(WS-IDX)
               
               ADD WS-PRIX-VENTE(WS-IDX) TO WS-STOCK-TOTAL

           END-PERFORM.

           EXIT.

       0400-CALCUL-STOCK-FIN.

      *-----------------------------------------------------------------

       0500-AFFICHE-STOCK-DEB.

           DISPLAY "Valeur du stock total : "
           WITH NO ADVANCING WS-STOCK-TOTAL.

           EXIT.

       0500-AFFICHE-STOCK-FIN.

      *-----------------------------------------------------------------
