# Notes IBM Z Xplore
**IBM Z ID: Z72248**
**IBM Z Password: OAK07SKY**

## VSC1

On se connecte sur Z pour écrire des applications. D'autres pour le support et les màj. 
ZOWE sert à gérer les différentes connexions au systeme IBM Z

IBM Z  Open Editor utile pour éditer les fichiers spécifiques à IBM Z platform

## Files1
Manipulation de fichiers et de sets de données (copie, suppression, rename, etc.)
Organisations des données afin de faire tourner les applications plus vite  

Concept similaire aux fichiers et dossiers informatiques.

--> Data sets et members mais attention différences

Dans les datas sets le nom contient des points 
--> SOMETHING.INPUT
Le point (.) représente des qualifiers pour classifier les données. Utilisé pour organiser les datas sets

1er type de data sets = PDS (Partitioned Data sets) dans lesquels on rajoute des members
Chaque ligne de members est référencée comme un "record".
- Equivalence : 
  - Members <--> Fichiers
  - Records <--> Lignes

Les records peuvent aller dans les SDS (Sequential Data Set) qui contiennent leur propre records.

Dans la section Data Sets je peux voir mes datas sets (données que je peux lire et éditer) et les datas sets publiques (en lecture uniquement).

Utilité des datas sets :

Les SDS délivrent le meilleur format d'accès aux données pour que la lecture des enregistrements dans ces données par les applications soit la plus rapide possible.

Les PDS permettent d'avoir accès aux members dans l'odre que l'on souhaite selon le besoin.

NB :

Une dataset contient un certain nombre d'attributs et ceux-ci peuvent être fixés de sorte à ce qu'on ait le meilleur rapport performance/sécurité/scalabilité.

Il faut savoir organiser ces données pour déterminer quel est le meilleur format pour les data sets (PDS, SDS, Member dans un PDS)

## JCL1

JCL : Job Control Language pour langage de contrôle des tâches.

(attention ce n'est pas non plus un langage de programmation)
--> Indique au système de IBM z/OS ce que je souahite faire et comment gérer les détails de cette tâche fournit suffisamment d'infos sur la tâche pour qu'elle soit exécutée exactement comme prévu.

Etapes du JCL :

- RUN THIS PROGRAM  <--> exécution du programme
- INPUT             <--> Où trouver les données d'entrée 
- OUTPUT            <--> Où placer la sortie de programme

JCL soumis à z/OS --> Sous-système d'entrée de tâches (JES) 

JES (Job Entry Subsystem) : 
- récupère les éléments nécessaires à l'exécution des tâches 
- Exécute les étapes décrites dans le JCL 
  
CC : Condition Code, s'il est à 0000 tout s'est exécuté sans problèmes
ABEND : Abnormal End

**Exemple plus parlant pour le JCL et le JES**

JCL = commande notée par le/la serveur/-euse

JES l'équipe en cuisine qui voit les commandes et décide de comment les gérer.


Sur des systèmes plus chargés il peut être nécessaire de prioriser certaines tâches comparée à d'autres

Joblog = ce qui apparait dans le job output 

--> Information décrivant comment la tâche a été exécutée

Pour les JCL, les statements qui définissent d'où viennent les données et où elles seront envoyées sont appelés **Data Definition** (DD statements).

Il y a :

- SYSPRINT : SDS pour des messages, un DD statement de sortie pour que le programme fasse des rapports de succès, d'échecs ou de progrès 
  
- SYSUT1 : définit la data set d'entrée, la "source". Cela peut être un SDS, un member dans un PDS,etc. --> d'où la donnée sera copiée
  
- SYSUT2 : définit la data set de sortie. Cela peut être un SDS, un member dans un PDS, etc. --> où la donnée du SYSUT1 sera copiée 
  
- SYSIN : définit la data set de contrôle (?)

**JCL2**

Compile et exécute un programme COBOL.

ddname = nom du fichier, nom utilisé par les programmes pour accéder aux données dans les datasets.
DSN = dataset : emplacement réel de la donnée
DISP = access (accès ?) ou disposition : décrit comment le programme accède aux datasets

2 steps pour ce JCL : compiler le code source en langage machine et exécuter le programme.

4 choses à mettre en place pour que les programmes z/OS marchent avec les datasets d'une tâche (job):

- La définition interne du fichier qui représente la structure de la donnée et le contenu que le programme va créer, lire, modifier ou supprimer --> défini dans le programme
  
- La dataset actuelle, utilisée par une exécution particulière du programme. À chaque fois que le programme est exécuté, il peut utiliser différentes datasets (tant que le format est correct pour le programme). 
--> C'est le nom indiqué par le **DSN=** que l'on peut voir comme paramètre de DD statement
  
- Un choix correct de disposition pour la dataset --> pour indiquer si elle doit être créée, supprimée, transmise
--> C'est le **DISP=** que l'on peut voir comme paramètre d'un DD statement

- un DD statement qui relie le fichier interne du programme à la dataset particulière --> doit coïncider avec le nom de la définition de fichier du programme et spécifier la dataset requise et la disposition


**JCL3**
Les données de toutes les DD du SYSUT1 sont définies "in-stream" (?) (DD* au lieu de DSN=)

Les paramètres **DISP** sont utilisés pour décrire comment le JCL devrait utiliser ou créer une dataset, et que faire avec après la tâche (job) ou jobstep 
--> 3 parties pour le paramètre DISP.

- Tout d'abord le statut :
    - NEW : Create a new data set 
    - SHR : réutilise une dataset existante et laisse d'autres personne l'utiliser
    - OLD : Réutilise une data set existante mais ne laisse pas d'autres personnes l'utiliser
    - MOD : Pour les SDS uniquement. Réutilise une dataset existante mais ajoute de nouveaux enregistrements au bas de celle-ci. Si aucune dataset n'existe alors cela en crée une.
  
- Le 2e champ du paramètre DISP décrit ce qu'il devrait arriver à la dataset dans le cas normal de complétion de la jobstep (étape de tâche ?) :
    - DELETE : Supprime complètement la dataset de l'espace de stockage
    - CATLG : Enregistre la dataset pour pouvoir l'utiliser une fois que la tâche est terminée
    - PASS : Une fois que l'étape est terminée, la garde pour que la prochaine étape puisse l'utiliser (?)
  
- Le 3e champ est ce qu'il devrait arriver à la dataset s'il y a échec de la jobstep

Le **DUMMY** dans les DD statements = "l'allocation du fichier est nécessaire mais elle n'est utilisée pour rien du tout donc c'est pas la peine"


## USS

**Shell** : une interface utilisée pour avoir une conversation avec le système. On entre qqch puis on appuie sur "entrée" et le système traite cette demande et renvoie qqch
Exemple ls pour avoir une liste de ce qui se trouve dans l'environnement donné

L'USS file system est hiérarchique, on a des fichiers et des dossiers qui peuvent être rangés dans des dossiers.  
Dans les termes UNIX : Dossiers <--> Directories
On se connecte à l'USS en utilisant une SSH (Secure Shell)
Dans l'USS, on entre son identifiant en minuscule mais même format pour le mdp

**USS = (UNIX System Services)** est un POSIX, une implémentation conforme d'un environnement UNIX dans z/OS qui permet une expérience semblable à UNIX tout en utilisant les même API que pour z/OS 
**POSIX = Portable Operating System Interface**  famille de standards qui maintient la compatibilité entre différents OS. Définit les API, les lignes de commandes et l'interface utilitaire pour la compatibilité logicielle.

la commande ssh zxxxxx@204.90.115.200 peut être interprétée comme suit : " utilise la commande ssh pour me connecter au système à distance en utilisant mon identifiant"



## CODE1
Du python pas grand-chose à noter...

## REXX1
REXX : Restructured Extended Executor, un langage de programmation connu pour sa simplicité, sa puissance et facilité relative d'utilisation.

CLI : Command Line Interface 
On utilise le ZOWE CLI qui sera installé sur notre ordinateur pour travailler sur z/OSMF qui tourne sur le mainframe

**TSO adress space key**
Z72248-207-aadiaaat 
zowe tso send as Z72248-278-aaekaaaw --data "exec 'Z72248.SOURCE(somerexx)'"

TSO : Time Sharing Option, une autre façon qu'a z/OS de permettre à beaucoup d'utilisateur d'accéder à des data sets, d'exécuter des programmes et d'examiner leur sortie. C'est la CLI de z/OS.

Address Space (as) : "ticket" nous laissant uiliser de la mémoire système Cela représente une énorme quantité de mémoire m^me si le système va toujours contrôler ce qui se trouve dans la mémoire interne, par rapport à ce qui est déplacé vers le disque.
L'endroit d'où le programme tire sa mémoire dépend de son importance, de comment il devrait être utilis et si il sera partagé avec d'autres programmes.

En résumé : on a interagi avec les programmes Rexx, lancé un adress space sur TSO tout à partir de la commande zowe


## WRAPUP
Les JCL et les data sets sont des parties uniques du système opérateur IBM z/OS qui le renforcent, le sécurisent.

Z Open Automation UTILITIES (ZOAU)

decho -a "This line goes at the bottom" 'Z72248.JCL3OUT'
la commande decho écrit du texte dans une dataset. -a signifie que le texte sera au bas de la dataset.S'il le -a n'était pas présent, le texte serait écri par-dessus le contenu existant dans la dataset. 
--> il s'agit d'une alternative au fait d'ouvrir la dataset et de simplement ajouter le texte en bas.