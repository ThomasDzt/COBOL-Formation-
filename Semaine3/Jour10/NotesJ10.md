# Jour 10 - Mardi 06 Mai 2025

## Notions vues

### Instruction OCCURS et fonctions MOD(), TRIM() et LENGTH()

**OCCURS n TIMES :**    
Il s'agit d'un type de déclaration dans un tableau. Permet la répétition d'un groupe ou d'un élément du tableau. Les éléments ainsi créés seront désignés à l'aide d'un index.

Par exemple : 

```cobol
 01 WS-MOT.  
*  Mot de 10 lettres maximum.
    05 WS-LETTRE-MOT    OCCURS 10 TIMES.
        10 WS-LETTRE    PIC X.

* Index pour parcourir les lettres du mot saisi.
77 WS-IDX               PIC 9(02). 
```

Ou encore : 

```cobol
* Tableau de saisie des nombres.
01 WS-TABLEAU.
    05 WS-LIGNE-TABLEAU OCCURS 3 TIMES.

* Nombre saisi par l'utilisateur après contrôle de saisie.
        10 WS-NBR           PIC 9(02).

* Saisie du nombre par l'utilisateur.
        10 WS-NBR-SAISI     PIC X(05).

* Index pour parcourir le tableau.
77 WS-IDX               PIC 9(02).
```

Dans le premier exemple, le mot saisi est défini comme un tableau de 10 éléments maximum et chaque lettre composant le mot est un élément du tableau.   
Dans le second exemple, il s'agit d'un tableau de 3 éléments dans lequel sont saisis 3 nombres.     

**NB :** Lors de l'utilisation d'un `OCCURS n TIMES`, il est possible de préciser un tableau de **taille variable** à l'aide de `DEPENDING ON`. 

Par exemple :

```cobol
* Tableau de notes avec dates.
01 WS-TAB.
    05 WS-LIGNE-TAB OCCURS 1 TO 100 TIMES DEPENDING ON WS-COMPTE.
        10 FILLER       PIC X(07)       VALUE "Note : ".
        10 WS-NOTE      PIC 9(02).
        10 FILLER       PIC X(04)       VALUE " le ".
        10 WS-DATE.
            15 WS-JOUR      PIC 9(02).
            15 FILLER       PIC X           VALUE "/".
            15 WS-MOIS      PIC 9(02).
            15 FILLER       PIC X           VALUE "/".
            15 WS-ANNEE     PIC 9(04).  

* Variable de saisie de la note pour contrôle de saisie.
01 WS-NOTE-TEMP         PIC S9(03).

* Index pour parcourir le tableau.
77 WS-IDX               PIC 9(03).

* Variable de décompte du nombre de lignes de tableau remplies. 
01 WS-COMPTE            PIC 9(03).
```
Le `OCCURS`est accompagné d'un intervalle spécifié par *VALEUR1* `TO` *VALEUR2* lorsqu'on utilise `DEPENDING ON` *VARIABLE*.
<br><br/> 

**FUNCTION MOD :**  
Permet de récupérer le reste d'une division sans passer par le **GIVING...REMAINDER...**.  

Par exemple : 
```cobol
IF FUNCTION MOD(WS-ANNEE, 4) = 0 
AND FUNCTION MOD(WS-ANNEE, 100) NOT = 0 
OR FUNCTION MOD(WS-ANNEE, 400) = 0

    DISPLAY "L'année est bissextile."

ELSE 
    DISPLAY "L'année n'est pas bissextile."

END-IF.
```

Dans cet exercice on vérifie si une année est bissextile : elle doit être divisible par 4 et pas par 100, sauf si elle est divisible par 400. Pour tester la divisibilité on utilise `MOD` qui renvoie le reste d’une division: si le reste vaut 0, la division est exacte et l’année est divisible par le diviseur.

<br><br/>

**FUNCTION TRIM :**     
Permet de supprimer les espaces en début ou en fin de chaîne de caractères.

En reprenant les variables de l'exemple utilisé pour le `OCCURS`. 

```cobol 
DISPLAY "Veuillez saisir un mot (10 lettres max) : "    
WITH NO ADVANCING.

ACCEPT WS-MOT.

* Affichage du mot saisi.
DISPLAY "Mot : " WS-MOT ".".
DISPLAY "Mot : " FUNCTION TRIM(WS-MOT) ".".
```
Mettons que l'utilisateur entre "bonjour". La variable `WS-MOT` étant de longueur 10, on s'attend normalement à avoir 3 espaces entre la fin de "bonjour" et le point ".".  
Faisons la comparaison :

```bash
Veuillez saisir un mot (10 lettres max) : bonjour
Mot : bonjour   .
Mot : bonjour.
```
Les espaces ont bien été supprimés.

<br><br/>

**FUNCTION LENGTH :**   
Permet de déterminer la longueur d'une chaîne de caractères en argument.

Exemple : 

```cobol
0100-SAISIE-MOT-DEB.

    DISPLAY "Veuillez saisir un mot : ".
    ACCEPT WS-MOT.
           
* Détermination de la longueur du mot.
    MOVE FUNCTION LENGTH(FUNCTION TRIM(WS-MOT)) TO WS-LONG.
   
    EXIT.
    
    DISPLAY "Longueur : " WS-LONG ".".
    DISPLAY "Mot saisi : " FUNCTION TRIM (WS-MOT) ".".

0100-SAISIE-MOT-FIN.
```

```bash
Veuillez saisir un mot : bonjour
Longueur : 07.
Mot saisi : bonjour.
```

