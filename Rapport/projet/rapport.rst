.. footer:: page ###Page###

================================
Rapport de Projet **Train** FPGA
================================

-----------------------------
FPGA 1 Systèmes programmables
-----------------------------

|
|
|
|

*Ayrault Maxime* **3203694** - *Nguyen Gabriel* **3200625**

|
|
|
|
|

----------------------------------------------------------

Introduction
============


|
| Ce document présente le rapport du projet train de l'UE *FPGA1*.
| Le projet a pour but de réaliser le circuit élèctrique d'une *centrale DCC* et de la 
| tester sur une vraie maquette. Programmer avec différentes vitesses du train et d'utiliser les différents fonctions du train (klaxon,phares...). 
| Lors de ce Projet nous nous sommes servis du logiciel **Vivado** pour le developpement de la
| centrale ainsi que la carte **FPGA** ``Nexys 4DDR``.
| Lors de ce projet nous avons aussi decouvert le protocole DCC, que nous avons implémenté.
|

Ce projet ce decoupe en 2 étapes qui correspondent à 2 types de centrales2 :
 - une uniquement en ***vhdl***.
 - l'autre en ***vhdl*** ainsi qu'en ***C*** en utilisant le microblaze de la carte. 

bla bla...

Ce projet à été devellopé sous git :
 https://github.com/maximouth/Projet_FPGA


--------------------------------------------



I) Protocole DCC
================


|
| Le protocole DCC est un protocole standardisé qui permet de communiquer
| entre la carte **FPGA** et les différents trains et
| équipements de voies.
| Il utilise une suite de commandes envoyées des trames (4 trames) sur les rails 
| jusqu'aux différents trains.
| La locomotive peut recevoir énormément de commandes différentes,
| klaxon, annonces d'entrée de gare, phares...(voir datasheet
| locomotive). Elles ne seront pas toutes implementées ici, mais
| pourront être rajoutées ultérieurement. 


.. image:: trame.png
   :scale: 75 %
   :alt: trame protocale DCC
   :align: center


Cette image represente une trame DCC et son contenu.
Chaque trame est composée de cette façon :
 - 14 *bit* à '1' *(preamble)*
 - 1 *octet* **d'adresse** 
 - 1 *octet* de **data**
 - 1 *octet de **CRC** (*Xor* entre *adresse* et *data*) *((epilogue))*

Chaque partie est séparée par un *bit* à '0'.

|
|

II) Architecture
================

1) VHDL
#######

*schema architecture*

explication
Nous avons commencé par créer une centrale DCC uniquement en version matérielle avec uniquement du VHDL
L'architecture réalisée est plutot simple et est composée de différents éléments que nous allons vous detailler plus loin.

2) VHDL & C
###########

*schema architecture*
explication

III) Fonctions
==============

se que ca fait + chronogramme

1) Clock Divider
################
Cette fonction permet de diviser le signal de la clock original de 100 Mhz et obtenir une fréquence 1 Mhz
en sortie. Ce qui facilite l'utilisation du protocole DCC.

2) Send_One
################
Cette fonction permet de crée le signal correspondant à un bit à 1 qui constituer la trame à envoyer. Le signal doit respecter les indications du protocole DCC (Implusion à 0 de 58 us puis impulsion à 1 de 58 us).

3) Send_Zero
################
Cette fonction permet de crée le signal correspondant à un bit à 0 qui constituer également trame à envoyer. Le signal doit respecter les indications du protocole DCC (Implusion à 0 de 100 us puis impulsion à 1 de 100us).

4) Send_preamble
################
La trame est constistué aussi d'une suite de bits à 1 (14 bits). Nous allons donc réutiliser le code du Send_One afin de produire cette suite de bits à 1.

5) Send_byte
################
Cette fonction permet de gérer les differents octet (adresse, donnée, contrôle) donc de choisir le train, sa vitesse et la fonction utiliser.

6) Sequencer
################
Cette fonction est décrit sous forme de machine à états, qui va gérer l'envoie des 4 trames (Idle, vitesse, fonction).


IV) IHM
=======

tuto explication

photo de l'interface

explicaton code ?

V) Implémentation sur la maquette
=================================

explication comment interfacer interface et la centrale.
image oscilloscope
fonctionalitée implémenté
image maquette


VI) Microblaze
==============



VII) Conclusion
===============
