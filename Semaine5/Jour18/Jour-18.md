# Objectifs journaliers MS COBOL P4


### Lundi 19 Mai





## Objectifs pédagogiques
- Approfondir la gestion des fichiers séquentiels en COBOL  
- Comprendre l’utilisation des copybooks pour structurer les données  

---

## Principe des fichiers `.cpy` en COBOL
Un fichier `.cpy` (copybook) contient des définitions de structures de données réutilisables, incluses dans un programme via `COPY`.  
Il standardise les enregistrements, facilite la maintenance et sépare la logique des définitions.

---

## Exercice : Gestion des horaires de trains – `train.dat`

Vous disposez :
- d’un fichier texte `train.dat` contenant des informations sur des trains,
- d’un copybook `train-record.cpy` définissant la structure des enregistrements.

Chaque ligne comprend :
- Type de train (`TGV`, `COR`, `TER`)
- Gare de départ (18 caractères)
- Heure de départ (format `HHMM`)
- Durée du trajet (en heures)
- Indicateurs d’arrêts (jusqu’à 10 caractères, `H` pour arrêt)

---

### ➤ Partie 1 – Lecture et affichage
- Lire le fichier `train.dat` ligne par ligne en utilisant `train-record.cpy`.
- Afficher pour chaque train : le type, la gare de départ et l’heure de départ (format `HH:MM`).

---

### ➤ Partie 2 – Calcul et traitement
- Compter le nombre d’arrêts (`H`) pour chaque train.
- Calculer l’heure d’arrivée (heure de départ + durée, ajustée si > 23h).
- Afficher l’heure d’arrivée au format `HH:MM` et le nombre d’arrêts **pour le premier train**.

---

### ➤ Partie 3 – Génération d’un rapport
- Créer un fichier de sortie `train2.dat`.
- Écrire pour chaque train :
  - Type (ex. `"High-speed Train"` pour `TGV`)
  - Gare
  - Heure de départ (`HH:MMh`)
  - Durée
  - Nombre d’arrêts
  - Heure d’arrivée (`HH:MMh`)
- Ajouter une ligne finale avec le **nombre total de trains traités**.

Proposition de format : 
```
Train Type: High-speed Train | Departure Station: MALAGA           | Train Time: 21:34h | Duration: 18h | Stops: 06 | Arrival Time: 15:34h

```
station depart:
Heure depart:
Duree trajet:
Arrets:
Heure arrivee:
---

### ➤ Partie Bonus – Recherche par index
- Demander à l’utilisateur un numéro d’enregistrement.
- Stocker les enregistrements dans un tableau.
- Écrire l’enregistrement correspondant dans un fichier `train-unique.dat` avec une en-tête.

---

## Consolidation
- Ajouter une section sur les **copybooks** et les **fichiers séquentiels** à sa *cheat sheet*.
- Organiser ses programmes dans son dépôt Git et faire un **push**.
