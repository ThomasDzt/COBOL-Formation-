DROVoici la version réécrite **sans émoticônes** et avec une structure claire utilisant des **\[ ]** pour cocher les étapes réalisées.

---

# Objectifs journaliers – MS COBOL P4

**Date : Mardi 27 Mai 2025**

---

## Définitions clés

* [ ] **CREATE TABLE** : Instruction SQL utilisée pour définir une nouvelle table dans une base de données.
* [ ] **INSERT INTO** : Instruction SQL utilisée pour insérer des lignes dans une table.
* [ ] **SQLSTATE / SQLCODE** : Codes de retour SQL utilisés pour la gestion d’erreurs. `SQLCODE = 0` indique un succès.
* [ ] **OCESQL** : Extension pour GnuCOBOL permettant l'exécution de requêtes SQL dans du code COBOL via précompilation.
* [ ] **COPYBOOK** : Fichier COBOL contenant des structures de données réutilisables (comme `SQLCA`).
* [ ] **SQLCA (SQL Communication Area)** : Structure standard COBOL utilisée pour le retour des requêtes SQL (ex. : `SQLCODE`, `SQLSTATE`), incluse via un `COPYBOOK`.

---

## Objectifs pédagogiques

* [ ] Comprendre la structure d’une table PostgreSQL.
* [ ] Créer une table `clients` via `psql`.
* [ ] Écrire un programme COBOL-SQL pour insérer des données dans la table `clients`.
* [ ] Utiliser les instructions `ACCEPT`, `EXEC SQL`, et gérer les erreurs via `SQLCODE`.
* [ ] Comprendre l’utilisation d’OCESQL et de SQLCA dans un programme COBOL.
* [ ] Rédiger ou compléter une cheat sheet récapitulative.

---

## Exercices pratiques

### 1. Créer la base de données et la table `clients` via `psql`

**Objectif :** Initialiser PostgreSQL avec une base `testdb` et une table `clients`.

**Commandes à exécuter :**

```bash
psql -U postgres
```

```sql
CREATE DATABASE testdb;
\c testdb

CREATE TABLE clients (
    id SERIAL PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    prenom VARCHAR(100) NOT NULL,
    email VARCHAR(100)
);

\dt
SELECT * FROM clients;
```

---

### 2. Écrire un programme COBOL-SQL pour insérer des données

**Objectif :** Demander à l’utilisateur des informations via `ACCEPT`, et les insérer dans la table `clients`.

```cobol
       IDENTIFICATION DIVISION.
       PROGRAM-ID. INSERT-CLIENT.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

       EXEC SQL BEGIN DECLARE SECTION END-EXEC.
       01  CLIENT-NOM     PIC X(100).
       01  CLIENT-PRENOM  PIC X(100).
       01  CLIENT-EMAIL   PIC X(100).
       01  USERNAME       PIC X(30) VALUE "cobol".
       01  PASSWD         PIC X(30) VALUE "mdp".
       01  DBNAME         PIC X(10) VALUE "testdb".
       EXEC SQL END DECLARE SECTION END-EXEC.

       EXEC SQL INCLUDE SQLCA END-EXEC.

       PROCEDURE DIVISION.
       DISPLAY "Connexion à la base de données...".
       EXEC SQL
            CONNECT :USERNAME IDENTIFIED BY :PASSWD USING :DBNAME
       END-EXEC.
       IF SQLCODE NOT = 0
           DISPLAY "Erreur de connexion SQLCODE: " SQLCODE
           STOP RUN
       END-IF.

       DISPLAY "Entrez le nom du client : ".
       ACCEPT CLIENT-NOM.
       DISPLAY "Entrez le prénom du client : ".
       ACCEPT CLIENT-PRENOM.
       DISPLAY "Entrez l'email du client : ".
       ACCEPT CLIENT-EMAIL.

       EXEC SQL
            INSERT INTO clients (nom, prenom, email)
            VALUES (:CLIENT-NOM, :CLIENT-PRENOM, :CLIENT-EMAIL)
       END-EXEC.
       IF SQLCODE = 0
           DISPLAY "Insertion réussie."
       ELSE
           DISPLAY "Erreur d'insertion SQLCODE: " SQLCODE
       END-IF.

       EXEC SQL COMMIT END-EXEC.
       STOP RUN.
```

---

### 3. Compiler et exécuter le programme

**Étapes :**

* [ ] Précompiler avec OCESQL :

```bash
ocesql insert_client.cbl insert_client.cob
```

* [ ] Compiler avec GnuCOBOL :

```bash
cobc -x -locesql -o run insert_client.cob
```

* [ ] Exécuter :

```bash
./run
```

---

### 4. Insérer 3 clients et vérifier via `psql`

* [ ] Exécuter 3 fois le programme.
* [ ] Vérifier les données insérées dans `psql` :

```sql
\c testdb
SELECT * FROM clients;
```

**Résultat attendu :**

```
 id |  nom   | prenom |          email
----+--------+--------+--------------------------
  1 | Dupont | Jean   | jean.dupont@example.com
  2 | Martin | Claire | claire.martin@example.com
  3 | Dubois | Paul   | paul.dubois@example.com
```

---


### 4. Écrire un second programme COBOL-SQL pour insérer des données 

* [ ] Créer une table `utilisateur` via `psql` comportant les données suivantes : le nom, le prenom, l'age, le numéro de téléphone de 10 chiffres.
* [ ] Écrire un programme COBOL-SQL pour insérer des données dans la table `clients`.
* [ ] Utiliser les instructions `ACCEPT`, `EXEC SQL`, et gérer les erreurs via `SQLCODE`.
* [ ] Comprendre l’utilisation d’OCESQL et de SQLCA dans un programme COBOL.


### 5. Compléter la cheat sheet

**Structure de la table `clients` :**

* id : SERIAL PRIMARY KEY
* nom : VARCHAR(100) NOT NULL
* prenom : VARCHAR(100) NOT NULL
* email : VARCHAR(100)

**Commandes utiles PostgreSQL :**

* Créer une base : `CREATE DATABASE testdb;`
* Créer une table : `CREATE TABLE clients (...);`
* Afficher les tables : `\dt`
* Voir les données : `SELECT * FROM clients;`

**Instructions COBOL-SQL :**

* Connexion :

```cobol
EXEC SQL CONNECT :USERNAME IDENTIFIED BY :PASSWD USING :DBNAME END-EXEC
```

* Insertion :

```cobol
EXEC SQL INSERT INTO clients (...) VALUES (...) END-EXEC
```

* Gestion des erreurs :

```cobol
IF SQLCODE NOT = 0 THEN afficher SQLCODE
```

---

## Compilation et dépannage

**Problèmes fréquents et solutions :**

*  `undefined reference to log10` :

```bash
export COB_LDFLAGS="-Wl,--no-as-needed -lm"
```

*  `authentication failed` :
  Vérifier la configuration `pg_hba.conf` et l’authentification (utiliser `md5` ou `scram-sha-256`).

*  `libocesql.so not found` :
  S’assurer que le chemin `/usr/local/lib` est bien dans la variable `LD_LIBRARY_PATH`.

---

## Notes complémentaires

* Le fichier `SQLCA.CPY` est généralement situé dans :
  `/usr/local/share/gnucobol/copy/SQLCA.CPY`

* L’utilisation de `COPYBOOKS` permet de centraliser les définitions standard (comme `SQLCA`) dans des fichiers réutilisables.

---
