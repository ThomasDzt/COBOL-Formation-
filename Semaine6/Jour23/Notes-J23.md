## Jour 23-Lundi 26 Mai 2025 

## Notes

### Mots-clés et recherche

**Qu'est-ce qu'un SGBD ?**
SGBD : *Système de Gestion de Base de Données*
Il s'agit d'un logiciel qui, comme son nom l'indique, permet de manipuler les bases de données, c'est-à-dire de les récupérer, les modifier, les supprimer, les créer, etc.

**Qu'est-ce qu'une base de données ?**
Il s'agit d'un ensemble d'informations définissant la structure des données. Elle pourra être utilisée pour accéder aux données et de pouvoir les gérer à l'aide d'un SGBD.

**Une base de donnée relationnelle ?**
Il s'agit d'un type de base de données composé d'un ensemble de tables (donc constitué de lignes de colonnes) qui permet de mettre les données en relation. En effet les données présentes sur une ligne sont liées à la colonne dans laquelle elles se trouvent. Ces colonnes sont appelées attributs et les lignes sont des enregistrements. Ces attributs sont regroupés par des clés --> permet d'identifier une ligne du tableau. Chaque clé a une valeur. 

**Une clé primaire ?**
Lorsqu'il y a plusieurs clés dans un tableau, une clé est choisie pour identifier les informations contenues dans le tableau de manière unique, elle est appelée clé primaire. Elle permet notamment d'associer des tableaux différents.

**Clé étrangère**
Lors de la mise en relation des informations de 2 tables, on peut utiliser la clé primaire d'une table dans une autre table. 

**Le SQL ?**
Pour *Structured Query Language*. Il s'agit d'un langage permettant d'interagir avec les bases de données relationnelles (créer une base de données, modifier les enregistrements d'une base de données,etc.)


**Le CRUD ?**
Pour Create (ajouter,insérer des données), Read (consulter, rechercher, extraire), Update(éditer), Delete (supprimer). Il s'agit des 4 opérations de base pour gérer des données.
 Utiliser partout (dans les API ?)

**Bases de données SQL**
SQLite, MySQL, Postgres, Oracle, Microsoft SQL Server, DB2 (sous licence)

Postgres avantage d'être proche de la machine

Base de données non-relationnelles, par exemple NoSQL (Not Only SQL). Différence 

**Exercice : donner un dictionnaire de données à partir d'un texte**
Lister toutes les infos qu'on mettra dans une table
Nom de commune      quartier       adresse      superficie      signataires    nom(alpha)     prenom   date de naissance (alphanum)  numéro de tél        type de logement        loyer      nombre d'habitants      distance 

● Une agence de location de maisons et d’appartements désire gérer sa liste de logements. Elle
voudrait en effet connaître l’implantation de chaque logement (nom de la commune et du
quartier) ainsi que les personnes qui les occupent (les signataires uniquement). Le loyer
dépend d’un logement, mais en fonction de son type (maison, studio, T1, T2...) l’agence
facturera toujours en plus du loyer la même somme forfaitaire à ses clients. Par exemple, le prix
d’un studio sera toujours égal au prix du loyer + 30 € de charges forfaitaires par mois. Pour
chaque logement, on veut disposer également de l’adresse, de la superficie ainsi que du loyer.
Quant aux individus qui occupent les logements (les signataires du contrat uniquement), on se
contentera de leurs noms, prénoms, date de naissance et numéro de téléphone. Pour chaque
commune, on désire connaître le nombre d’habitants ainsi que la distance séparant la
commune de l’agence.

groupements : 
1) Nom, Prenom, date naissance, numéro tel
2) type logement, loyer, quartier, superficie
3) nom commune, nbre habitants, distance agence


## SQLBolt

Penser aux tables comme étant un type d'une entité, et chaque ligne est une instance spécifique tandis que les colonnes regroupent les caractéristiques communes à toutes les instances.
Requête SQL qui peuvent servir à sélectionner plusieurs attributs (colonnes) --> ``SELECT`` column ``FROM`` table
On peut aussi filtrer les données à l'aide d'un ``WHERE`` conditionA ``AND/OR`` conditionB

**Opérateurs de conditions:**
- =, !=, <, <=, >, >=
- BETWEEN... AND...
- NOT BETWEEN... AND...
- IN(...)
- NOT IN (...)

Les requêtes issues de clauses sont exécutées plus rapidement.

Clause **WHERE** pour les comparaisons avec des chaînes de caractères sensibles à la casse 

- =  égalité avec la chaîne de caractères
- != ou <> inégalité avec la chaîne de caractères
- LIKE pour les égalités avec des string insensibles à la casse
- NOT LIKE pour les inégalités avec des string insensibles à la casse
- % pour sélectionner les chaînes avec 0 ou plus caractères de plus que la séquence indiquée  (LIKE "%AT%" par exemple va trouver les mots CAT, BATS)
- (_) pour sélectionner les chaînes contenant la séquence précisée mais pas que ça (?). (LIKE "_AN" par exemple va trouver les mots AND, mais pas AN)

Toutes les chaînes de caratères doivent être mises entre guillemets pour distinguer les mots de la chaine des mots-clés SQL.


Mot-clé **DISTINCT**
Pour retirer les lignes "doublons". De même, pour retirer les doublons, on pourra utiliser la clause **GROUP BY**
pour grouper les données par colonnes.

Mots-clés pour le tri les résultats d'une requête SQL : **ORDER BY** et **ASC/DESC**. On utilise parfois avec ceci les clauses **LIMIT** (réduit le nombre de lignes à renvoyer par la requête) et **OFFSET** (pour préciser d'où on commence à compter les lignes).
Inclure ces clauses rend aussi ces requêtes plus rapides et efficaces en affichant juste le contenu voulu.

Utilisation du mot-clé **JOIN** 
Normalisation des bases de données pour répartir les données dans plusieurs tables. Besoin d'une clé primaire "primary key" qui identifie les entités de manière unique dans les bases de données. La clause **JOIN** permet de lier les enregistrements de 2 tables séparées.
Plusieurs types de JOIN :

**INNER JOIN** 
