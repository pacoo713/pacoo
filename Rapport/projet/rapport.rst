.. footer:: page ###Page###

============================
Rapport de Projet TRAIN FPGA
============================

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
| Ce document présente le rapport du projet train de la matière FPGA.
Ce projet a pour but de réaliser le circuit electrique d'une centrale DCC et de la tester
sur une vraie maquette.Programmer la vitesse du train, utiliser les différentes fonctions disponibles(klaxonne,phare...)
| Lors de ce Projet nous avons utilisé le logiciel **Vivado** ainsi que la carte
|  **FPGA** ``Nexys 4DDR``.
ET nous avons devouvert le protocole DCC.

2 centrales :
 - vhdl only
 - vhdl & C 

bla bla...

tout à été devellopé sous git :
 https://github.com/maximouth/Projet_FPGA

I) Protocole DCC
&&&&&&&&&&&&&&&&

.. image:: trame.png
   :scale: 75 %
   :alt: trame protocale DCC
   :align: center


Le protocole est un protocole standardis\'e qui permet de communiquer
entre la carte~\emph{FPGA} et les diff\'erents trains et
équipements de voies.
Il utilise une suite de commandes envoy\'ees sur les rails
jusqu'aux diff\'erents trains et composants qui agissent en fonction de
la commande qu'ils reçoivent.
La locomotive peut recevoir \'enormément de commandes différentes,
klaxon, annonces d'entr\'ee de gare, phares...(voir datasheet
locomotive). Elles ne seront pas toutes implement\'ees ici, mais
pourront \^etre rajout\'ees ult\'erieurement. 


II) Architecture
&&&&&&&&&&&&&&&&

1) VHDL
#######

*schema architecture*

explication

2) VHDL & C
############

*schema architecture*
explication

III) Fonctions
&&&&&&&&&&&&&&

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
&&&&&&&

tuto explication

photo de l'interface

explicaton code ?

V) Implementation sur la maquette
&&&&&&&

explication comment interfacer interface et la centrale.
image oscilloscope
fonctionalitée implémenté
image maquette


VI) Microblaze
&&&&&&&&&&&&&&



VII) Conclusion
&&&&&&&&&&&&&&&
