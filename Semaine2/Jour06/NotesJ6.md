# Jour 06 - Mardi 29 Avril 2025


## Les boucles en COBOL 

### PERFORM n TIMES 

Permet d'effectuer une boucle qui va exécuter un bloc d'instructions un nombre fixe de fois.     
Exemple :

```cobol
 PERFORM 5 TIMES 
    DISPLAY "Bonjour"
 END-PERFORM. 
```

Cette boucle affiche 5 fois "Bonjour".

### PERFORM UNTIL 

Boucle qui exécute un bloc d'instructions jusqu'à ce qu'une condition soit remplie (ou tant qu'elle n'est pas remplie).

Exemple :
```cobol
PERFORM UNTIL WS-NBR = 0
    DISPLAY "Veuillez saisir un nombre : "
    ACCEPT WS-NBR 
END-PERFORM.
```
Cette boucle est effective tant que l'utilisateur ne saisit pas 0.


### PERFORM VARYING...FROM...BY...UNTIL...

Exécute un bloc d'instructions avec une variable de contrôle qui change à chaque itération (on définit un *pas*), et dont on définit la valeur initiale. Tout comme le PERFORM UNTIL, la boucle se poursuit tant que la condition n'est pas remplie. Idéal pour parcourir des tableaux.

Exemple :

```cobol
PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 10
    DISPLAY WS-VALEUR(WS-IDX) 
END-PERFORM.
```
Cette boucle se poursuit en faisant varier un index *WS-IDX* à partir de 1 avec un pas de 1 jusqu'à ce que ce dernier soit strictement supérieur à 10.
On parcourt ainsi les lignes 1 à 10 d'un tableau qui vont être affichées.

### PERFORM...THRU...

Permet d'exécuter une série de paragraphes dans l'ordre.    

Exemple : 

```cobol 
PERFORM 0100-SAISIE-NOMBRE-DEB
   THRU 0100-SAISIE-NOMBRE-FIN.
    

******************************************************************
*                         PARAGRAPHES                            *
******************************************************************
       
       0100-SAISIE-NOMBRE-DEB.

           DISPLAY "Entrez un nombre : ".
           ACCEPT WS-NBR.
         
           EXIT.
       
       0100-SAISIE-NOMBRE-FIN.

```
On pourrait aussi parcourir plusieurs séries de paragraphes (ex: PERFORM 0100-PARAGRAPHE1-DEB THRU 0200-PARAGRAPHE2-FIN).


**NB :** pour les PERFORM UNTIL ou PERFORM VARYING, on peut associer les différents conditions (comparaisons et opérateurs logiques)

