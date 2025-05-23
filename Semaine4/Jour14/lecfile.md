# Lecture de fichiers 
On a un fichier .txt avec les noms de personnes

On utilise l'environment division
Dans l'INPUT-OUTPUT SECTION on travaille dans le FILE CONTROL où on crée un alias dans lequel on va travailler sur le fichier (?)
SELECT FICHIER-PERSONNES ASSIGN TO "gens.txt" (le nom réel du fichier) 
ORGANIZATION LINE IS SEQUENTIAL

Ensuite dans la DATA DIVISION on travaille dans la FILE SECTION 
FILE DESCRIPTION (FD) où on décrit le fichier alias
