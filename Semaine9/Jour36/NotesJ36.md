# Jour 36 - Lundi 16 Juin 2025

Grégory va nous parler de MVS TSO ISPF aujourd'hui
Demain JCL

Et après gestion de projet

## MVS
Petite ressource pour les MVS : https://www.lacommunauteducobol.com/mvs/

**MVS (Multiple Virtual Storage)** = Système d'exploitation (dev par IBM en 1970)--> rapidité de calcul de processeur, taille de mémoire, perf des périphériques
Se calcule en MIPS (million d'instructions par seconde). 
z/OS est l'évolution de MVS (MVS --> OS/390--> z/OS) 
MVS permet l'exécution simultanée de plusieurs jobs 

**Composants de MVS** : JES1 et JES2, TSO, ISPF (s'émule)

Connexion à TSO puis commande ISPF pour arriver dessus --> ISPF se retrouve chez la plupart des clients
Catalogues référencent les datasets
Datasets : 2 types SDS (séquentielles, ligne par ligne) ou PDS (PDS peuvent être comparés à un dossier sur windows, par exemple la bibliothèque)

SYSOUT : sortie d'imprimante à l'époque, maintenant à l'écran (ce qui affiche le programme)
SYSIN : paramètres/données d'entrée pour les JCL 
LOADLIB  : bibliothèque de chargement des programmes compilés (programme en langage machine)
WORK : bibliothèque de fichiers temporaires (fichier dont on a besoin lors de l'exécution du p)
VSAM (Virtual Storage Access Method) : fichier avec accès direct. Peut être apparenté à une base de donnée (BDD). Accès direct indexé

ISPF (Interface d'édition et de gestion de fichiers)
SDSF : permet le suivi des jobs batch (voir JCL)

Dans les JCL on utilise des prog créés par IBM, notamment IDCAMS, IEFBR14

IDCAMS : utilitaire pour la gestion des fichiers VSAM
IEFBR14 : programme "vide" pour tester un JCL 

**A retenir:**
MVS : colonne vertébrale des environnements COBOL/JCL

TSO communique avec MVS et ISPF avec TSO (**MVS--> TSO--> ISPF**)


## TSO

listcat pour lister tous les catalogues

help pour afficher toutes les commandes que l'on peut faire avec la description

Ressource pour le TSO: https://www.lacommunauteducobol.com/mainframe/tso-ispf/

**TSO (Time Sharing Option)**: environnement de travail interactif en lignes de commande. Permet à plusieurs utilisateurs de travailler simultanément. Est utilisé avec ISPF.
- Permet de soumettre des jobs JCL
- Permet de créer, éditer et gérer des fichiers 
- Permet d'accès aux programmes (utilitaires)
- Permet d'exécuter des commandes systèmes

TSO s'exécute via un émulateur 3270
On accède à ISPF via la commande "ispf"

**Commandes TSO**:
- SUBMIT : soumettre un job
- LISTCAT : permet de lister un dataset catalogué
- DELETE : supprimer un dataset
- ALLOCATE : créer un nouveau dataset 
- RENAME : renommer un fichier
- SEND : envoyer un message à un utilisateur
- =X ou logoff pour quitter la session
- help aide sur des commandes TSO
- PROFILE : paramètres utilisateur

Messages d'erreur et message système :

Problème de syntaxe, allocation de fichier possible.

--> ABEND (abnormal end)

ISPF : parcourir le catalogue, soumettre les jobs

https://www.lacommunauteducobol.com/abend/#:~:text=En%20informatique%2C%20un%20abend%20ou,%2F360%20et%20z%2FOS.


**ISPF Primary Option Menu**
**Exercice 1**

- 0 Settings 
- 1 View : pour afficher les datas en source
- 2 Edit : Créer ou changer de data source
- 3 Utilities : pour lancer les fonctions utilitaires 
    - 1  Library  
    - 2  Data Set
    - 3  Move/Copy
    - 4  DSlist
    - 5  Reset
    - 6  Hardcopy
    - 8  Outlist
    - 9  Commands
    - 11 Format  
    - 12 SuperC
    - 13 SuperCE
    - 14 Search-For
    - 15 Search-ForE
    - 16 Tables
- 4 Foreground : Interactive langauge processing
- 5 Batch : pour soumettre des jobs
- 6 Command : pour entrer les commandes TSO ou Workstation


Bonus : 
J'ai fait 6 --> PROFILE --> Entrée et voilà 


**Exercice 2**

3.4 --> DSlist 
J'ai entré USERID.* dans DSName et j'obtiens la liste suivante :

- USERID.INPUT             
- USERID.JCL               
- USERID.JCL3OUT           
- USERID.LOAD              
- USERID.OUTPUT            
- USERID.SOURCE            
- USERID.SPFLOG1.LIST      
- USERID.S0W1.ISPF.ISPPROF 
- USERID.S0W1.SPFLOG1.LIST 


Bonus : 

Dans la DSlist j'ai entré SORT CREATED pour trier par date et SORT NAME pour trier par nom.

Voir : https://www.ibm.com/docs/en/zos/2.4.0?topic=commands-sort-command


**Exercice 3**

Quand je fais 3.2 j'arrive dans la section DATA SET où je dois renseigner le DSName puis entrer A dans la ligne de commande pour créer le dataset.

Ensuite les paramètres LRECL, RECFM, BLKSIZE correspondent respectivement au record length, record format et au block size.

Il faut aussi choisir le type de dataset. Ici on veut un PDS donc on va entrer "PDS". Cependant cela crée un fichier alors que nous voulons une "bibliothèque". Il faut donc entrer "LIBRARY".

On peut vérifier les datasets créés à l'aide de la section 3.4 (DSlist). Une fois l'USERID.* spécifié comme liste, je peux entrer différentes commandes devant le nom des datasets (dans la colonne command) : V pour View, i pour Info, D pour delete.


**Exercice 4**

J'avais 2 colonnes de numéros comme suit:

000100 000100 IDENTIFICATION DIVISION.
000200 000200 PROGRAM-ID. HELLOCOB.

(Infos de chatGPT)
Le premier 000100 est le numéro de séquence COBOL (dans le fichier)

Le deuxième 000100 est l'indicateur de ligne de l'éditeur ISPF (non stocké, pour t’aider à naviguer)

Ici je peux utiliser plusieurs options :

- RESET dans la commande ISPF pour masquer temporairement les messages en rouge

- NUM OFF pour désactiver l’affichage du numéro ISPF à gauche (mais pas celui dans le fichier)

- NUM ON pour les remettre


**Exercice 5**

Pour copier un membre entre des datasets, j'ai ouvert le menu 3.3 (Move/Copy).
Ensuite j'ai eu à remplir la section "FROM dataset" :

Project : mon USERID
Group : SOURCE
Type  : COBOL
Member: HELLOCOB (le membre à copier)


Puis la section "TO" qui est donc USERID.SOURCE.COPIE
**Bonus**

J'ai copié le JCL1 de mon dataset USERID.JCL dans mon dataset USERID.JCL.LIB


Cependant mes datasets n'étaient pas "catalogués" (?)

Du coup j'ai dû entrer dans la partie "FROM OTHER PDS/SDS" :
USERID.JCL

Et dans la section "TO" :

Project : mon USERID
Group : JCL
Type  : LIB
Member: JCL1

























