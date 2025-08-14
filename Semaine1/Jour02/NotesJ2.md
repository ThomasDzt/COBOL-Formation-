# Jour 02 - Mercredi 23 Avril 2025

## Commandes terminal


**Pour compiler un programme cobol :** `cobc -x programme.cbl`  
**Pour ouvrir vscode :** `code .`  
**Pour voir quel sont les fichiers présents :** `ls`  
**Pour changer de dossier :** `cd /chemin/dossier`  
**Pour revenir en arrière sur la route :** `cd ..`  
**Pour revenir au dossier utilisateur:** `cd ~`    
**Pour créer un fichier :** `touch fichier.extension`    
**Lancer le programme :** `./programme`    
**Nettoyer le terminal :** `clear`    
**Pour ouvrir le code dans le terminal :** clic droit dans le dossier où se trouve le fichier .cbl

<br><br/>


## Généralités en COBOL

Un code COBOL s'écrit sur **80 colonnes**.

**Colonnes 1 à 6 :**  représentent la numérotation des lignes et des pages.  
**Colonne 7:** indicateurs de :     
- continuation de ligne (-).   
- commentaires (*).  
- ligne de debug (D) *exécutée seulement si l’option DEBUGGING MODE est activée*.        

**Colonnes 8 à 72 :** réservées à l'écriture du programme.      
- **Marge A :** à partir de la colonne 8, contient les noms des divisions, sections, paragraphes.
- **Marge B :** à partir de la colonne 12, contient les instructions élémentaires du programme.     

**Colonnes 73 à 80 :** utilisées pour l’identification mais non contrôlées.

<br><br/>

## Structure d'un programme COBOL

Un programme COBOL est constitué de **4 divisions**.

### IDENTIFICATION DIVISION

Carte d'identité du programme. Permet d'avoir les informations sur le nom du programme, du programmeur et la date d'écriture du programme.  

Exemple : 
```
IDENTIFICATION DIVISION.
PROGRAM-ID. Program.
AUTHOR. Thomas.
DATE-WRITTEN. 13-08-2025 (fr).
```

### ENVIRONMENT DIVISION
Permet de définir le type d’ordinateur pour lequel est écrit le programme, ainsi que les périphériques nécessaires pour supporter les fichiers. (voir lacommunauteducobol.com).     
Spécifié en formation pour utiliser l'**INPUT-OUTPUT SECTION**.     

**INPUT-OUTPUT SECTION :** Sert à déclarer les fichiers qu'un programme va utiliser pour lire, écrire ou mettre à jour des données. Elle contient la **FILE-CONTROL**.


**FILE-CONTROL :** Indique quels fichiers seront utilisés dans le programme et comment ils sont reliés aux fichiers (physiques) sur les périphériques (Disque, bande, imprimante).  

Exemple : 
```
ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT STUDENT-FILE
        ASSIGN TO "student.dat"
        ORGANIZATION IS LINE SEQUENTIAL.
```
La structure des enregistrements du fichiers est décrite dans la **FILE SECTION** de la **DATA DIVISION**.

Suite de l'exemple :

```
DATA DIVISION.
FILE SECTION.
FD STUDENT-FILE.
01 F-STUDENT-RECORD.
    05 F-STUDENT-ID    PIC 9(05).
    05 F-STUDENT-NAME  PIC X(20).

PROCEDURE DIVISION.
    OPEN OUTPUT STUDENT-FILE
    MOVE 12345 TO F-STUDENT-ID
    MOVE "Jean Dupont" TO F-STUDENT-NAME
    WRITE F-STUDENT-RECORD
    CLOSE STUDENT-FILE
    STOP RUN.
```

### DATA DIVISION

C'est ici qu'on déclare les variables à utiliser ou encore qu'on décrit les fichiers à utiliser. Cette division est constituée de **4 sections**.

- **FILE SECTION :** Décrit la structure du fichier utilisé, c'est-à-dire les variables (zones mémoire) qui récupèrent les enregistrements des fichiers.    

- **WORKING-STORAGE SECTION :** Section dans laquelle on déclare les variables de travail. Il y a 2 types de variables, **les variables élémentaires** (de niveau hiérarchique 01 ou 77) et les **groupes de variables** (allant du niveau 02 à 49).    

Exemple : 
```
01 WS-CLIENT.
   05 WS-NOM        PIC X(20).
   05 WS-PRENOM     PIC X(15).

   05 WS-SEXE       PIC X.
      88 WS-HOMME               VALUE 'M'.
      88 WS-FEMME               VALUE 'F'.

77 WS-COMPTEUR      PIC 9(04)    VALUE 0.
``` 

- **LINKAGE SECTION :** Section qui relie le programme principal et ses sous-programmes. Dedans on déclare les variables qui vont communiquer avec les sous-programmes. Les sous-programmes sont appelés en **PROCEDURE DIVISION** à l'aide de l'instruction **CALL** (parfois suivi de **USING + variables** lorsque nécessaire).

- **SCREEN SECTION :** sert à créer une interface front, des écrans.

### PROCEDURE DIVISION

C'est ici que sont écrites toutes les instructions du programme, c'est-à-dire ce que va faire le programme. Chaque instruction commence par un **verbe/mot-clé COBOL** et se termine par un **point (.)** ou par un **END-terminator**.     
Les instructions peuvent être regroupées en **paragraphes**.    
La PROCEDURE DIVISION doit être terminée par un **STOP RUN** (ou un **EXIT PROGRAM** dans le cas d'un sous-programme).  

<br><br/>

## Notions vues

### Instructions ACCEPT et DISPLAY  

**ACCEPT :** permet la saisie d'une valeur dans une variable depuis le termminal.   

**DISPLAY :** permet l'affichage de la valeur d'une variable.   

### Opérations arithmétiques 

**ADD :** permet d'effectuer des additions entre plusieurs nombres.       
```
ADD VARIABLE1 TO VARIABLE2
```
<br><br/>

**SUBTRACT :** permet d'effectuer des soustractions entre plusieurs nombres.

```
SUBTRACT VARIABLE1 FROM VARIABLE2
```
<br><br/>

**MULTIPLY :** permet d'effectuer des produits entre des nombres.     

```
MULTIPLY VARIABLE1 BY VARIABLE2
```
<br><br/>

**DIVIDE :** permet d'effectuer des divisions entre des nombres.     

```
DIVIDE VARIABLE1 BY VARIABLE2   pour diviser VARIABLE1 par VARIABLE2

ou

DIVIDE VARIABLE1 INTO VARIABLE2   pour diviser VARIABLE2 par VARIABLE1

```
<br><br/>

**NB :** Pour toutes ces opérations, on peut utiliser le **GIVING** afin de stocker le résultat dans une variable.

```
ADD VARIABLE1 TO VARIABLE2 GIVING SOMME
SUBTRACT VARIABLE1 FROM VARIABLE2 GIVING DIFFERENCE
MULTIPLY VARIABLE1 BY VARIABLE2 GIVING PRODUIT
DIVIDE VARIABLE1 BY VARIABLE2 GIVING QUOTIENT
```

On peut aussi stocker le reste d'une division dans une variable avec **REMAINDER** :

```
DIVIDE VARIABLE1 BY VARIABLE2 GIVING QUOTIENT REMAINDER RESTE
```

