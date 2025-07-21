# Brief Gestion de la biblio

## Description de l'exo

Programme lit la liste de données (livres) et renvoie les infos en base de données 

systeme d'emprunt

comment créer ma base de données ? 
créer une clé secondaire (comment ça marche ? Regarder sur SQLBolt)

Objectifs
Lire son fichier (pouvoir savoir qui a emprunté quoi)
donc créer une table annexe pour les emprunts 
Ecrire un .dat et créer base de données

On utilise un menu principal pour sélectionner la table qui nous intéresse
On utilise le CRUD pour chaque table

# Processus :

Créations de tables

 **table 1 : Author**

 id 
 Nom --> PIC X(22)
 Prénom --> PIC X(22)
 


 **table 2 : Livres**

 id
 ISBN --> PIC X(13)
 Titre  --> PIC X (38)
 date de parution --> PIC 9(4)
 id_auteur 
 genre  --> PIC X(16)
 


 **Table 3 : personnes**
 id
 nom
 prénom

**Table 4 : emprunt**

id
personne
livre
date debut
date fin

**Table 5 : Types**

id
personne
livre
date debut
date fin

**Table 6 : Editeur**
id
name editor --> PIC X(23)


Lecture du fichier en input 
on lit une ligne on a l'auteur
On vérifie si l'auteur existe dans la base de données sinon SQL create author
On SELECT l'id de l'aut
Create Book par rapport à l'id Auteur




Analyse books-input.dat :