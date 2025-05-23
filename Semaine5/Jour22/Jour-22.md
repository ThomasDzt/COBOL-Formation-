# Objectifs journaliers MS COBOL P4


### Vendredi 23 Mai


## Jour 3 – Génération du rapport et finalisation

La dernière phase du projet consiste à produire un rapport formaté contenant les informations essentielles sur chaque étudiant : nom, prénom, âge, moyenne, et éventuellement les notes détaillées. Cette étape met en œuvre le verbe `STRING` pour créer une ligne de sortie structurée, puis son écriture dans un fichier texte. Il est également conseillé de tirer parti de l’instruction `COPY` pour organiser les définitions et traitements récurrents dans des modules partagés, ce qui facilite la maintenance et la lisibilité du code. Enfin, cette journée est consacrée à la documentation technique et à la validation complète du programme.

### Formatage et génération du fichier `output.dat`

* [ ] Utiliser `STRING` pour construire chaque ligne de sortie (250 caractères)
* [ ] Insérer une en-tête et un pied de page selon le modèle fourni
* [ ] Inclure dans chaque ligne : nom, prénom, âge, moyenne, et les notes par matière si disponible
* [ ] Veiller à l’alignement et à la lisibilité du contenu
* [ ] Écrire les lignes avec `WRITE REC-F-OUTPUT` dans le fichier de sortie

### Structuration du code avec `COPY`

* [ ] Créer un ou plusieurs fichiers `COPY` pour :

  * [ ] Les structures de données utilisées dans plusieurs parties du programme
  * [ ] Le formatage d’une ligne de rapport
  * [ ] Toute logique partagée entre plusieurs sections (ex. : calcul ou mise en forme)
* [ ] Intégrer les fichiers `COPY` dans les sections `WORKING-STORAGE`, `LINKAGE` ou `PROCEDURE DIVISION` selon leur usage
* [ ] S'assurer que ces inclusions améliorent la clarté sans complexifier inutilement le programme

### Débogage

* [ ] S'assurer que les fichiers `input-test1.dat` et `input-test1.dat` sont traités correctement par votre programme
* [ ] Vérifier que chaque ligne du fichier `output.dat` est bien formée
* [ ] Tester avec plusieurs cas : un seul étudiant, plusieurs cours, doublons de noms, etc.


### Documentation finale

* [ ] Rédiger une description globale du programme (lecture, traitement, génération du rapport)
* [ ] Documenter l’utilisation des instructions `STRING`, `ROUNDED`, `SORT`, `SEARCH`, `COPY`
* [ ] Expliquer les choix techniques (structure des données, tri, gestion des doublons)
* [ ] Ajouter des commentaires clairs dans le code source

### Finalisation

* [ ] Compiler et tester l’intégralité du programme
* [ ] Vérifier que tous les livrables sont prêts :

  * [ ] Fichier source `.cbl`
  * [ ] Fichier `output.dat`
  * [ ] Fichiers `COPY` utilisés
  * [ ] Documentation technique


* [ ] Livrer
