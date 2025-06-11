# Jour 32 - Mardi 10 Juin 2025 
## Point sur l'utilisation des sous-programmes

Exemple du "Hello Simplon".

Au lieu de faire comme on le fait d'habitude avec des strings en working-storage section, on pourrait créer un sous-programme  dans lequel on déclare nos variables en `LINKAGE SECTION`.

(LK-NOM, LK-REPONSE) en LINKAGE.
Dans le sous-programme :
PROCEDURE DIVISION USING LK-NOM, LK-REPONSE 
Les sous-programmes doivent être réutilisables dans d'autres programmes donc il vaudrait mieux éviter d'affecter des valeurs aux variables dans le sous-programme.

Ensuite dans le programme appelant :

CALL "nom du sous-programme" USING WS-NOM, WS-RESPONSE.

cobc -x - o run [nom du programme].cbl [nom du sous-programme].cbl 
o pour output , run pour rename en run

Différence entre END PROGRAM et EXIT PROGRAM (ce que j'ai compris) :

END PROGRAM : balise, sert à indiquer la fin de programme, passif et n'a aucun effet lors de l'exécution du programme.

EXIT PROGRAM : sert à quitter le sous-programme dans lequel on se trouve pour retourner au programme appelant, actif
