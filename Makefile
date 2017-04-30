GHDL=ghdl
all : div_clockTB  #send_oneTB send_zeroTB #send_byteTB send_preambleTB

# compil fifo
div_clock.o : sources/div_clock.vhdl
	${GHDL} -a -v sources/div_clock.vhdl

div_clockTB.o : simul/div_clockTB.vhdl div_clock.o
	${GHDL} -a -v simul/div_clockTB.vhdl 

div_clockTB : div_clockTB.o
	${GHDL} -e -v div_clockTB
	${GHDL} -r div_clockTB --vcd=div_clock.vcd


# compil fifo
send_one.o : sources/send_one.vhdl
	${GHDL} -a -v sources/send_one.vhdl

send_oneTB.o : simul/send_oneTB.vhdl send_one.o
	${GHDL} -a -v simul/send_oneTB.vhdl 

send_oneTB : send_oneTB.o
	${GHDL} -e -v send_oneTB
	${GHDL} -r send_oneTB --vcd=send_one.vcd


# compil fifo
send_zero.o : sources/send_zero.vhdl
	${GHDL} -a -v sources/send_zero.vhdl

send_zeroTB.o : simul/send_zeroTB.vhdl send_zero.o
	${GHDL} -a -v simul/send_zeroTB.vhdl 

send_zeroTB : send_zeroTB.o
	${GHDL} -e -v send_zeroTB
	${GHDL} -r send_zeroTB --vcd=send_zero.vcd


# compil fifo
send_byte.o : sources/send_byte.vhdl
	${GHDL} -a -v sources/send_byte.vhdl

send_byteTB.o : simul/send_byteTB.vhdl send_byte.o
	${GHDL} -a -v simul/send_byteTB.vhdl 

send_byteTB : send_byteTB.o
	${GHDL} -e -v send_byteTB
	${GHDL} -r send_byteTB --vcd=send_byte.vcd


# compil fifo
send_preamble.o : sources/send_preamble.vhdl
	${GHDL} -a -v sources/send_preamble.vhdl

send_preambleTB.o : simul/send_preambleTB.vhdl send_preamble.o
	${GHDL} -a -v simul/send_preambleTB.vhdl 

send_preambleTB : send_preambleTB.o
	${GHDL} -e -v send_preambleTB
	${GHDL} -r send_preambleTB --vcd=send_preamble.vcd


clean :
	rm -f *.o *#  *vcd *~
	rm -f work-obj93.cf send_onetb
