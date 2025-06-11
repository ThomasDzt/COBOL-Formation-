       IDENTIFICATION DIVISION.
       PROGRAM-ID. greet.
       AUTHOR. ThomasD.

       DATA DIVISION.

       LINKAGE SECTION.
       01 LK-NOM     PIC X(20).
       01 LK-RESULT  PIC X(30).

       PROCEDURE DIVISION USING LK-NOM, LK-RESULT.
       
       STRING "Hello " FUNCTION TRIM(LK-NOM) " !" INTO LK-RESULT
       END-STRING.
       
       END PROGRAM greet.
