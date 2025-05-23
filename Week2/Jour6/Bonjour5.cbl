      *Exercice : Faire une boucle qui affiche bonjour 5 fois
       IDENTIFICATION DIVISION.
       PROGRAM-ID. Bonjour5.
       AUTHOR. ThomasD.


       ENVIRONMENT DIVISION.
       DATA DIVISION.
       

       PROCEDURE DIVISION. 
       
      *Boucle affichant "Bonjour" 5 fois.
       PERFORM 5 TIMES
      
      *Appel du paragraphe 0100-BONJOUR-START
      * jusqu'au paragraphe 0100-BONJOUR-END.
           PERFORM 0100-BONJOUR-START     
           THRU    0100-BONJOUR-END
      
       END-PERFORM.
      
       STOP RUN.

      ******************************************************************
      *Paragraphe affichant "Bonjour".
       0100-BONJOUR-START .
           DISPLAY "Bonjour".
       
      *Paragraphe indiquant la sortie de boucle.
       0100-BONJOUR-END .
           EXIT.

