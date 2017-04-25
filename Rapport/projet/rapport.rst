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
| Le projet a pour but de réaliser le circuit electrique d'une *centrale DCC* et de la 
| tester sur une vraie maquette. 
| Lors de ce Projet nous nous sommes servis du logiciel **Vivado** pour le developpement de la
| centrale ainsi que la carte **FPGA** ``Nexys 4DDR``.
| Lors de ce projet nous avons aussi decouvert le protocole DCC, que nous avons immplémenté.
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
| Il utilise une suite de commandes envoyées sur les rails
| jusqu'aux différents trains et composants qui agissent en fonction de
| la commande qu'ils reçoivent.
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


2) Send_One
################

3) Send_Zero
################

4) Send_preamble
################

5) Send_byte
################

6) Sequencer
################

IV) IHM
=======

tuto explication

photo de l'interface

explicaton code ?

V) Implementation sur la maquette
=================================

explication comment interfacer interface et la centrale.
image oscilloscope
fonctionalitée implémenté
image maquette


VI) Microblaze
==============



VII) Conclusion
===============
