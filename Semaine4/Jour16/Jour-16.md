# Objectifs journaliers MS COBOL P4

### Jeudi 15 Mai 2025

## IBM Z Xplore – Suite des modules Zowe Explorer

## 🧱 Fundamentals Level

Les modules du niveau **Fundamentals** renforcent les **compétences de base** sur l’environnement IBM Z à travers **Zowe Explorer** et les langages associés.

[Site IBM Z Xplore](https://ibmzxplore.influitive.com/forum/)  

---

### 🔧 Wrap Up

* **Objectif** : Finaliser les concepts de base de Zowe Explorer et consolider les acquis.
  * Révision des fonctionnalités de Zowe Explorer
  * Gestion des datasets et soumission de jobs
* **Utilité** : Préparer à des tâches avancées sur mainframe.

---

### 📄 REXX1

* **Objectif** : Introduction au langage **REXX**.
  * Écriture de scripts REXX simples
  * Interaction avec les datasets
* **Utilité** : Automatisation des tâches sur z/OS.

---

### 💻 Code1

* **Objectif** : Approfondir l’utilisation de **VS Code** avec Zowe Explorer.
  * Création et édition de programmes dans l’environnement mainframe
  * Soumission et débogage de jobs
* **Utilité** : Maîtriser l’interface pour le développement.



---

## Exercice : Brief Gestion de fichiers – *assurances.dat*

### Objectif global

Créer un programme COBOL qui :

1. Lit un fichier séquentiel `assurances.dat`
2. Affiche certains enregistrements selon un critère
3. Génère un fichier de sortie avec un résumé

Voici les noms des colonnes du fichier :

1. **Code contrat**
2. **Nom contrat**
3. **Nom produit**
4. **Nom client**
5. **Statut**
6. **Date de début**
7. **Date de fin**
8. **Montant**
9. **Devise**

---

##  Étape 1 : Déclaration et lecture du fichier `assurances.dat`

### Objectifs :

* Déclarer le fichier `assurances.dat` dans la section `ENVIRONMENT DIVISION`
* Définir la structure des enregistrements dans la `DATA DIVISION`
* Lire le fichier séquentiellement
* Stocker les enregistrements dans une table interne (tableau COBOL).
* 
### Conseils :

* Utilise des `FD` bien structurés avec des noms explicites.
* Prévois une variable de contrôle de fin de fichier (`AT END`).
* Assure-toi que les noms de variables ne dépassent pas le **bon** nombre de charactères.
* Attention à l'alignement des `PIC` (notamment pour les types numériques).
* Gère correctement les caractères spéciaux (pas d'accents, noms en majuscules sans tirets).

---

## Étape 2 : Affichage des enregistrements spécifiques

### Objectifs :

* Après validation dans le Terminal :
* Afficher **uniquement les enregistrements 3 et 7**.
* Afficher un message clair en à la lecture explicitant les informations lues.

### Conseils :

* Utilise un index pour charger les enregistrements dans un tableau (par exemple `OCCURS 100 TIMES`).
* Pour le contrôle, affiche la **position courante** dans la boucle.
* Pour l’affichage, aligne les champs avec `DISPLAY` en format lisible.
* Attention à ne pas dépasser les limites du tableau (déclarer une taille suffisante).
* Bien gérer l’indexation (commence à 1, pas à 0).
* Vérifie que tu as bien au **moins 7 enregistrements** sinon protège ton code par un test.

---

## Étape 3 : Création du fichier de rapport `rapport-assurances.dat`

### Objectifs :

* Après validation dans le Terminal :
* Écrire les données affichées (3 et 7) dans un nouveau fichier séquentiel, avec une en-tête précisant les informations présentes dans le tableau.
* Mettre les dates dans un format lisible.
* Ajouter un message de résumé (ex. : “Fin du traitement – 2 enregistrements exportés”).


### Conseils :

* Déclare un second `FD` pour le fichier de sortie.
* N’oublie pas d’**ouvrir en OUTPUT**, puis de fermer les fichiers à la fin du programme.
* Tu peux copier les champs de l’enregistrement tel quel dans l’enregistrement du fichier de sortie.
* Attention au format d’écriture : ne pas dépasser 80 caractères par ligne.
* Ne pas confondre `WRITE` et `DISPLAY`.
* Bien s’assurer que le fichier est fermé (`CLOSE`) après l’écriture.

---

## Étape Bonus : Création du fichier de rapport `rapport-assurances-unique.dat`

### Objectifs :

* Après demande de saisie de numéro de ligne du fichier dans le Terminal :
* Écrire les donnée référencée à l'index indiqué dans un nouveau fichier séquentiel, avec une en-tête précisant les informations présentes dans le tableau.

---
