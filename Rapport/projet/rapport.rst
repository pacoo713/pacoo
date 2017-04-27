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
|
|

----------------------------------------------------------

Introduction
============

|
|

|
<<<<<<< HEAD
| Ce document présente le rapport du projet train de l'UE *FPGA1*.
| Le projet a pour but de réaliser le circuit electrique d'une *centrale DCC* et de la 
| tester sur une vraie maquette. 
| Lors de ce Projet nous nous sommes servis du logiciel **Vivado** pour le developpement de la
| centrale ainsi que la carte **FPGA** ``Nexys 4DDR``.
| Lors de ce projet nous avons aussi decouvert le protocole DCC, que nous avons immplémenté.
=======
| Ce document prÃ©sente le rapport du projet train de l'UE *FPGA1*.
| Le projet a pour but de rÃ©aliser le circuit Ã©lÃ¨ctrique d'une *centrale DCC* et de la 
| tester sur une vraie maquette. Programmer avec diffÃ©rentes vitesses du train et d'utiliser les diffÃ©rents fonctions du train (klaxon,phares...). 
| Lors de ce Projet nous nous sommes servis du logiciel **Vivado** pour le developpement de la
| centrale ainsi que la carte **FPGA** ``Nexys 4DDR``.
| Lors de ce projet nous avons aussi decouvert le protocole DCC, que nous avons implÃ©mentÃ©.
>>>>>>> 006cd5cabf8203734394acbd2173cb797e6982c3
|

Ce projet ce decoupe en 2 étapes qui correspondent à 2 types de centrales2 :
 - une uniquement en ***vhdl***.
 - l'autre en ***vhdl*** ainsi qu'en ***C*** en utilisant le microblaze de la carte. 

bla bla...

Ce projet à été devellopé sous git :
 https://github.com/maximouth/Projet_FPGA

|
|
|
|
|
|
|
|

 

--------------------------------------------



I) Protocole DCC
================


|
<<<<<<< HEAD
| Le protocole DCC est un protocole standardisé qui permet de communiquer entre la carte 
| **FPGA** et les différents trains et équipements de voies.
| Il utilise une suite de commandes envoyées sur les rails jusqu'aux différents trains et 
| composants qui agissent en fonction de la commande qu'ils reÃ§oivent. La locomotive peut 
| recevoir énormément de commandes différentes, klaxon, annonces d'entrée de gare, phares... 
| (voir datasheet locomotive). Elles ne seront pas toutes implementées ici, mais pourront Ãªtre
| rajoutées ultérieurement. 
|
|


=======
| Le protocole DCC est un protocole standardisÃ© qui permet de communiquer
| entre la carte **FPGA** et les diffÃ©rents trains et
| Ã©quipements de voies.
| Il utilise une suite de commandes envoyÃ©es des trames (4 trames) sur les rails 
| jusqu'aux diffÃ©rents trains.
| La locomotive peut recevoir Ã©normÃ©ment de commandes diffÃ©rentes,
| klaxon, annonces d'entrÃ©e de gare, phares...(voir datasheet
| locomotive). Elles ne seront pas toutes implementÃ©es ici, mais
| pourront Ãªtre rajoutÃ©es ultÃ©rieurement. 
>>>>>>> 006cd5cabf8203734394acbd2173cb797e6982c3


.. image:: trame.png
   :scale: 250 %
   :alt: trame protocale DCC
   :align: center

|


Cette image represente une trame DCC et son contenu.
Chaque trame est composée de cette faÃ§on :
 - 14 *bit* à '1' *(preamble)*
 - 1 *octet* **d'adresse** 
 - 1 *octet* de **data**
 - 1 *octet de **CRC** *Xor* entre *adresse* et *data* *((epilogue))*

Chaque partie est séparée par un *bit* à '0'.

|
|
|
|
|
|
|
|
|
|
|
|
|
|
|
|
|
|
|

--------------------------------------------------------------------

|
|

II) Architecture
================

|

1) VHDL
#######

|

.. image:: archi_vhdl.png
   :scale: 250 %
   :alt: trame protocale DCC
   :align: center

|
|

| Nous avons commencé par créer une centrale DCC uniquement en version matérielle avec
| uniquement du VHDL. L'architecture réalisée est plutot simple et est composée de différents
| éléments que nous allons vous detailler plus loin.


|
|

2) VHDL & C
###########

|

.. image:: archi_mixe.png
   :scale: 250 %
   :alt: trame protocale DCC
   :align: center

|
|

| Nous avons modifié la première centrale matérielle pour utiliser le microblaze de la carte.
| Le microblaze sert à gerer les différents appuis sur les boutons de l'IHM.

|
|

---------------------------------------


III) Fonctions
==============

|

1) Clock Divider
################
<<<<<<< HEAD

|

.. code:: VHDL

 entity div_clock is
  Port (
    -- 100 MHz signla
    clk : in STD_LOGIC;
    -- 1 MHz signal
    div_clock : out STD_LOGIC);
 end div_clock;
	  
	  

.. image:: clock.png
   :scale: 250 %
   :alt: trame protocale DCC
   :align: center

|
|


| La carte nexys 4 DDR tourne à 100Mhz ce qui n'est pas pratique pour gerer des signaux en
| sortie qui doivent être en us.
| Pour simplifier le gestion du temps nous avons creer un diviseur d'horloge. Qui diminue
| la vitesse de 100 MHz à 1 MHz.
=======
Cette fonction permet de diviser le signal de la clock original de 100 Mhz et obtenir une frÃ©quence 1 Mhz
en sortie. Ce qui facilite l'utilisation du protocole DCC.
>>>>>>> 006cd5cabf8203734394acbd2173cb797e6982c3

2) Send_One
################
Cette fonction permet de crÃ©e le signal correspondant Ã  un bit Ã  1 qui constituer la trame Ã  envoyer. Le signal doit respecter les indications du protocole DCC (Implusion Ã  0 de 58 us puis impulsion Ã  1 de 58 us).

|

.. code:: VHDL

 entity send_one is
  Port (
    clk     : in  STD_LOGIC;
    start_1 : in  STD_LOGIC := '0';
    end_1   : out STD_LOGIC := '0';
    pulse_1 : out STD_LOGIC := '0'
    );      
 end send_one;


.. image:: send_one.png
   :scale: 250 %
   :alt: trame protocale DCC
   :align: center

|
|


| Ce petit module sert à envoyer un *'1'* en suivant le protocole **DCC**, c'est à dire envoyer un *'1'* 
| logique pendant **58** clock cycles suivit d'un *'0'* logique pendant **58** clock cycles.
| Il tourne à *1 Mhz* grâce au module ``clock_divider``.

3) Send_Zero
################
Cette fonction permet de crÃ©e le signal correspondant Ã  un bit Ã  0 qui constituer Ã©galement trame Ã  envoyer. Le signal doit respecter les indications du protocole DCC (Implusion Ã  0 de 100 us puis impulsion Ã  1 de 100us).

|

.. code:: VHDL

 entity send_zero is
  Port (
    clk     : in  STD_LOGIC;
    start_0 : in  STD_LOGIC := '0';
    end_0   : out STD_LOGIC := '0';
    pulse_0 : out STD_LOGIC := '0'
    );      
 end send_zero;
	  
.. image:: send_zero.png
   :scale: 250 %
   :alt: trame protocale DCC
   :align: center

|
|

| Ce petit module sert à envoyer un *'0'* en suivant le protocole **DCC**, c'est à dire envoyer un *'1'* 
| logique pendant **100** clock cycles suivit d'un *'0'* logique pendant **100** clock cycles.
| Il tourne à *1 Mhz* grâce au module ``clock_divider``.


4) Send_preamble
################
La trame est constistuÃ© aussi d'une suite de bits Ã  1 (14 bits). Nous allons donc rÃ©utiliser le code du Send_One afin de produire cette suite de bits Ã  1.

|

.. code:: VHDL

 entity send_preamble is
  Port (
    clk     : in  STD_LOGIC;
    start_p : in  STD_LOGIC := '0';
    end_p   : out STD_LOGIC := '0';
    pulse_p : out STD_LOGIC := '0'
    );      
 end send_preamble;
	  
	  
.. image:: send_preamble.png
   :scale: 250 %
   :alt: trame protocale DCC
   :align: center

|
|

| Ce module sert à envoyer un preambule en suivant le protocole **DCC**, c'est à dire envoyer 
| une suite de 14 *'1'*. Ce module se sert du petit module ``send_one``.
| Ce module attend de recevoir un signal **start_p** qui lui signal qu'il doit envoyer un preambule. 
| Il se sert d'un compteur initialisé à ``0`` qui sert à connaitre le nombre de *'1'* envoyé. 
| Il envoie  un **start_1** au module ``send_one`` et  attend de recevoir le signal  **end_1**
| pour incrementer le compteur.
| Une fois le preambule envoyé il renvoie le signal **end_p** qui signifie qu'il a fini.

5) Send_byte
################
Cette fonction permet de gÃ©rer les differents octet (adresse, donnÃ©e, contrÃ´le) donc de choisir le train, sa vitesse et la fonction utiliser.

|

.. code:: VHDL

 entity send_byte is
  Port (
    clk     : in  STD_LOGIC;
    start_b : in  STD_LOGIC := '0';
    byte    : in  Std_Logic_Vector (7 downto 0); 
    end_b   : out STD_LOGIC := '0';
    pulse_b : out STD_LOGIC := '0'
    );      
 end send_byte;

	  
.. image:: send_byte.png
   :scale: 250 %
   :alt: trame protocale DCC
   :align: center

|
|

| Ce module sert à envoyer un octet en suivant le protocole **DCC**, c'est à dire envoyer 
| une suite de 8 *'1'* ou *'0'* selon la valeur de l'octet en entrée. Ce module se sert des
| petits modules ``send_one``, et ``send_zero``.
| Ce module attend de recevoir un signal **start_b** qui lui signal qu'il doit envoyer un octet. 
| Il se sert d'un compteur initialisé à ``0`` qui sert à connaitre le nombre de *bit(s)* envoyés. 
| Il envoie  un **start_0/1** à l'un des deux sous module et  attend de recevoir le signal
| **end_0/1** avant d'envoyer le bit suivant et incrementer le compteur.
| Une fois l'octet envoyé il renvoie le signal **end_b** qui signifie qu'il a fini.


6) Sequencer
################
Cette fonction est dÃ©crit sous forme de machine Ã  Ã©tats, qui va gÃ©rer l'envoie des 4 trames (Idle, vitesse, fonction).


|

.. code:: VHDL

 entity sequencer is
  Port (
    clk       : in  STD_LOGIC;

    go        : in  STD_LOGIC := '0';
    
    addr      : in  Std_Logic_Vector (7 downto 0);
    feat      : in  Std_Logic_Vector (7 downto 0);
    speed     : in  Std_Logic_Vector (7 downto 0);
    which     : in  Std_Logic;
    idle      : in  Std_Logic;    

    done      : out Std_Logic;
    pulse     : out STD_LOGIC := '0'
    );      
 end sequencer;
   
	  
.. image:: sequencer.png
   :scale: 250 %
   :alt: trame protocale DCC
   :align: center

|
|

IV) IHM
=======

tuto explication

photo de l'interface

explicaton code ?

V) ImplÃ©mentation sur la maquette
=================================

explication comment interfacer interface et la centrale.
image oscilloscope
fonctionalitée implémenté
image maquette


VI) Microblaze
==============



VII) Conclusion
===============
