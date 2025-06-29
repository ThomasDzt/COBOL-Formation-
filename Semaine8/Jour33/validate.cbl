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
       


       PERFORM 0100-VALID-EMAIL-DEBUT
          THRU 0100-VALID-EMAIL-FIN.
       
       
       
      ****************************************************************** 
      *                          PARAGRAPHES                           *
      ******************************************************************
      
      
       0100-VALID-EMAIL-DEBUT.   
       
       MOVE 0 TO LK-COMPTEUR.

       INSPECT LK-EMAIL-UTILISATEUR
       TALLYING LK-COMPTEUR FOR ALL "@".


       IF LK-COMPTEUR NOT = 1 OR LK-ID-UTILISATEUR NOT NUMERIC
           
           MOVE 1 TO RETURN-CODE
               
       ELSE  
           IF LK-COMPTEUR = 1
               MOVE 0 TO RETURN-CODE
           END-IF 
       END-IF.
       

       0100-VALID-EMAIL-FIN.
       EXIT.

      *-----------------------------------------------------------------

       END PROGRAM validate.

     




       