       IDENTIFICATION DIVISION.
       PROGRAM-ID. counchar.
       AUTHOR. ThomasD.

       DATA DIVISION.

       LINKAGE SECTION.
       01 LK-NOM     PIC X(20).
       01 LK-RESULT  PIC X(30).
       01 LK-COUNT   PIC 9(02).

       PROCEDURE DIVISION USING LK-NOM, LK-COUNT.

       MOVE FUNCTION LENGTH(FUNCTION TRIM(LK-NOM))
       TO LK-COUNT.

       END PROGRAM counchar.
       