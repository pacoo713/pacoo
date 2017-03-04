GHDL=ghdl
all : send_oneTB send_zeroTB send_preambleTB send_byteTB sequencerTB

# compil send_one
send_one.o : send_one.vhdl
	${GHDL} -a -v send_one.vhdl

send_oneTB.o : ../simul/send_oneTB.vhdl send_one.o
	${GHDL} -a -v ../simul/send_oneTB.vhdl 

send_oneTB : send_oneTB.o
	${GHDL} -e -v send_oneTB
	${GHDL} -r send_oneTB --vcd=send_one.vcd


# compil send_zero
send_zero.o : send_zero.vhdl
	${GHDL} -a -v send_zero.vhdl

send_zeroTB.o : ../simul/send_zeroTB.vhdl send_zero.o
	${GHDL} -a -v ../simul/send_zeroTB.vhdl 

send_zeroTB : send_zeroTB.o
	${GHDL} -e -v send_zeroTB
	${GHDL} -r send_zeroTB --vcd=send_zero.vcd

# compil send_preamble
send_preamble.o : send_preamble.vhdl
	${GHDL} -a -v send_preamble.vhdl

send_preambleTB.o : ../simul/send_preambleTB.vhdl send_preamble.o
	${GHDL} -a -v ../simul/send_preambleTB.vhdl 

send_preambleTB : send_preambleTB.o
	${GHDL} -e -v send_preambleTB
	${GHDL} -r send_preambleTB --vcd=send_preamble.vcd


# compil send_byte
send_byte.o : send_byte.vhdl
	${GHDL} -a -v send_byte.vhdl

send_byteTB.o : ../simul/send_byteTB.vhdl send_byte.o
	${GHDL} -a -v ../simul/send_byteTB.vhdl 

send_byteTB : send_byteTB.o
	${GHDL} -e -v send_byteTB
	${GHDL} -r send_byteTB --vcd=send_byte.vcd

# compil sequencer
sequencer.o : sequencer.vhdl
	${GHDL} -a -v sequencer.vhdl

sequencerTB.o : ../simul/sequencerTB.vhdl sequencer.o
	${GHDL} -a -v ../simul/sequencerTB.vhdl 

sequencerTB : sequencerTB.o
	${GHDL} -e -v sequencerTB
	${GHDL} -r sequencerTB --vcd=sequencer.vcd


clean :
	rm -f *.o *#  *vcd *~
	rm -f work-obj93.cf reg_tb send_onetb send_zerotb \
	      send_preambletb send_bytetb sequencertb  
