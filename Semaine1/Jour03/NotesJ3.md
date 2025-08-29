# Jour 03 - Jeudi 24 Avril 2025


## Branches conditionnelles en COBOL

### IF ... ELSE ... END-IF
Lorsqu'on veut tester une condition on utilise l'instruction **IF** ... **ELSE** ... **END-IF.** Chaque IF doit se terminer par un END-IF. De plus il faut faire attention à l'indentation au sein de l'instruction IF.

Exemple :

```cobol
IF WS-NBR GREATER THAN 0 OR EQUAL 0

    DISPLAY "Le nombre saisi est positif."

ELSE 
           
    DISPLAY "Le nombre saisi est négatif."
               
END-IF.
```

Ainsi lorsque la condition est remplie, les instructions qui la suivent sont exécutées par le programme. 
<br><br/>

### EVALUATE

#### EVALUATE *VARIABLE* ... WHEN *CONDITION*

Lorsqu'on veut tester plus de deux conditions (que l'on peut clairement indiquer), on utilise l'**EVALUATE**.

Exemple :

```cobol
EVALUATE WS-AGE 

    WHEN >= 0 AND <= 11
        DISPLAY "Vous êtes un enfant."

    WHEN >= 12 AND <= 17
        DISPLAY "Vous êtes un adolescent."

    WHEN >= 18 AND <= 64
        DISPLAY "Vous êtes un adulte."

    WHEN OTHER 
    DISPLAY "Vous êtes un senior."

END-EVALUATE.
```

Il existe une alternative à l'EVALUATE.

#### EVALUATE TRUE *CONDITION*

```cobol
EVALUATE TRUE  

    WHEN WS-AGE >= 0 AND <= 11
        DISPLAY "Vous êtes un enfant."

    WHEN WS-AGE >= 12 AND <= 17
        DISPLAY "Vous êtes un adolescent."

    WHEN WS-AGE >= 18 AND <= 64
        DISPLAY "Vous êtes un adulte."

    WHEN OTHER 
    DISPLAY "Vous êtes un senior."

END-EVALUATE.
```
<br><br/>

## Les conditions simples 

On peut ici parler des comparaisons :

- **EQUAL** ou **=** pour signifier une égalité entre deux valeurs

- **GREATER THAN** ou **>** pour signifier que la valeur 1 est supérieure à la valeur 2

- **LESS THAN** ou **<** pour signifier que la valeur 1 est inférieure à la valeur 2

- **GREATER THAN OR EQUAL** ou **>=** pour signifier que la valeur 1 est supérieure ou égale à la valeur 2

- **LESS THAN OR EQUAL** ou **<=** pour signifier que la valeur 1 est inférieure ou égale à la valeur 2
<br><br/>

## Les opérateurs logiques

Il s'agit d'opérateurs que l'on peut associer aux conditions évoquées : 

- **AND** signifie que les conditions sont remplies simultanément       
(*Condition1* ET *Condition2* remplies)

- **OR** signifie qu'au moins une des conditions est remplie        
(*Condition1* OU *Condition2* remplie OU les 2 conditions remplies)

- **NOT** signifie l'inverse d'une condition

