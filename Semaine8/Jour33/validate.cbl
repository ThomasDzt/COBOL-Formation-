       IDENTIFICATION DIVISION.
       PROGRAM-ID. validate.
       AUTHOR. ThomasD.

       DATA DIVISION.
       
       LINKAGE SECTION.
       
       01 LK-ID-UTILISATEUR          PIC X(10).
       01 LK-EMAIL-UTILISATEUR       PIC X(30).
       01 LK-COMPTEUR    PIC 9.


       PROCEDURE DIVISION USING LK-ID-UTILISATEUR,
                                LK-EMAIL-UTILISATEUR, 
                                LK-COMPTEUR.
       

       PERFORM 0100-VALID-ID-DEBUT
          THRU 0100-VALID-ID-FIN.

       PERFORM 0200-VALID-EMAIL-DEBUT
          THRU 0200-VALID-EMAIL-FIN.
       
       
       
      ****************************************************************** 
      *                          PARAGRAPHES                           *
      ******************************************************************
       0100-VALID-ID-DEBUT.

       IF LK-ID-UTILISATEUR IS NOT NUMERIC
           DISPLAY "L'ID de l'utilisateur est invalide"
       END-IF. 


       0100-VALID-ID-FIN.
       EXIT.
      
      *-----------------------------------------------------------------
      
       0200-VALID-EMAIL-DEBUT.   
       
       MOVE 0 TO LK-COMPTEUR.

       INSPECT LK-EMAIL-UTILISATEUR
       TALLYING LK-COMPTEUR FOR ALL "@".

       DISPLAY "COMPTEUR : " LK-COMPTEUR.

       IF LK-COMPTEUR = 1
           
           MOVE 0 TO RETURN-CODE

       ELSE 
           MOVE 1 TO RETURN-CODE
       END-IF.
       

       0200-VALID-EMAIL-FIN.
       EXIT.

      *-----------------------------------------------------------------

       END PROGRAM validate.

     




       