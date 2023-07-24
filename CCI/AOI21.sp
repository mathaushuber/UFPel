* Porta Complexa AOI21 !((a + b) * (a + c))

.include ptm45nmhp.l

.param Wnmos = 100n
.param Wpmos = 150n
.param Ltran = 50n
.param supply = 1V

V1 VDD 	0 DC 1V
V2 VDD2 0 DC 1V

* Arcos de Transicao
* A00 A01 A10 0B1 01C

VinA pulsoInA 0 PWL(0ns 0 1ns 0 1.0001ns {supply} 2ns {supply} 2.0001ns 0 3ns 0 3ns 0 4ns 0 4.0001ns {supply} 5ns {supply} 5.0001ns 0 6ns 0 6ns 0 7ns 0 7.0001ns {supply} 8ns {supply} 8.0001ns 0 9ns 0)
VinB pulsoInB 0 PWL(0ns 0 6ns 0 6.0001ns {supply} 9ns {supply} 9.0001ns 0 10ns 0 10.0001ns {supply} 11ns {supply} 11.0001ns 0 12ns 0 12.0001ns {supply})
VinC pulsoInC 0 PWL(0ns 0 3ns 0 3.0001ns {supply} 6ns {supply} 6.0001ns 0 9ns 0 9.0001ns {supply} 12ns {supply} 12.0001ns 0 13ns 0 13.0001ns {supply} 14ns {supply} 14.0001ns 0 15ns 0)

.SUBCKT inverter a out VDD GND
*.PININFO a:I out:O VDD:P GND:G
*.EQN out=!a;
MP1 out a VDD VDD PMOS L={Ltran} W={Wpmos}
MN2 out a GND GND NMOS L={Ltran} W={Wnmos}
.ENDS inverter

.subckt inputDelay a out VDD GND
Xinv1 a n1 VDD GND inverter
Xinv2 n1 out VDD GND inverter
.ends inputDelay

.SUBCKT AOI21 a b c out VDD GND
*.PININFO a:I b:I c:I out:O VDD:P GND:G
*.EQN out=(!a * (!c + !b));
MP1 pu_n1 a VDD VDD PMOS 	L={Ltran} 	W={2*Wpmos}
MP2 out c pu_n1 VDD PMOS 	L={Ltran} 	W={2*Wpmos}
MP3 out b pu_n1 VDD PMOS 	L={Ltran} 	W={2*Wpmos}

MN4 out a GND GND NMOS 		L={Ltran} 	W={1*Wnmos}
MN5 pd_n3 c GND GND NMOS 	L={Ltran} 	W={2*Wnmos}
MN6 out b pd_n3 GND NMOS 	L={Ltran} 	W={2*Wnmos}
.ENDS AOI21

.subckt FO4 a out VDD GND
Xinv1 a out VDD GND inverter
Xinv2 a out VDD GND inverter
Xinv3 a out VDD GND inverter
Xinv4 a out VDD GND inverter
.ends FO4


XDelay1 pulsoInA inA VDD2 GND inputDelay
XDelay2 pulsoInB inB VDD2 GND inputDelay
XDelay3 pulsoInC inC VDD2 GND inputDelay

XAOI21 inA inB inC out VDD GND AOI21

XFO4 out out2 VDD2 GND FO4


.tran 1p 16n

* Measures Atraso
*A00
.measure tran atrasoA00LH
+ trig v(inA) val={supply}/2 td = 1ns fall = 1
+ targ v(out) val={supply}/2 td = 1ns rise = 1

.measure tran atrasoA00HL
+ trig v(inA) val={supply}/2 td = 1ns rise = 1
+ targ v(out) val={supply}/2 td = 1ns fall = 1

*A01
.measure tran atrasoA01LH
+ trig v(inA) val={supply}/2 td = 4ns fall = 1
+ targ v(out) val={supply}/2 td = 4ns rise = 1

.measure tran atrasoA01HL
+ trig v(inA) val={supply}/2 td = 4ns rise = 1
+ targ v(out) val={supply}/2 td = 4ns fall = 1

*A10
.measure tran atrasoA10LH
+ trig v(inA) val={supply}/2 td = 7ns fall = 1
+ targ v(out) val={supply}/2 td = 7ns rise = 1

.measure tran atrasoA10HL
+ trig v(inA) val={supply}/2 td = 7ns rise = 1
+ targ v(out) val={supply}/2 td = 7ns fall = 1

*0B1
.measure tran atraso0B1LH
+ trig v(inB) val={supply}/2 td = 10ns fall = 1
+ targ v(out) val={supply}/2 td = 10ns rise = 1

.measure tran atraso0B1HL
+ trig v(inB) val={supply}/2 td = 10ns rise = 1
+ targ v(out) val={supply}/2 td = 10ns fall = 1

*01C
.measure tran atraso01CLH
+ trig v(inC) val={supply}/2 td = 13ns fall = 1
+ targ v(out) val={supply}/2 td = 13ns rise = 1

.measure tran atraso01CHL
+ trig v(inC) val={supply}/2 td = 13ns rise = 1
+ targ v(out) val={supply}/2 td = 13ns fall = 1

* Consumo dinamico
* P = V * I de toda a simulacao

.measure tran consumo_Medio AVG(i(V1)*-v(VDD)) from=0ns to=15ns

* Consumo estatico
* P = V * I no momento em que o circuito esta estavel
* A00 A01 A10 0B1 01C

.measure tran consumo_Estatico_A00HL AVG(i(V1)*-v(VDD)) from=1.97ns to=2ns
.measure tran consumo_Estatico_A00LH AVG(i(V1)*-v(VDD)) from=2.97ns to=3ns

.measure tran consumo_Estatico_A01HL AVG(i(V1)*-v(VDD)) from=4.97ns to=5ns
.measure tran consumo_Estatico_A01LH AVG(i(V1)*-v(VDD)) from=5.97ns to=6ns

.measure tran consumo_Estatico_A10HL AVG(i(V1)*-v(VDD)) from=7.97ns to=8ns
.measure tran consumo_Estatico_A10LH AVG(i(V1)*-v(VDD)) from=8.97ns to=9ns

.measure tran consumo_Estatico_0B1HL AVG(i(V1)*-v(VDD)) from=10.97ns to=11ns
.measure tran consumo_Estatico_0B1LH AVG(i(V1)*-v(VDD)) from=11.97ns to=12ns

.measure tran consumo_Estatico_01CHL AVG(i(V1)*-v(VDD)) from=13.97ns to=14ns
.measure tran consumo_Estatico_01CLH AVG(i(V1)*-v(VDD)) from=14.97ns to=15ns

.end



















