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

Lors de la gestion de fichiers en COBOL, il est possible de lire, écrire ou encore modifier des fichiers. C'est dans la `PROCEDURE DIVSION` que toutes ces actions peuvent être effectuées.

Par exemple : 

```cobol
DISPLAY "Ouverture du fichier...".
OPEN INPUT FICHIER-PERSONNE.
           
DISPLAY "Lecture du fichier...".
PERFORM UNTIL WS-FIN-LECTURE-O
    READ FICHIER-PERSONNE

        AT END 
            SET WS-FIN-LECTURE-O TO TRUE 
            DISPLAY "Fin de lecture."

        NOT AT END 
            IF WS-IDX <= WS-MAX 
                ADD 1 TO WS-IDX

                MOVE F-LIGNE(1:15) TO WS-NOM(WS-IDX)
                MOVE F-LIGNE(16:15) TO WS-PRENOM(WS-IDX)
                MOVE F-LIGNE(31:2) TO WS-MOIS(WS-IDX)
                MOVE F-LIGNE(33:2) TO WS-JOUR(WS-IDX)
                MOVE F-LIGNE(35:4) TO WS-ANNEE(WS-IDX)

            END-IF 
    END-READ 
END-PERFORM.

           DISPLAY "Fermeture du fichier".
           CLOSE FICHIER-PERSONNE.
```

`OPEN INPUT` permet d'ouvrir un fichier d'entrée (désigné ici par l'alias créé dans la `FILE-CONTROL`). 

`READ`...`END-READ` permet d'effectuer la lecture du fichier (ici ligne par ligne vu l'organisation séquentielle du fichier). Les clauses `AT END` et `NOT AT END` décrivent respectivement les instructions à exécuter à la fin du fichier et lors de la lecture du fichier.   

`CLOSE` permet de fermer le fichier ouvert.


### Instruction SORT    

Permet de trier des enregistrements et des tableaux selon les spécifications indiquées par le programme.

Par exemple :   

```cobol
DATA DIVISION.
WORKING-STORAGE SECTION.

       01 WS-TABLEAU-PERSONNE.
           05 WS-LIGNE OCCURS 10 TIMES INDEXED BY WS-IDX2.
               10 WS-NOM           PIC X(15).
               10 WS-PRENOM        PIC X(15).
               10 WS-DATE. 
                   15 WS-JOUR      PIC 9(02).
                   15 FILLER       PIC X           VALUE "/".
                   15 WS-MOIS      PIC 9(02).
                   15 FILLER       PIC X           VALUE "/".
                   15 WS-ANNEE     PIC 9(04).


PROCEDURE DIVISION.

    SORT WS-LIGNE ON ASCENDING KEY WS-NOM.
```
Ici les données du tableau créé en `DATA DIVISION` sont triées `ON ASCENDING KEY WS-NOM` c'est-à-dire de manière croissante selon la clé spécifiée `WS-NOM`.
Au contraire, `ON DESCENDING` permet de trier dans l'ordre décroissant. 



### Instruction SEARCH 

Permet la recherche et la sélection d'un élément d'un tableau respectant la condition énoncée dans l'instruction SEARCH. Nécessite que le tableau soit indexé.  

Par exemple :

```cobol
SEARCH WS-LIGNE 
               
    AT END 
        DISPLAY "Aucune personne trouvée à ce nom."

    WHEN FUNCTION UPPER-CASE(WS-CHERCHE-NOM) = WS-NOM(WS-IDX2)
        DISPLAY "Personne correspondante trouvée."
        DISPLAY WS-NOM(WS-IDX2) WITH NO ADVANCING
                WS-PRENOM(WS-IDX2) WITH NO ADVANCING
                WS-DATE(WS-IDX2)
                   
END-SEARCH.
```
La condition de recherche est décrite avec `WHEN`.  
`AT END` permet d'exécuter l'instruction spécifiée lorsque la recherche se conclut sans avoir vérifié la condition.

