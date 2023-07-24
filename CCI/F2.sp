* Porta Complexa F2 ((!a∗ !b∗ !c) + (!a ∗ b ∗ c) + (a∗ !b ∗ c) + (a ∗ b∗ !c))

.include ptm45nmhp.l

.param Wnmos = 100n
.param Wpmos = 150n
.param Ltran = 50n
.param supply = 1V

V1 VDD 	0 DC 1V
V2 VDD2 0 DC 1V

*Arcos de transicao:
*A00 A01 A10 A11 0B0 0B1 1B0 1B1 00C 01C 10C 11C

VinA pulsoInA 0 PWL(0ns 0 1ns 0 1.0001ns {supply} 2ns {supply} 2.0001ns 0 3ns 0 4ns 0 5ns 0 5.0001ns {supply} 6ns {supply} 6.0001ns 0 7ns 0 8ns 0 8.0001ns {supply} 9ns {supply} 9.0001ns 0 10ns 0 11ns 0 11.0001ns {supply} 12ns {supply} 12.0001ns 0 13ns 0 14ns 0 15ns 0 16ns 0 17ns 0 18ns 0 19ns 0 19.0001ns {supply} 20ns {supply} 21ns {supply} 22ns {supply} 23ns {supply} 24ns {supply} 25ns {supply} 25.0001ns 0 26ns 0 27ns 0 28ns 0 29ns 0 30ns 0 31ns 0 31.0001ns {supply} 32ns {supply} 33ns {supply} 34ns {supply} 35ns {supply} 36ns {supply})
VinB pulsoInB 0 PWL(0ns 0 1ns 0 2ns 0 3ns 0 4ns 0 5ns 0 6ns 0 6.0001ns {supply} 7ns {supply} 8ns {supply} 9ns {supply} 10ns {supply} 11ns {supply} 12ns {supply} 12.0001ns 0 13ns 0 13.0001ns {supply} 14ns {supply} 14.0001ns 0 15ns 0 16ns 0 16.0001ns {supply} 17ns {supply} 17.0001ns 0 18ns 0 19ns 0 19.0001ns {supply} 20ns {supply} 20.0001ns 0 21ns 0 22ns 0 22.0001ns {supply} 23ns {supply} 23.0001ns 0 24ns 0 25ns 0 26ns 0 27ns 0 27.0001ns {supply} 28ns {supply} 29ns {supply} 29.0001ns 0 30ns 0 31ns 0 32ns 0 33ns 0 33.0001ns {supply} 34ns {supply} 35ns {supply} 36ns {supply})
VinC pulsoInC 0 PWL(0ns 0 1ns 0 2ns 0 3ns 0 3.0001ns {supply} 4ns {supply} 5ns {supply} 6ns {supply} 6.0001ns 0 7ns 0 8ns 0 9ns 0 9.0001ns {supply} 10ns {supply} 11ns {supply} 12ns {supply} 12.0001ns 0 13ns 0 14ns 0 15ns 0 15.0001ns {supply} 16ns {supply} 17ns {supply} 18ns {supply} 18.0001ns 0 19ns 0 20ns 0 21ns 0 21.0001ns {supply} 22ns {supply} 23ns {supply} 24ns {supply} 24.0001ns 0 25ns 0 26ns 0 27ns 0 28ns 0 28.0001ns {supply} 29ns {supply} 29.0001ns 0 30ns 0 31ns 0 31.0001ns {supply} 32ns {supply} 32.0001ns 0 33ns 0 34ns 0 34.0001ns {supply} 35ns {supply} 35.0001ns 0 36ns 0)

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

.SUBCKT F2 a b c out VDD GND
*.PININFO a:I b:I c:I out:O VDD:P GND:G
*.EQN out=((a * ((!b * c) + (!c * b))) + (!a * ((!b * !c) + (b * c))));
MP1 pu_n1 b VDD VDD PMOS L={Ltran} W={Wpmos}
MP2 pu_n9 not_c pu_n1 VDD PMOS L={Ltran} W={Wpmos}
MP3 pu_n5 c VDD VDD PMOS L={Ltran} W={Wpmos}
MP4 pu_n9 not_b pu_n5 VDD PMOS L={Ltran} W={Wpmos}
MP5 out not_a pu_n9 VDD PMOS L={Ltran} W={Wpmos}
MP6 pu_n13 a VDD VDD PMOS L={Ltran} W={Wpmos}
MP7 pu_n15 b pu_n13 VDD PMOS L={Ltran} W={Wpmos}
MP8 out c pu_n15 VDD PMOS L={Ltran} W={Wpmos}
MP9 pu_n19 not_b pu_n13 VDD PMOS L={Ltran} W={Wpmos}
MP10 out not_c pu_n19 VDD PMOS L={Ltran} W={Wpmos}
MN11 pd_n5 b GND GND NMOS L={Ltran} W={Wpmos}
MN12 pd_n5 not_c GND GND NMOS L={Ltran} W={Wpmos}
MN13 pd_n15 c pd_n5 GND NMOS L={Ltran} W={Wpmos}
MN14 pd_n15 not_b pd_n5 GND NMOS L={Ltran} W={Wpmos}
MN15 pd_n15 not_a GND GND NMOS L={Ltran} W={Wpmos}
MN16 out a pd_n15 GND NMOS L={Ltran} W={Wpmos}
MN17 pd_n23 b pd_n15 GND NMOS L={Ltran} W={Wpmos}
MN18 pd_n23 c pd_n15 GND NMOS L={Ltran} W={Wpmos}
MN19 out not_b pd_n23 GND NMOS L={Ltran} W={Wpmos}
MN20 out not_c pd_n23 GND NMOS L={Ltran} W={Wpmos}
MP_inv21 not_a a VDD VDD PMOS L={Ltran} W={Wpmos}
MN_inv22 not_a a GND GND NMOS L={Ltran} W={Wpmos}
MP_inv23 not_b b VDD VDD PMOS L={Ltran} W={Wpmos}
MN_inv24 not_b b GND GND NMOS L={Ltran} W={Wpmos}
MP_inv25 not_c c VDD VDD PMOS L={Ltran} W={Wpmos}
MN_inv26 not_c c GND GND NMOS L={Ltran} W={Wpmos}
.ENDS F2

.subckt FO4 a out VDD GND
Xinv1 a out VDD GND inverter
Xinv2 a out VDD GND inverter
Xinv3 a out VDD GND inverter
Xinv4 a out VDD GND inverter
.ends FO4

XDelay1 pulsoInA inA VDD2 GND inputDelay
XDelay2 pulsoInB inB VDD2 GND inputDelay
XDelay3 pulsoInC inC VDD2 GND inputDelay

XF2 inA inB inC out VDD GND F2

XFO4 out out2 VDD2 GND FO4

.tran 1p 16n
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

.measure tran7atrasoA10HL
+ trig v(inA) val={supply}/2 td = 7ns rise = 1
+ targ v(out) val={supply}/2 td = 7ns fall = 1

*A11
.measure tran atrasoA11LH
+ trig v(inA) val={supply}/2 td = 10ns fall = 1
+ targ v(out) val={supply}/2 td = 10ns rise = 1

.measure tran atrasoA11HL
+ trig v(inA) val={supply}/2 td = 10ns rise = 1
+ targ v(out) val={supply}/2 td = 10ns fall = 1

*0B0
.measure tran atraso0B0LH
+ trig v(inB) val={supply}/2 td = 13ns fall = 1
+ targ v(out) val={supply}/2 td = 13ns rise = 1

.measure tran atraso0B0HL
+ trig v(inB) val={supply}/2 td = 13ns rise = 1
+ targ v(out) val={supply}/2 td = 13ns fall = 1

*0B1
.measure tran atraso0B1LH
+ trig v(inB) val={supply}/2 td = 16ns fall = 1
+ targ v(out) val={supply}/2 td = 16ns rise = 1

.measure tran atraso0B1HL
+ trig v(inB) val={supply}/2 td = 16ns rise = 1
+ targ v(out) val={supply}/2 td = 16ns fall = 1

*1B0
.measure tran atraso1B0LH
+ trig v(inB) val={supply}/2 td = 19ns fall = 1
+ targ v(out) val={supply}/2 td = 19ns rise = 1

.measure tran atraso1B0HL
+ trig v(inB) val={supply}/2 td = 19ns rise = 1
+ targ v(out) val={supply}/2 td = 19ns fall = 1

*1B1
.measure tran atraso1B1LH
+ trig v(inB) val={supply}/2 td = 21ns fall = 1
+ targ v(out) val={supply}/2 td = 21ns rise = 1

.measure tran atraso1B1HL
+ trig v(inB) val={supply}/2 td = 21ns rise = 1
+ targ v(out) val={supply}/2 td = 21ns fall = 1
*00C
.measure tran atraso00CLH
+ trig v(inC) val={supply}/2 td = 24ns fall = 1
+ targ v(out) val={supply}/2 td = 24ns rise = 1

.measure tran atraso00CHL
+ trig v(inC) val={supply}/2 td = 24ns rise = 1
+ targ v(out) val={supply}/2 td = 24ns fall = 1

*01C
.measure tran atraso01CLH
+ trig v(inC) val={supply}/2 td = 27ns fall = 1
+ targ v(out) val={supply}/2 td = 27ns rise = 1

.measure tran atraso01CHL
+ trig v(inC) val={supply}/2 td = 27ns rise = 1
+ targ v(out) val={supply}/2 td = 27ns fall = 1

*10C
.measure tran atraso10CLH
+ trig v(inC) val={supply}/2 td = 30ns fall = 1
+ targ v(out) val={supply}/2 td = 30ns rise = 1

.measure tran atraso10CHL
+ trig v(inC) val={supply}/2 td = 30ns rise = 1
+ targ v(out) val={supply}/2 td = 30ns fall = 1

*11C
.measure tran atraso11CLH
+ trig v(inC) val={supply}/2 td = 33ns fall = 1
+ targ v(out) val={supply}/2 td = 33ns rise = 1

.measure tran atraso11CHL
+ trig v(inC) val={supply}/2 td = 33ns rise = 1
+ targ v(out) val={supply}/2 td = 33ns fall = 1

* Consumo dinamico
* P = V * I de toda a simulacao

.measure tran consumo_Medio AVG(i(V1)*-v(VDD)) from=0ns to=36ns

* Consumo estatico
* P = V * I no momento em que o circuito esta estavel
* A111 1B11 11C1 111D

.measure tran consumo_Estatico_A00HL AVG(i(V1)*-v(VDD)) from=1.97ns to=2ns
.measure tran consumo_Estatico_A00LH AVG(i(V1)*-v(VDD)) from=2.97ns to=3ns

.measure tran consumo_Estatico_A01HL AVG(i(V1)*-v(VDD)) from=3.97ns to=4ns
.measure tran consumo_Estatico_A01LH AVG(i(V1)*-v(VDD)) from=4.97ns to=5ns

.measure tran consumo_Estatico_A10HL AVG(i(V1)*-v(VDD)) from=5.97ns to=6ns
.measure tran consumo_Estatico_A10LH AVG(i(V1)*-v(VDD)) from=6.97ns to=7ns

.measure tran consumo_Estatico_A11HL AVG(i(V1)*-v(VDD)) from=7.97ns to=8ns
.measure tran consumo_Estatico_A11LH AVG(i(V1)*-v(VDD)) from=8.97ns to=9ns

.measure tran consumo_Estatico_0B0HL AVG(i(V1)*-v(VDD)) from=9.97ns to=10ns
.measure tran consumo_Estatico_0B0LH AVG(i(V1)*-v(VDD)) from=10.97ns to=11ns

.measure tran consumo_Estatico_0B1HL AVG(i(V1)*-v(VDD)) from=11.97ns to=12ns
.measure tran consumo_Estatico_0B1LH AVG(i(V1)*-v(VDD)) from=12.97ns to=13ns

.measure tran consumo_Estatico_1B0HL AVG(i(V1)*-v(VDD)) from=13.97ns to=14ns
.measure tran consumo_Estatico_1B0LH AVG(i(V1)*-v(VDD)) from=14.97ns to=15ns

.measure tran consumo_Estatico_1B1HL AVG(i(V1)*-v(VDD)) from=15.97ns to=16ns
.measure tran consumo_Estatico_1B1LH AVG(i(V1)*-v(VDD)) from=16.97ns to=17ns

.measure tran consumo_Estatico_00CHL AVG(i(V1)*-v(VDD)) from=17.97ns to=18ns
.measure tran consumo_Estatico_00CLH AVG(i(V1)*-v(VDD)) from=18.97ns to=19ns

.measure tran consumo_Estatico_01CHL AVG(i(V1)*-v(VDD)) from=19.97ns to=20ns
.measure tran consumo_Estatico_01CLH AVG(i(V1)*-v(VDD)) from=20.97ns to=21ns

.measure tran consumo_Estatico_10CHL AVG(i(V1)*-v(VDD)) from=21.97ns to=22ns
.measure tran consumo_Estatico_10CLH AVG(i(V1)*-v(VDD)) from=22.97ns to=23ns

.measure tran consumo_Estatico_11CHL AVG(i(V1)*-v(VDD)) from=23.97ns to=24ns
.measure tran consumo_Estatico_11CLH AVG(i(V1)*-v(VDD)) from=24.97ns to=25ns


.end
