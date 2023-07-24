

.include ptm45nmhp.l

* L = 50n
* W = 100n
* Vdd = 1V

.param supply = 1V

VDD VDD 0 {supply}

VinA inA 0 PWL(0ns 0 1ns 0 1.0001ns {supply} 2ns {supply} 2.0001ns 0 3ns 0 4ns 0 4.0001ns {supply} 5ns {supply} 5.0001ns 0 6ns 0 9ns 0 9.0001ns {supply} 12ns {supply})
VinB inB 0 PWL(0ns 0 3ns 0 3.0001ns {supply} 6ns {supply} 6.0001ns 0 7ns 0 7.0001ns {supply} 8ns {supply} 8.0001ns 0 9ns 0 10ns 0 10.0001ns {supply} 11ns {supply} 11.0001ns 0)

.SUBCKT AND2 A B not_out VDD GND
*.PININFO A:I B:I not_out:O VDD:P GND:G
*.EQN not_out=!(!A + !B);
MP1 out A VDD VDD PMOS L=50n W=150n
MP2 out B VDD VDD PMOS L=50n W=150n

MN3 pd_n1 A GND GND NMOS L=50n W=200n
MN4 out B pd_n1 GND NMOS L=50n W=200n

MP_inv5 not_out out VDD VDD PMOS L=50n W=150n
MN_inv6 not_out out GND GND NMOS L=50n W=100n
.ENDS AND2

* logical effort lambda = 1.5
*atrasoa1lh = 5.50952e-011 FROM 4.00005e-009 TO 4.05515e-009
*atrasoa1hl = 3.7493e-011 FROM 5.00005e-009 TO 5.03754e-009
*atraso1blh = 5.40311e-011 FROM 1.00001e-008 TO 1.00541e-008
*atraso1bhl = 3.51773e-011 FROM 1.1e-008 TO 1.10352e-008


*atrasoa1lh=5.15698e-011 FROM 4.00005e-009 TO 4.05162e-009
*atrasoa1hl=4.20673e-011 FROM 5.00005e-009 TO 5.04212e-009
*atraso1blh=5.03847e-011 FROM 1.00001e-008 TO 1.00504e-008
*atraso1bhl=3.7063e-011 FROM 1.1e-008 TO 1.10371e-008


*atrasoa1lh=3.74144e-011 FROM 4.00005e-009 TO 4.03746e-009
*atrasoa1hl=3.9044e-011 FROM 5.00005e-009 TO 5.03909e-009
*atraso1blh=3.68247e-011 FROM 1.00001e-008 TO 1.00369e-008
*atraso1bhl=3.56408e-011 FROM 1.1e-008 TO 1.10357e-008


Xand2 inA inB out VDD GND AND2

C1 out 0 0.005pF

.measure tran atrasoA1LH
+ trig v(inA) val={supply}/2 td=4ns rise=1
+ targ v(out) val={supply}/2 td=4ns rise=1

.measure tran atrasoA1HL
+ trig v(inA) val={supply}/2 td=4ns fall=1
+ targ v(out) val={supply}/2 td=4ns fall=1

.measure tran atraso1BLH
+ trig v(inB) val={supply}/2 td=10ns rise=1
+ targ v(out) val={supply}/2 td=10ns rise=1

.measure tran atraso1BHL
+ trig v(inB) val={supply}/2 td=10ns fall=1
+ targ v(out) val={supply}/2 td=10ns fall=1



.tran 1ps 15ns

.end
