# Objectifs journaliers MS COBOL P4


### Jeudi 22 Mai



## Jour 2 – Traitement des données

Une fois les données lues et stockées, cette phase vise à exploiter ces informations en calculant les **moyennes pondérées** pour chaque étudiant. Il s'agit également de gérer les cas particuliers comme les **doublons de noms** et de trier les résultats à l’aide des instructions `SEARCH` et `SORT`. Ces traitements permettent de préparer un rapport clair et organisé.

### Calcul des moyennes

* [ ] Parcourir chaque étudiant dans la structure `STUDENT`
* [ ] Pour chaque cours associé :

  * [ ] Multiplier note × coefficient
  * [ ] Additionner les résultats pour obtenir la somme pondérée
  * [ ] Calculer la moyenne : somme pondérée ÷ somme des coefficients, avec `ROUNDED`
* [ ] Stocker la moyenne dans un champ `S-AVERAGE` dédié

### Détection de doublons

* [ ] Utiliser `SEARCH` pour détecter des étudiants ayant le même nom de famille (`S-LASTNAME`)
* [ ] Si doublon détecté :

  * [ ] Ajouter un identifiant distinct pour éviter toute confusion dans le rapport

### Tri des données

* [ ] Utiliser `SORT` pour trier les étudiants :

  * [ ] Par moyenne (ordre décroissant) ou
  * [ ] Par nom (ordre alphabétique)
* [ ] Si `SORT` est difficile à mettre en œuvre, proposer un tri "manuel" (ex. : par sélection ou échange)

### Débogage

* [ ] Vérifier la justesse des calculs avec `DISPLAY`
* [ ] Tester la détection des doublons et la validité du tri 
* [ ] S'assurer que les fichiers `input-test1.dat` et `input-test1.dat` sont traités correctement par votre programme


### Documentation intermédiaire

* [ ] Expliquer la méthode de calcul des moyennes
* [ ] Documenter l’usage de `SEARCH` et `SORT`
* [ ] Noter les ajustements faits pour gérer la variabilité des données

---