# Jour 14 - Mardi 13 Mai 2025

## Notions vues

### La gestion de fichiers en COBOL

**Rappel**

**ENVIRONMENT DIVISION :**
Permet de définir le type d’ordinateur pour lequel est écrit le programme, ainsi que les périphériques nécessaires pour supporter les fichiers. (voir lacommunauteducobol.com).     
Spécifié en formation pour utiliser l'**INPUT-OUTPUT SECTION**.     

**INPUT-OUTPUT SECTION :** Sert à déclarer les fichiers qu'un programme va utiliser pour lire, écrire ou mettre à jour des données. Elle contient la **FILE-CONTROL**.


**FILE-CONTROL :** Indique quels fichiers seront utilisés dans le programme et comment ils sont reliés aux fichiers (physiques) sur les périphériques (Disque, bande, imprimante).  

Par exemple : 

```cobol
ENVIRONMENT DIVISION.

INPUT-OUTPUT SECTION.
FILE-CONTROL.

SELECT FICHIER-PERSONNE ASSIGN TO "personnes.txt"
ORGANIZATION IS LINE SEQUENTIAL.
```
Ici `SELECT` permet de créer un alias au fichier auquel on l'assigne avec `ASSIGN TO` `"nomfichier.extension"`.     

De plus, la clause `ORGANIZATION IS LINE SEQUENTIAL` spécifie que le fichier sera traité ligne par ligne.

<br><br/>

La structure des enregistrements du fichier est décrite dans la **FILE SECTION** de la **DATA DIVISION**.

Par exemple : 

```cobol
DATA DIVISION.

FILE SECTION.

FD FICHIER-PERSONNE.

01 F-LIGNE  PIC X(50).

```