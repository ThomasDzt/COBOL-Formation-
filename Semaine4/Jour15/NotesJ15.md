
En COBOL on peut générer des fichiers --> besoin d'alias pour l'output aussi (INPUT-OUTPUT SECTION)
SELECT *alias* ASSINGN TO "fichier qu'on va créer.txt" (ça pourrait être une autre extension car on cherche à imprimer qqch)
ORGANIZATION IS LINE SEQUENTIAL

Ensuite on décrit le fichier qui va être créé en FD (comme pour l'input)

On passe ensuite à la suite du programme (après la lecture du fichier) et on ouvre le fichier qui va être créé :

OPEN OUTPUT *alias du fichier qui va être créé*

On créé une boucle pour parcourir le fichier et MOVE les variables NOM PRENOM par exemple aux lignes NOM PRENOM de notre fichier créé.
Ensuite on WRITE le nouveau groupe de variables.
Fin de boucle.
Fermeture du fichier
Fin de programme
