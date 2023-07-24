* Porta Complexa F1 !(!(a ∗ d )+!(b ∗ c)) EQ (a * b * c * d)
.include ptm45nmhp.l

.param Wnmos = 100n
.param Wpmos = 150n
.param Ltran = 50n
.param supply = 1V

V1 VDD 	0 DC 1V
V2 VDD2 0 DC 1V

*Arcos de transicao:
*A111 1B11 11C1 111D

VinA pulsoInA 0 PWL(0ns 0 1ns 0 1.0001ns {supply} 2ns {supply} 2.0001ns 0 3ns 0 3.0001ns {supply} 4ns {supply} 5ns {supply} 6ns {supply} 7ns {supply} 8ns {supply} 9ns {supply} 10ns {supply} 11ns {supply} 12ns {supply})
VinB pulsoInB 0 PWL(0ns {supply} 1ns {supply} 2ns {supply} 3ns {supply} 3.0001ns 0 4ns 0 4.0001ns {supply} 5ns {supply} 5.0001ns 0 6ns 0 6.0001ns {supply} 7ns {supply} 8ns {supply} 9ns {supply} 10ns {supply} 11ns {supply} 12ns {supply})
VinC pulsoInC 0 PWL(0ns {supply} 1ns {supply} 2ns {supply} 3ns {supply} 4ns {supply} 5ns {supply} 6ns {supply} 6.0001ns 0 7ns 0 7.0001ns {supply} 8ns {supply} 8.0001ns 0 9ns 0 9.0001ns {supply} 10ns {supply} 11ns {supply} 12ns {supply})
VinD pulsoInD 0 PWL(0ns {supply} 1ns {supply} 2ns {supply} 3ns {supply} 4ns {supply} 5ns {supply} 6ns {supply} 7ns {supply} 8ns {supply} 9ns {supply} 9.0001ns 0 10ns 0 10.0001ns {supply} 11ns {supply} 12ns {supply})

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

.SUBCKT f1 a b c d not_out VDD GND
*.PININFO a:I b:I c:I d:I not_out:O VDD:P GND:G
*.EQN not_out=!(!a + !d + !b + !c);
MP1 out a VDD VDD PMOS L={Ltran} W={Wpmos}
MP2 out d VDD VDD PMOS L={Ltran} W={Wpmos}
MP3 out b VDD VDD PMOS L={Ltran} W={Wpmos}
MP4 out c VDD VDD PMOS L={Ltran} W={Wpmos}
MN5 pd_n1 a GND GND NMOS L={Ltran} W={4*Wpmos}
MN6 pd_n3 d pd_n1 GND NMOS L={Ltran} W={Wpmos}
MN7 pd_n5 b pd_n3 GND NMOS L={Ltran} W={3*Wpmos}
MN8 out c pd_n5 GND NMOS L={Ltran} W={2*Wpmos}
MP_inv9 not_out out VDD VDD PMOS L={Ltran} W={Wpmos}
MN_inv10 not_out out GND GND NMOS L={Ltran} W={Wpmos}
.ENDS f1

.subckt FO4 a out VDD GND
Xinv1 a out VDD GND inverter
Xinv2 a out VDD GND inverter
Xinv3 a out VDD GND inverter
Xinv4 a out VDD GND inverter
.ends FO4

XDelay1 pulsoInA inA VDD2 GND inputDelay
XDelay2 pulsoInB inB VDD2 GND inputDelay
XDelay3 pulsoInC inC VDD2 GND inputDelay
XDelay4 pulsoInD inD VDD2 GND inputDelay

XF1 inA inB inC inD out VDD GND f1

XFO4 out out2 VDD2 GND FO4

.tran 1p 16n

* Measures Atraso
*A111
.measure tran atrasoA111LH
+ trig v(inA) val={supply}/2 td = 1ns fall = 1
+ targ v(out) val={supply}/2 td = 1ns rise = 1

.measure tran atrasoA111HL
+ trig v(inA) val={supply}/2 td = 1ns rise = 1
+ targ v(out) val={supply}/2 td = 1ns fall = 1

*1B11
.measure tran atraso1B11LH
+ trig v(inB) val={supply}/2 td = 4ns fall = 1
+ targ v(out) val={supply}/2 td = 4ns rise = 1

.measure tran atraso1B11HL
+ trig v(inB) val={supply}/2 td = 4ns rise = 1
+ targ v(out) val={supply}/2 td = 4ns fall = 1

*11C1
.measure tran atraso11C1LH
+ trig v(inC) val={supply}/2 td = 7ns fall = 1
+ targ v(out) val={supply}/2 td = 7ns rise = 1

.measure tran atraso11C1HL
+ trig v(inC) val={supply}/2 td = 7ns rise = 1
+ targ v(out) val={supply}/2 td = 7ns fall = 1

*111D
.measure tran atraso111DLH
+ trig v(inD) val={supply}/2 td = 10ns fall = 1
+ targ v(out) val={supply}/2 td = 10ns rise = 1

.measure tran atraso111DHL
+ trig v(inD) val={supply}/2 td = 10ns rise = 1
+ targ v(out) val={supply}/2 td = 10ns fall = 1

* Consumo dinamico
* P = V * I de toda a simulacao

.measure tran consumo_Medio AVG(i(V1)*-v(VDD)) from=0ns to=12ns

* Consumo estatico
* P = V * I no momento em que o circuito esta estavel
* A111 1B11 11C1 111D

.measure tran consumo_Estatico_A111HL AVG(i(V1)*-v(VDD)) from=1.97ns to=2ns
.measure tran consumo_Estatico_A111LH AVG(i(V1)*-v(VDD)) from=2.97ns to=3ns

.measure tran consumo_Estatico_1B11HL AVG(i(V1)*-v(VDD)) from=3.97ns to=4ns
.measure tran consumo_Estatico_1B11LH AVG(i(V1)*-v(VDD)) from=4.97ns to=5ns

.measure tran consumo_Estatico_11C1HL AVG(i(V1)*-v(VDD)) from=5.97ns to=6ns
.measure tran consumo_Estatico_11C1LH AVG(i(V1)*-v(VDD)) from=6.97ns to=7ns

.measure tran consumo_Estatico_111DHL AVG(i(V1)*-v(VDD)) from=7.97ns to=8ns
.measure tran consumo_Estatico_111DLH AVG(i(V1)*-v(VDD)) from=8.97ns to=9ns

.end

