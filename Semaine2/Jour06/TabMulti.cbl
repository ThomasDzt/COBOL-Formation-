      * Programme qui demande à l'utilisateur un nombre et affiche sa 
      * table de multiplication (de 1 à 10).
       
       IDENTIFICATION DIVISION.
       PROGRAM-ID. TabMulti.
       Author. ThomasD.

       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS-NBR            PIC 9(02).
       01 WS-PRD            PIC 9(04).
       01 WS-IDX            PIC 9(02).


       01 WS-NBR-EDI       PIC Z(02).
       01 WS-PRD-EDI       PIC Z(04).
       01 WS-IDX-EDI       PIC Z(02).

       PROCEDURE DIVISION.
           
           PERFORM 0100-SAISIE-NOMBRE-DEB
              THRU 0100-SAISIE-NOMBRE-FIN.
    
           PERFORM 0200-TABLE-MULTI-DEB
              THRU 0200-TABLE-MULTI-FIN.

           STOP RUN.

      ******************************************************************
      *                         PARAGRAPHES                            *
      ******************************************************************
       
       0100-SAISIE-NOMBRE-DEB.

           DISPLAY "Entrez un nombre : ".
           ACCEPT WS-NBR.
           MOVE WS-NBR TO WS-NBR-EDI.
           
           DISPLAY "Table de " FUNCTION TRIM (WS-NBR-EDI) " : ".
           EXIT.
       
       0100-SAISIE-NOMBRE-FIN.

      *----------------------------------------------------------------- 

       0200-TABLE-MULTI-DEB.

           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 10

               PERFORM 0300-OPERATION-DEB
                  THRU 0300-OPERATION-FIN

               PERFORM 0400-EDI-VAR-DEB
                  THRU 0400-EDI-VAR-FIN

               DISPLAY FUNCTION TRIM (WS-NBR-EDI) " * " 
                       FUNCTION TRIM (WS-IDX-EDI) " = " 
                       FUNCTION TRIM (WS-PRD-EDI)

           END-PERFORM.

           EXIT.

       0200-TABLE-MULTI-FIN.
       
      *----------------------------------------------------------------- 
       
       0300-OPERATION-DEB.

           COMPUTE WS-PRD = WS-NBR * WS-IDX.
           EXIT.
       
       0300-OPERATION-FIN.

      *----------------------------------------------------------------- 
       
       0400-EDI-VAR-DEB.

           MOVE WS-IDX TO WS-IDX-EDI.
           MOVE WS-PRD TO WS-PRD-EDI.

           EXIT.

       0400-EDI-VAR-FIN. 
      *----------------------------------------------------------------- 



