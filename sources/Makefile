GHDL=ghdl
all : send_oneTB send_zeroTB

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




clean :
	rm -f *.o *#  *vcd *~
	rm -f work-obj93.cf reg_tb send_onetb send_zerotb  
