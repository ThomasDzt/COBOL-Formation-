# Jour 37 - Mardi 17 Juin 2025

## JCL
Objectifs :
- Structure de job
- Savoir ecrire et modif script JCL

JCL c'est quoi : 
Langage de commande système utilisé pour soumettre des travaux.
Définit quel programme exécuter

Différentes cartes JCL (voir daily)


## Exercices

**Exercice 1**

Mon JCL :
<pre>
//TESTJOB1    JOB 'TEST', MSGCLASS=X, CLASS=A, MSGLEVEL=(1,1), 
//            NOTIFY=&SYSUID
//STEP1       EXEC PGM=IEFBR14 
// 
</pre>

Au début je n'avais pas indenté le NOTIFY ce qui m'a causé une erreur à l'exécution du job (en effet il le comprenait comme un step alors que j'avais la virgule à la ligne d'avant qui signifiait que la ligne NOTIFY en était la suite).
Note à moi-même : Le nom des cartes ne doit pas dépasser 8 caractères, le JOB est une nomenclature signifiant qu'on désigne un job et les '' désignent un commentaire (pour se rappeler ce que fait le job).


**Exercice 2**
<pre>
Mon JCL :
//TESTJOB2  JOB 'EXO2',MSGCLASS=X,CLASS=A,MSGLEVEL=(1,1),NOTIFY=&SYSUID
//STEP1     EXEC PGM=IEFBR14 
//TEMPO     DD DSN=&&MONFIC,DISP=(NEW,PASS), 
//             UNIT=SYSDA,SPACE=(TRK,(1,1)) 
</pre>

J'ai eu plusieurs problèmes pour cet exercice. Tout d'abord, j'avais des données dans ma colonne 72 (mon NOTIFY=&SYSUID allait jusque là), ce qu'on ne veut pas car cela ne le comprenait pas et je ne recevais pas de message à la soumission du job.
Ensuite, je n'avais pas mis de nom de job et du coup cela me le demandait à chaque fois lors de la soumission. Lorsque je l'ai rajouté, le nom du job était trop espacé par rapport au JOB statement (il faut juste un espace entre les 2.) Enfin, j'ai eu la même erreur pour mes lignes 3 et 4, j'avais respectivement les erreurs `EXPECTED CONTINUATION NOT RECEIVED` et `UNIDENTIFIED OPERATION FIELD`. J'avais encore trop d'espace entre mon DD statement et mon DSN (ainsi que mon UNIT)       

**A retenir: Il ne faut qu'UN espace entre mes statements et ce qui suit !**





**Exercice 3**

<pre>
Mon JCL:
//TESTJOB3  JOB 'EXO3',MSGCLASS=X,CLASS=A,MSGLEVEL=(1,1),NOTIFY=&SYSUID
//STEP1     EXEC PGM=IEFBR14 
//PERMAFIC  DD DSN=Z72248.DATA.FICHIER1,DISP=(NEW,CATLG,DELETE), 
//             SPACE=(CYL,(1,1)),UNIT=SYSDA, 
//             DCB=(RECFM=FB,LRECL=80,BLKSIZE=800) 
</pre>

Au début j'avais mis un espace entre la virgule après mon DSN et le DISP et j'avais un RC (Return Code) de 00 cependant mon fichier1 n'était pas créé. Il fallait donc retirer cet espace.

**A retenir: Il ne faut PAS d'espace entre ce qui suit mes statements !**



**Exercice 4**

<pre>
Mon JCL: 
//TESTJOB4  JOB 'EXO4',MSGCLASS=X,CLASS=A,MSGLEVEL=(1,1),NOTIFY=&SYSUID 
//STEP1     EXEC PGM=IEBGENER 
//SYSIN     DD DUMMY 
//SYSPRINT  DD SYSOUT=* 
//SYSUT1    DD * 
CECI EST UN TEST D'IMPRESSION JCL 
/* 
//SYSUT2    DD SYSOUT=*,DCB=(RECFM=FB,LRECL=80,BLKSIZE=800) 
// 
</pre>

Apparemment il y avait un problème en utilisant le programme IEFBR14 donc on a tous utilisé l'utilitaire IEBGENER. Cependant celui-ci nécessite des cartes spécifiques (voir le lien suivant :https://www.ibm.com/docs/en/zos-basic-skills?topic=utilities-iebgener-utility-generate-copy-sequential-data-set).

En SYSIN on insère des paramètres de contrôle. Cependant ce programme n'en requiert pas donc on lui met un DD DUMMY à la place.

En SYSPRINT on met DD SYSOUT=* pour préciser où se fera l'impression, l'astérisque correspond à ce qui a été précisé dans le MSGCLASS dans la carte JOB.

SYSUT1 correspond à l'input, là où je vais entrer le message voulu.


On le copie en SYSUT2, à la même destination que le SYSPRINT en précisant le format de la sortie avec le DCB.



**Exercice 5**

<pre>
Mon JCL :
 //TESTJOB5  JOB 'EXO5',MSGCLASS=X,CLASS=A,MSGLEVEL=(1,1),NOTIFY=&SYSUID 
 //STEP1     EXEC PGM=IEFBR14 
 //TEMPOFIC  DD DSN=&&FICTMP,DISP=(NEW,PASS), 
 //             UNIT=SYSDA,SPACE=(TRK,(1,1)) 
 //STEP2     EXEC PGM=IEFBR14 
 //TEMPOFI2  DD DSN=*.STEP1.TEMPOFIC,DISP=SHR 
</pre>

Ici je crée d'abord le fichier temporaire à l'étape 1 comme dans l'exercice 2. 


