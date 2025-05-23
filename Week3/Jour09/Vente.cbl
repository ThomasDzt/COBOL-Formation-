      *Exercice : Saisir les ventes hebdos pour 4 produits.
      * Afficher le nom, la quantité vendue, le prix unitaire et la valeur totale du stock
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Vente.
       AUTHOR. ThomasD.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS-TAB-VENTE.
           03 WS-PRODUIT OCCURS 4 TIMES.
               05 WS-NAME          PIC X(15).
               05 WS-PRIX          PIC 9(3).
               05 WS-QTE-VENDUE    
       
               
