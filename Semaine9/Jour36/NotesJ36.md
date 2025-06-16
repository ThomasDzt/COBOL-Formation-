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