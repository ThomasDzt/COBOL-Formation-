       IDENTIFICATION DIVISION.
       PROGRAM-ID. screen.
       AUTHOR. ThomasD.

       
       DATA DIVISION.
       WORKING-STORAGE SECTION.

       01 WS-ENTREE            PIC X.
       01 WS-DUMMY             PIC X.

       01 WS-IDENTIFIANT       PIC X(20).
       01 WS-MDP               PIC X(20).
       01 WS-COULEUR-TEXTE     PIC 9       VALUE 7.
       01 WS-COULEUR-FOND      PIC 9       VALUE 1.


        

       SCREEN SECTION.

       01 S-ECRAN-ACCUEIL 
           FOREGROUND-COLOR WS-COULEUR-TEXTE
           BACKGROUND-COLOR WS-COULEUR-FOND.

           05  BLANK SCREEN.
           COPY logo.
      *>     05  LINE 5 COL 30 VALUE "Simplon".
           05  LINE 30 COL 30 VALUE "Connexion".
           05  LINE 35 COL 27 VALUE "Appuyez sur Entree".

           05  LINE 30 COL 45  TO WS-ENTREE. 

       01 S-ECRAN-SAISIE
           FOREGROUND-COLOR WS-COULEUR-TEXTE
           BACKGROUND-COLOR WS-COULEUR-FOND.

           05  BLANK SCREEN.
           
           05  LINE 8 COL 10 VALUE "Identifiant :".
           05  LINE 8 COL 25 PIC X(20) TO WS-IDENTIFIANT.
           05  LINE 9 COL 10 VALUE "Mot de passe :".
           05  LINE 9 COL 25 PIC X(20) TO WS-MDP.
               
           

       01 S-ECRAN-SORTIE 
           FOREGROUND-COLOR WS-COULEUR-TEXTE
           BACKGROUND-COLOR WS-COULEUR-FOND.

           05  BLANK SCREEN.
           
           05  LINE 5 COL 30 VALUE "Connexion reussie".
           05  LINE 6 COL 28 VALUE "Bienvenue chez Simplon".
           05  LINE 10 COL 30 VALUE "Appuyez sur Entree".

           05  LINE 10 COL 48  TO WS-ENTREE.

       PROCEDURE DIVISION.

       DISPLAY S-ECRAN-ACCUEIL.
       DISPLAY SPACES AT LINE 10 
               WITH FOREGROUND-COLOR WS-COULEUR-TEXTE
               BACKGROUND-COLOR WS-COULEUR-FOND.
       ACCEPT S-ECRAN-ACCUEIL.

       DISPLAY S-ECRAN-SAISIE.
       ACCEPT S-ECRAN-SAISIE.

       DISPLAY S-ECRAN-SORTIE.
       ACCEPT S-ECRAN-SORTIE.

       ACCEPT WS-DUMMY 
              
              WITH FOREGROUND-COLOR WS-COULEUR-TEXTE
              BACKGROUND-COLOR WS-COULEUR-FOND.

       STOP RUN.

