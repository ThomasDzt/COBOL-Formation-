# Objectifs journaliers MS COBOL P4




## Jour 1 – Lecture des données

Cette première étape consiste à lire un fichier d'entrée (`input.dat`) contenant deux types d'enregistrements : des informations sur les étudiants et sur leurs cours. Le but est de parcourir ce fichier, d’identifier chaque type d’enregistrement à l’aide d’une clé, et de stocker les informations dans des structures COBOL adaptées. Une attention particulière est portée à la gestion de la variabilité du nombre d’élèves et de matières.

### Analyse du fichier d’entrée

* [ ] Comprendre la structure du fichier :

  * [ ] Clé `01` pour les étudiants : prénom, nom, âge
  * [ ] Clé `02` pour les cours : libellé, coefficient, note
* [ ] Étudier la `FILE SECTION` :

  * [ ] Définir les structures `REC-STUDENT`, `REC-COURSE`
* [ ] Prendre en compte les enregistrements de longueur variable

### Lecture et identification des enregistrements

* [ ] Ouvrir le fichier avec `OPEN INPUT`
* [ ] Lire chaque enregistrement avec `READ` en boucle jusqu’à fin de fichier
* [ ] Utiliser la clé (`R-S-KEY` ou `R-C-KEY`) pour distinguer les types :

  * [ ] Si étudiant (`01`), stocker dans `STUDENT`
  * [ ] Si cours (`02`), associer au dernier étudiant lu

### Stockage structuré

* [ ] Incrémenter un index `STUDENT-LGHT` pour chaque nouvel étudiant
* [ ] Remplir les champs `S-FIRSTNAME`, `S-LASTNAME`, `S-AGE`, etc.
* [ ] Organiser les cours en tableau interne ou structure imbriquée liée à l’étudiant

### Débogage

* [ ] Utiliser `DISPLAY` pour vérifier les données lues
* [ ] Tester le comportement sur un fichier vide ou mal formé
* [ ] S'assurer que les fichiers `input-test1.dat` et `input-test1.dat` sont traités correctement par votre programme

### Documentation initiale

* [ ] Noter les choix techniques concernant la structure de stockage
* [ ] Documenter la logique d’identification et de différenciation des enregistrements
* [ ] Ajouter les premiers commentaires dans le code

---










