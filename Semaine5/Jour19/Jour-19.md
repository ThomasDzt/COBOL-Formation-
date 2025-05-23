# Objectifs journaliers MS COBOL P4




### Mardi 21  Mai

---

## Définitions clés


 `SUBSCRIPT`     Indice permettant de cibler un élément du tableau.                             
 `STRING`        Permet de concaténer plusieurs champs dans une même ligne de texte.            


## Définitions clés

* **Tableau (`OCCURS`)** : Structure de données permettant de stocker plusieurs valeurs dans un bloc mémoire unique. Utilisé pour créer des collections d'éléments similaires.

* **Index (`SUBSCRIPT`)** : Position d'un élément dans un tableau. C'est souvent une variable entière qui permet de localiser chaque élément du tableau (par exemple, `IDX-1`, `IDX-2`).

* **Tableau multidimensionnel** : Un tableau qui contient des sous-tableaux. Par exemple, un tableau 2D, tel qu'une grille de 5 lignes et 3 colonnes.

* **`PERFORM VARYING`** : Instruction COBOL permettant de parcourir un tableau en utilisant un index variable. Utile pour itérer sur les éléments d'un tableau de manière contrôlée.

* `SUBSCRIPT`   :  Indice permettant de cibler un élément du tableau.                             
*  `STRING`      :  Permet de concaténer plusieurs champs dans une même ligne de texte.    
---



Voici les exercices détaillés en suivant ta demande avec les **explications** et les **indices** pour chaque étape.

---

# Objectifs journaliers MS COBOL P4 – **Les tableaux multidimensionnels**

### Lundi 20 Mai

---

## Exercice 1 – Saisie d'un tableau multidimensionnel depuis le terminal

### Objectif :

Créer un tableau multidimensionnel de **noms** et **prénoms** d'élèves dans deux classes (CM1 et CM2) directement depuis le terminal.

### Tableau attendu :

```cobol
01 TAB-ELEVES.
   05 CLASSE OCCURS 2 TIMES.       *> 1 = CM1, 2 = CM2
      10 ELEVE OCCURS 6 TIMES.
         15 NOM-ELEVE     PIC X(15).
         15 PRENOM-ELEVE  PIC X(15).
```

### Étapes :

1. Déclarer un tableau avec 2 classes et 6 élèves par classe, comme montré ci-dessus.
2. Utiliser des boucles imbriquées pour demander à l'utilisateur d'entrer le **nom** et le **prénom** pour chaque élève, en commençant par la classe CM1.
3. Afficher le résultat sous forme de liste après la saisie.

### Indices :

* Utiliser `PERFORM VARYING` pour parcourir les classes (`IDX-1`) et les élèves (`IDX-2`).
* Demander à l'utilisateur de saisir les informations pour chaque élève.
* Exemple d’affichage attendu :
  `"Entrer le nom et prénom de l'élève 1 de CM1 :"`
  `"Nom : DUPONT, Prénom : PIERRE"`

---

## Exercice 2 – Lire un tableau multidimensionnel à partir d'un fichier et rechercher des prénoms

### Objectif :

Lire un fichier texte contenant les noms et prénoms d’élèves, puis permettre à l’utilisateur de rechercher un **nom de famille** pour afficher la liste des **prénoms** associés à ce nom dans la classe correspondante.


### Étapes :

1. Créer une structure en COBOL pour lire le fichier et charger les informations dans un tableau 2D similaire à l'exercice 1.
2. Demander à l’utilisateur de saisir un **nom de famille**.
3. Lire le fichier ligne par ligne, extraire les prénoms et les afficher uniquement si le **nom de famille** correspond à celui saisi par l'utilisateur.
4. Afficher les prénoms associés à ce nom dans la classe correspondante.

### Indices :

* Utiliser `OPEN INPUT` pour ouvrir le fichier.
* Utiliser une boucle `PERFORM` pour parcourir chaque ligne du fichier.
* Comparer le nom de famille dans chaque ligne avec le nom saisi par l'utilisateur.
* Afficher les prénoms correspondants dans un format lisible.

---



## Exercice 3 – Saisie d'un tableau multidimensionnel depuis le terminal, écriture dans un fichier et tri alphabétique

### Objectif :

Saisir un tableau multidimensionnel de **noms** et **prénoms** d'élèves dans deux classes (CM1 et CM2) depuis le terminal, trier les élèves par ordre alphabétique, puis enregistrer les données triées dans un fichier texte.

### Tableau attendu :

```cobol
01 TAB-ELEVES.
   05 CLASSE OCCURS 2 TIMES.       *> 1 = CM1, 2 = CM2
      10 ELEVE OCCURS 6 TIMES.
         15 NOM-ELEVE     PIC X(15).
         15 PRENOM-ELEVE  PIC X(15).
```

### Étapes :

1. Demander à l'utilisateur d'entrer les **noms** et **prénoms** pour chaque élève des classes CM1 et CM2.
2. Enregistrer les données dans une table en mémoire.
3. Trier les élèves par **nom de famille** et **prénom** par ordre alphabétique.
4. Ouvrir un fichier en mode **OUTPUT** et y écrire les données triées.

### Bonus – Tri alphabétique :

* Utilise une méthode de tri pour organiser les élèves par **nom de famille** et, en cas d'égalité, par **prénom**.
* Le tri peut être effectué directement en mémoire avant d'écrire dans le fichier.

### Indices :

* Utilise une fonction de tri disponible en COBOL ou une méthode manuelle pour trier les élèves.

  * Par exemple, tu peux parcourir la liste et échanger les éléments qui ne sont pas dans le bon ordre.
* Après avoir trié les élèves, utilise `OPEN OUTPUT` pour ouvrir le fichier et y écrire les informations dans l'ordre alphabétique.
* Utilise `WRITE` pour ajouter une ligne au fichier après chaque tri.

---

### Explication du **bonus** :

1. **Tri des éléments** :

   * Tu peux effectuer un tri manuellement en utilisant une **boucle imbriquée** qui compare chaque **nom de famille** et **prénom** des élèves.
   * Si un élément est dans le mauvais ordre, échange les positions des éléments dans le tableau.

2. **Trier d'abord par nom de famille**, puis si deux noms de famille sont identiques, trier **par prénom**.

### Exemple de procédure de tri :

* **Première boucle** : Compare chaque élève avec les autres pour les trier par nom de famille.
* **Deuxième boucle** (en cas d'égalité sur le nom) : Compare les prénoms et trie les élèves par prénom.

---
