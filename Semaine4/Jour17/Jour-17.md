# Objectifs journaliers MS COBOL P4

### Vendredi 16 Mai

## Définitions clés

* **Curseur** : Pointeur qui indique la position actuelle dans le fichier. Il permet de lire ou manipuler les enregistrements à partir de cette position.
* **Enregistrement** : Ensemble d’informations stockées sous forme d’une ligne dans un fichier. Chaque enregistrement correspond à une unité de données, comme un client ou une transaction.
* **Clé** : Identifiant unique pour chaque enregistrement dans un fichier indexé. C'est un champ (ou un ensemble de champs) qui permet d'accéder rapidement à un enregistrement spécifique.
* `RECORD KEY` : Le champ ou l'ensemble de champs qui sert de clé principale pour un fichier indexé. C'est le champ sur lequel l'indexation est effectuée, et chaque valeur de RECORD KEY doit être unique pour chaque enregistrement. Par exemple, dans un fichier de clients, la clé pourrait être le numéro de client.
---

## Introduction aux fichiers indexés

### Comprendre `ORGANIZATION IS INDEXED` et `ACCESS MODE`

* **`ORGANIZATION IS INDEXED`** : Structure le fichier avec un index pour un accès rapide par clé.

```cobol
SELECT fichier-client ASSIGN TO "client.dat"
    ORGANIZATION IS INDEXED
    ACCESS MODE IS DYNAMIC
    RECORD KEY IS cle-client.
```

* **`ACCESS MODE`** : Définit comment le fichier est lu :

  * `SEQUENTIAL` : lecture en ordre
  * `DYNAMIC` : bascule entre lecture séquentielle et directe

```cobol
ACCESS MODE IS SEQUENTIAL.  
* ou  
ACCESS MODE IS DYNAMIC.
```

* **`RECORD KEY`** : Champ unique identifiant chaque enregistrement.

```cobol
RECORD KEY IS cle-client.
```

---

## Lecture et navigation dans un fichier indexé

### Instructions principales : `READ`, `START`, `READ NEXT`, `READ PREVIOUS`

* **`READ` (direct)** : lit un enregistrement spécifique via la clé

```cobol
READ fichier-client 
    KEY IS cle-client 
    INVALID KEY DISPLAY "Client non trouvé".
```

* **`READ NEXT` / `READ PREVIOUS`** : pour lire séquentiellement

```cobol
READ fichier-client NEXT
    AT END DISPLAY "Fin du fichier".

READ fichier-client PREVIOUS
    AT END DISPLAY "Début du fichier".
```

* **`START`** : positionne le curseur sur un enregistrement donné, utile avant `READ NEXT`

```cobol
START fichier-client KEY >= cle-recherche
    INVALID KEY DISPLAY "Clé non trouvée".
```

---

## Mise à jour et suppression

* **`REWRITE`** : remplace un enregistrement existant (après un `READ`)

```cobol
REWRITE enreg-client
    INVALID KEY DISPLAY "Erreur modification".
```

* **`DELETE`** : supprime un enregistrement spécifique

```cobol
DELETE fichier-client
    INVALID KEY DISPLAY "Erreur suppression".
```

---

## Comparaison accès séquentiel / direct

* **Accès direct** : lecture immédiate avec la clé

```cobol
READ fichier-client KEY IS cle-client.
```

* **Accès séquentiel** : parcours en boucle avec `READ NEXT`

```cobol
PERFORM UNTIL fin-fichier
    READ fichier-client NEXT
        AT END MOVE 'OUI' TO fin-fichier
    END-READ
    DISPLAY enreg-client
END-PERFORM.
```

---

## À ajouter dans la cheat sheet

* `START`, `READ`, `READ NEXT`, `REWRITE`, `DELETE`

---
