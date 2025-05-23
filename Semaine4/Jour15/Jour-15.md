# Objectifs journaliers MS COBOL P4


### Mercredi 14 Mai


#### 📌 Introduction aux **fichiers séquentiels**

* [ ] Comprendre la clause `SELECT` dans l’`ENVIRONMENT DIVISION`
  * [ ] `ASSIGN TO` + nom du fichier réel
  * [ ] `ORGANIZATION IS SEQUENTIAL`
* [ ] Étudier la section `FILE-CONTROL` et la déclaration `FD` dans `DATA DIVISION`
* [ ] Découvrir les commandes :

  * [ ] `OPEN INPUT/OUTPUT/EXTEND`
  * [ ] `READ` avec clause `AT END`
  * [ ] `WRITE`

#### 📌 Structure et déclaration des enregistrements

* [ ] Comprendre comment déclarer un enregistrement lié au fichier
* [ ] Relier chaque champ COBOL à une colonne du fichier texte

---

### Gestion de son apprentissage

* [ ] Ajouter une section « fichiers séquentiels » dans sa cheat sheet
* [ ] Documenter les commandes `OPEN`, `READ`, `WRITE`, `AT END`

---

* [ ] Présenter un des programmes utilisant les fichiers séquentiels
* [ ] Faire un retour rapide sur les notions de `AT END` et structure d’enregistrement

#### 📌 Manipulation avancée des **fichiers séquentiels**

* [ ] Lire un fichier en boucle, filtrer des données, écrire un nouveau fichier
* [ ] Gérer les fichiers d’entrée ET de sortie dans un seul programme
* [ ] Simuler la mise à jour d’un fichier séquentiel avec un fichier temporaire

#### 📌 Fichiers d’entrée multiples

* [ ] Étudier un programme lisant 2 fichiers (clients + commandes)
* [ ] Importance de synchroniser les fichiers (triés par ID ? )

---

### Exercices pratiques

* [ ] Lire un fichier d'élèves `eleves.txt` (`Nom`, `Note`) et créer un fichier `reussite.txt` avec uniquement les élèves ayant plus de 10
* [ ] Lire un fichier `inventaire.txt`, extraire les articles en rupture (`STOCK = 0`) et les écrire dans `rupture.txt`
* [ ] Lire 2 fichiers (`clients.txt`, `commandes.txt`) et afficher les commandes par client (assume ID client commun)
* [ ] Écrire un programme qui copie un fichier `compte-rendu.txt` ligne par ligne, en ignorant les lignes vides

---

### Gestion de son apprentissage

* [ ] Ajouter un schéma des interactions entre fichiers d’entrée/sortie
* [ ] Documenter la gestion des fichiers temporaires pour la mise à jour

---
