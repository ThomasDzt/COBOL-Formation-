       IDENTIFICATION DIVISION.
       PROGRAM-ID. validate.
       AUTHOR. ThomasD.

       DATA DIVISION.
       
       LINKAGE SECTION.
       
       01 LK-EMAIL-UTILISATEUR       PIC X(30).
       01 LK-COMPTEUR    PIC 9.

       PROCEDURE DIVISION USING LK-EMAIL-UTILISATEUR, 
                                LK-COMPTEUR.
       
       INSPECT LK-EMAIL-UTILISATEUR
       TALLYING LK-COMPTEUR FOR ALL "@".

       DISPLAY LK-COMPTEUR.
       
       IF LK-COMPTEUR = 1
           
           MOVE 0 TO RETURN-CODE

       ELSE 
           MOVE 1 TO RETURN-CODE
       END-IF.
       
       MOVE 0 TO LK-COMPTEUR.
       END PROGRAM validate.





       