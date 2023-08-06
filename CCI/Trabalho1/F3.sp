
.include ptm45nmhp.l

.param Wnmos = 100n
.param Wpmos = 150n
.param Ltran = 50n
.param supply = 1V

v1 VDD 	0 dc {supply}
v2 VDD2 0 dc {supply}

VinA apulse 0 pwl(0ns 0 1ns 0 1.001ns {supply} 2ns {supply} 2.001ns 0 3ns 0 4ns 0 4.001ns {supply} 5ns {supply} 5.001ns 0 6ns 0 6.001ns 0 7ns 0 7.001ns {supply} 8ns {supply} 8.001ns 0 10ns 0 10.001ns {supply} 11ns {supply} 11.001ns 0 13ns 0 13.001ns {supply} 14ns {supply} 14.001ns 0 16ns 0 16.001ns {supply} 17ns {supply} 17.001ns 0 19ns 0 19.001ns {supply} 20ns {supply} 20.001ns 0 21ns 0 21.001ns 0 33ns 0 33.001ns {supply} 42ns {supply} 42.001ns 0 54ns 0 54.001ns {supply} 66ns {supply})
VinB bpulse 0 pwl(0ns 0 3ns 0 3.0001ns 0 6ns 0 6.0001ns 0 9ns 0 9.0001ns 0 12ns 0 12.0001ns {supply} 15ns {supply} 15.0001ns {supply} 18ns {supply} 18.0001ns {supply} 21ns {supply} 21.0001ns 0 22ns 0 22.0001ns {supply} 23ns {supply} 23.0001ns 0 24ns 0 25ns 0 25.0001ns {supply} 26ns {supply} 26.0001ns 0 27ns 0 28ns 0 28.0001ns {supply} 29ns {supply} 29.0001ns 0 30ns 0 31ns 0 31.0001ns {supply} 32ns {supply} 32.0001ns 0 33ns 0 34ns 0 34.0001ns {supply} 35ns {supply} 35.0001ns 0 36ns 0 37ns 0 37.0001ns {supply} 38ns {supply} 38.0001ns 0 39ns 0 40ns 0 40.0001ns {supply} 41ns {supply} 41.0001ns 0 42ns 0 42.0001ns 0 45ns 0 45.0001ns 0 48ns 0 48.0001ns {supply} 51ns {supply} 51.0001ns {supply} 54ns {supply} 54.0001ns 0 57ns 0 57.0001ns 0 60ns 0 60.0001ns {supply} 63ns {supply} 63.0001ns {supply} 66ns {supply})
VinC cpulse 0 pwl(0ns 0 3ns 0 3.0001ns 0 6ns 0 6.0001ns {supply} 9ns {supply} 9.0001ns {supply} 12ns {supply} 12.0001ns 0 15ns 0 15.0001ns 0 18ns 0 18.0001ns {supply} 21ns {supply} 21.0001ns 0 24ns 0 24.0001ns 0 27ns 0 27.0001ns {supply} 30ns {supply} 30.0001ns {supply} 33ns {supply} 33.0001ns 0 36ns 0 36.0001ns 0 39ns 0 39.0001ns {supply} 42ns {supply} 42.0001ns 0 43ns 0 43.0001ns {supply} 44ns {supply} 44.0001ns 0 45ns 0 46ns 0 46.0001ns {supply} 47ns {supply} 47.0001ns 0 49ns 0 50ns 0 50.0001ns {supply} 51ns {supply} 51.0001ns 0 52ns 0 53ns 0 53.0001ns {supply} 54ns {supply} 54.0001ns 0 55ns 0 56ns 0 56.0001ns {supply} 57ns {supply} 57.0001ns 0 58ns 0 59ns 0 59.0001ns {supply} 60ns {supply} 60.0001ns 0 61ns 0 61ns 0 61.0001ns {supply} 62ns {supply} 62.0001ns 0 63ns 0 63.0001ns {supply} 66ns {supply})
VinD dpulse 0 pwl(0ns 0 3ns 0 3.001ns {supply} 6ns {supply} 6.001ns 0 9ns 0 9.001ns {supply} 12ns {supply} 12.001ns 0 15ns 0 15.001ns {supply} 18ns {supply} 18.001ns 0 24ns 0 24.001ns {supply} 27ns {supply} 27.001ns 0 30ns 0 30.001ns {supply} 33ns {supply} 33.001ns 0 36ns 0 36.001ns {supply} 39ns {supply} 39.001ns 0 45ns 0 45.001ns {supply} 48ns {supply} 48.001ns 0 51ns 0 51.001ns {supply} 54ns {supply} 54.001ns 0 57ns 0 57.001ns {supply} 60ns {supply} 60.001ns 0 63ns 0 63.001ns 0 64ns 0 64.001ns {supply} 65ns {supply} 65.001ns 0 66ns 0)

.subckt inverter a out VDD
*.PININFO a:I out:O VDD:P GND:G
*.EQN out=!a;
MP1 out a VDD VDD PMOS L={Ltran} W={Wpmos}
MN2 out a 0	  0 NMOS L={Ltran} W={Wnmos}
.ends inverter

* buffer
.subckt inputdelay ain bin cin din aout bout cout dout VDD
	xinv1 ain	n1	VDD inverter
	xinv2 n1	aout VDD inverter
	xinv3 bin	n2	VDD inverter
	xinv4 n2	bout VDD inverter
	xinv5 cin	n3	VDD inverter
	xinv6 n3	cout VDD inverter
	xinv7 din	n4	VDD inverter
	xinv8 n4	dout VDD inverter
.ends inputdelay

* subckt f1 extraído do switchcraft
.subckt f1 ain bin cin din not_out VDD
*.PININFO ain:I bin:I cin:I din:I not_out:O VDD:P GND:G
*.EQN not_out=!(!ain + !din + !bin + !cin);
MP1 out ain VDD VDD PMOS l={Ltran} W={Wpmos}
MP2 out din VDD VDD PMOS l={Ltran} W={Wpmos}
MP3 out bin VDD VDD PMOS l={Ltran} W={Wpmos}
MP4 out cin VDD VDD PMOS l={Ltran} W={Wpmos}

MN5 pd_n1 ain 0 0 NMOS l={Ltran} W='{Wpmos} * 4'
MN6 pd_n3 din pd_n1 0 NMOS l={Ltran} W='{Wpmos} * 4'
MN7 pd_n5 bin pd_n3 0 NMOS l={Ltran} W='{Wpmos} * 4'
MN8 out cin pd_n5 0 NMOS l={Ltran} W='{Wpmos} * 4'

MP_inv9 not_out out VDD VDD PMOS l={Ltran} W={Wpmos}
MN_inv10 not_out out 0 0 NMOS l={Ltran} W={Wpmos}
.ends f1

* subckt f2 extraído do switchcraft
.subckt f2 ain bin cin out VDD
*.PININFO ain:I bin:I cin:I out:O VDD:P GND:G
*.EQN out=((!cin * !ain * !bin) + (cin * !ain * bin) + (cin * !bin * ain) + (bin * !cin * ain));
MP1 pu_n1 ain VDD VDD PMOS l={Ltran} W='{Wpmos} * 3'
MP2 pu_n3 bin pu_n1 VDD PMOS l={Ltran} W='{Wpmos} * 3'
MP3 out cin pu_n3 VDD PMOS l={Ltran} W='{Wpmos} * 3'
MP4 pu_n7 ain VDD VDD PMOS l={Ltran} W='{Wpmos} * 3'
MP5 pu_n9 not_bin pu_n7 VDD PMOS l={Ltran} W='{Wpmos} * 3'
MP6 out not_cin pu_n9 VDD PMOS l={Ltran} W='{Wpmos} * 3'
MP7 pu_n15 bin VDD VDD PMOS l={Ltran} W='{Wpmos} * 3'
MP8 pu_n17 not_ain pu_n15 VDD PMOS l={Ltran} W='{Wpmos} * 3'
MP9 out not_cin pu_n17 VDD PMOS l={Ltran} W='{Wpmos} * 3'
MP10 pu_n21 cin VDD VDD PMOS l={Ltran} W='{Wpmos} * 3'
MP11 pu_n23 not_ain pu_n21 VDD PMOS l={Ltran} W='{Wpmos} * 3'
MP12 out not_bin pu_n23 VDD PMOS l={Ltran} W='{Wpmos} * 3'

MN13 pd_n9 ain 0 0 NMOS l={Ltran} W='{Wpmos} * 4'
MN14 pd_n9 bin 0 0 NMOS l={Ltran} W='{Wpmos} * 4'
MN15 pd_n9 cin 0 0 NMOS l={Ltran} W='{Wpmos} * 4'
MN16 pd_n19 ain pd_n9 GND NMOS l={Ltran} W='{Wpmos} * 4'
MN17 pd_n19 not_bin pd_n9 0 NMOS l={Ltran} W='{Wpmos} * 4'
MN18 pd_n19 not_cin pd_n9 0 NMOS l={Ltran} W='{Wpmos} * 4'
MN19 pd_n29 bin pd_n19 0 NMOS l={Ltran} W='{Wpmos} * 4'
MN20 pd_n29 not_ain pd_n19 0 NMOS l={Ltran} W='{Wpmos} * 4'
MN21 pd_n29 not_cin pd_n19 0 NMOS l={Ltran} W='{Wpmos} * 4'
MN22 out cin pd_n29 0 NMOS l={Ltran} W='{Wpmos} * 4'
MN23 out not_ain pd_n29 0 NMOS l={Ltran} W='{Wpmos} * 4'
MN24 out not_bin pd_n29 0 NMOS l={Ltran} W='{Wpmos} * 4'

MP_inv25 not_ain ain VDD VDD PMOS l={Ltran} W='{Wpmos} * 1.5'
MN_inv26 not_ain ain 0 0 NMOS l={Ltran} W={Wpmos}
MP_inv27 not_bin bin VDD VDD PMOS l={Ltran} W='{Wpmos} * 1.5'
MN_inv28 not_bin bin 0 0 NMOS l={Ltran} W={Wpmos}
MP_inv29 not_cin cin VDD VDD PMOS l={Ltran} W='{Wpmos} * 1.5'
MN_inv30 not_cin cin 0 0 NMOS l={Ltran} W={Wpmos}
.ends f2

.subckt f3 ain bin not_out VDD
*.PININFO ain:I bin:I not_out:O VDD:P GND:G
*.EQN not_out=!(!ain * !bin);
MP1 pu_n1 ain VDD VDD PMOS l={Ltran} W='{Wpmos} * 2'
MP2 out bin pu_n1 VDD PMOS l={Ltran} W='{Wpmos} * 2'
MN3 out ain 0 0 NMOS l={Ltran} W='{Wpmos} * 1'
MN4 out bin 0 0 NMOS l={Ltran} W='{Wpmos} * 1'
MP_inv5 not_out out VDD VDD PMOS l={Ltran} W={Wpmos}
MN_inv6 not_out out 0 0 NMOS l={Ltran} W={Wpmos}
.ends f3

.subckt fo4 in out VDD
	xinv1 in out VDD inverter
	xinv2 in out VDD inverter
	xinv3 in out VDD inverter
	xinv4 in out VDD inverter
.ends fo4

xin	apulse	bpulse	cpulse	dpulse		aout bout cout dout		VDD2 inputdelay

xf1 aout bout cout dout f1out VDD f1
xf2 aout bout cout f2out VDD f2
xf3 f1out f2out f3out VDD f3

xfo4 f3out outfo4 VDD2 fo4

.tran 1p 67ns

* a000
.measure tran atrasoa000lh
+ trig v(apulse) val={supply/2} td = 1ns rise = 1
+ targ v(f3out) val={supply/2} td = 1ns fall = 1
.measure tran atrasoa000hl
+ trig v(apulse) val={supply/2} td = 1ns fall = 1
+ targ v(f3out) val={supply/2} td = 1ns rise = 1

* a001
.measure tran atrasoa001lh
+ trig v(apulse) val={supply/2} td = 4ns rise = 1
+ targ v(f3out) val={supply/2} td = 4ns fall = 1
.measure tran atrasoa001hl
+ trig v(apulse) val={supply/2} td = 4ns fall = 1
+ targ v(f3out) val={supply/2} td = 4ns rise = 1

* a010
.measure tran atrasoa010lh
+ trig v(apulse) val={supply/2} td = 7ns rise = 1
+ targ v(f3out) val={supply/2} td = 7ns rise = 1
.measure tran atrasoa010hl
+ trig v(apulse) val={supply/2} td = 7ns fall = 1
+ targ v(f3out) val={supply/2} td = 7ns fall = 1

* a011
.measure tran atrasoa011lh
+ trig v(apulse) val={supply/2} td = 10ns rise = 1
+ targ v(f3out) val={supply/2} td = 10ns rise = 1
.measure tran atrasoa011hl
+ trig v(apulse) val={supply/2} td = 10ns fall = 1
+ targ v(f3out) val={supply/2} td = 10ns fall = 1

* a100
.measure tran atrasoa100lh
+ trig v(apulse) val={supply/2} td = 13ns rise = 1
+ targ v(f3out) val={supply/2} td = 13ns rise = 1
.measure tran atrasoa100hl
+ trig v(apulse) val={supply/2} td = 13ns fall = 1
+ targ v(f3out) val={supply/2} td = 13ns fall = 1

* a101
.measure tran atrasoa101lh
+ trig v(apulse) val={supply/2} td = 16ns rise = 1
+ targ v(f3out) val={supply/2} td = 16ns rise = 1
.measure tran atrasoa101hl
+ trig v(apulse) val={supply/2} td = 16ns fall = 1
+ targ v(f3out) val={supply/2} td = 16ns fall = 1

* a110
.measure tran atrasoa110lh
+ trig v(apulse) val={supply/2} td = 19ns rise = 1
+ targ v(f3out) val={supply/2} td = 19ns fall = 1
.measure tran atrasoa110hl
+ trig v(apulse) val={supply/2} td = 19ns fall = 1
+ targ v(f3out) val={supply/2} td = 19ns rise = 1

* 0b00
.measure tran atraso0b00lh
+ trig v(bpulse) val={supply/2} td = 22ns rise = 1
+ targ v(f3out) val={supply/2} td = 22ns fall = 1
.measure tran atraso0b00hl
+ trig v(bpulse) val={supply/2} td = 22ns fall = 1
+ targ v(f3out) val={supply/2} td = 22ns rise = 1

* 0b01
.measure tran atraso0b01lh
+ trig v(bpulse) val={supply/2} td = 25ns fall = 1
+ targ v(f3out) val={supply/2} td = 25ns rise = 1
.measure tran atraso0b01hl
+ trig v(bpulse) val={supply/2} td = 25ns rise = 1
+ targ v(f3out) val={supply/2} td = 25ns fall = 1

* 0b10
.measure tran atraso0b10lh
+ trig v(bpulse) val={supply/2} td = 28ns rise = 1
+ targ v(f3out) val={supply/2} td = 28ns rise = 1
.measure tran atraso0b10hl
+ trig v(bpulse) val={supply/2} td = 28ns fall = 1
+ targ v(f3out) val={supply/2} td = 28ns fall = 1

* 0b11
.measure tran atraso0b11lh
+ trig v(bpulse) val={supply/2} td = 31ns rise = 1
+ targ v(f3out) val={supply/2} td = 31ns rise = 1
.measure tran atraso0b11hl
+ trig v(bpulse) val={supply/2} td = 31ns fall = 1
+ targ v(f3out) val={supply/2} td = 31ns fall = 1

* 1b00
.measure tran atraso1b00lh
+ trig v(bpulse) val={supply/2} td = 34ns rise = 1
+ targ v(f3out) val={supply/2} td = 34ns rise = 1
.measure tran atraso1b00hl
+ trig v(bpulse) val={supply/2} td = 34ns fall = 1
+ targ v(f3out) val={supply/2} td = 34ns fall = 1

* 1b01
.measure tran atraso1b01lh
+ trig v(bpulse) val={supply/2} td = 37ns rise = 1
+ targ v(f3out) val={supply/2} td = 37ns rise = 1
.measure tran atraso1b01hl
+ trig v(bpulse) val={supply/2} td = 37ns fall = 1
+ targ v(f3out) val={supply/2} td = 37ns fall = 1

* 1b10
.measure tran atraso1b10lh
+ trig v(bpulse) val={supply/2} td = 40ns fall = 1
+ targ v(f3out) val={supply/2} td = 40ns rise = 1
.measure tran atraso1b10hl
+ trig v(bpulse) val={supply/2} td = 40ns rise = 1
+ targ v(f3out) val={supply/2} td = 40ns fall = 1

* 00c0
.measure tran atraso00c0lh
+ trig v(cpulse) val={supply/2} td = 43ns fall = 1
+ targ v(f3out) val={supply/2} td = 43ns rise = 1
.measure tran atraso00c0hl
+ trig v(cpulse) val={supply/2} td = 43ns rise = 1
+ targ v(f3out) val={supply/2} td = 43ns fall = 1

* 00c1
.measure tran atraso00c1lh
+ trig v(cpulse) val={supply/2} td = 46ns fall = 1
+ targ v(f3out) val={supply/2} td = 46ns rise = 1
.measure tran atraso00c1hl
+ trig v(cpulse) val={supply/2} td = 46ns rise = 1
+ targ v(f3out) val={supply/2} td = 46ns fall = 1

* 01c0
.measure tran atraso01c0lh
+ trig v(cpulse) val={supply/2} td = 49ns rise = 1
+ targ v(f3out) val={supply/2} td = 49ns rise = 1
.measure tran atraso01c0hl
+ trig v(cpulse) val={supply/2} td = 49ns fall = 1
+ targ v(f3out) val={supply/2} td = 49ns fall = 1

* 01c1
.measure tran atraso01c1lh
+ trig v(cpulse) val={supply/2} td = 52ns rise = 1
+ targ v(f3out) val={supply/2} td = 52ns rise = 1
.measure tran atraso01c1hl
+ trig v(cpulse) val={supply/2} td = 52ns fall = 1
+ targ v(f3out) val={supply/2} td = 52ns fall = 1

* 10c0
.measure tran atraso10c0lh
+ trig v(cpulse) val={supply/2} td = 55ns rise = 1
+ targ v(f3out) val={supply/2} td = 55ns rise = 1
.measure tran atraso10c0hl
+ trig v(cpulse) val={supply/2} td = 55ns fall = 1
+ targ v(f3out) val={supply/2} td = 55ns fall = 1

* 10c1
.measure tran atraso10c1lh
+ trig v(cpulse) val={supply/2} td = 58ns rise = 1
+ targ v(f3out) val={supply/2} td = 58ns rise = 1
.measure tran atraso10c1hl
+ trig v(cpulse) val={supply/2} td = 58ns rise = 1
+ targ v(f3out) val={supply/2} td = 58ns rise = 1

* 11c0
.measure tran atraso11c0lh
+ trig v(cpulse) val={supply/2} td = 61ns fall = 1
+ targ v(f3out) val={supply/2} td = 61ns rise = 1
.measure tran atraso11c0hl
+ trig v(cpulse) val={supply/2} td = 61ns rise = 1
+ targ v(f3out) val={supply/2} td = 61ns fall = 1

* 111d
.measure tran atraso111dlh
+ trig v(dpulse) val={supply/2} td = 64ns rise = 1
+ targ v(f3out) val={supply/2} td = 64ns rise = 1
.measure tran atraso111dhl
+ trig v(dpulse) val={supply/2} td = 64ns fall = 1
+ targ v(f3out) val={supply/2} td = 64ns fall = 1

* média do consumo dinamico
.measure tran consumo_dinamico avg(i(v1)*-v(VDD)) from=0ns to=66ns

* consumo estatico

* a000
.measure tran consumo_estaticoa000hl avg(i(v1)*-v(VDD)) from=1.97ns to=2ns
.measure tran consumo_estaticoa000lh avg(i(v1)*v(VDD)) from=2.97ns to=3ns

* a001
.measure tran consumo_estaticoa001hl avg(i(v1)*v(VDD)) from=4.97ns to=5ns
.measure tran consumo_estaticoa001lh avg(i(v1)*v(VDD)) from=5.97ns to=6ns

* a010
.measure tran consumo_estaticoa010hl avg(i(v1)*v(VDD)) from=7.97ns to=8ns
.measure tran consumo_estaticoa010lh avg(i(v1)*-v(VDD)) from=8.97ns to=9ns

* a011
.measure tran consumo_estaticoa011hl avg(i(v1)*v(VDD)) from=10.97ns to=11ns
.measure tran consumo_estaticoa011lh avg(i(v1)*-v(VDD)) from=11.97ns to=12ns

* a100
.measure tran consumo_estaticoa100hl avg(i(v1)*v(VDD)) from=13.97ns to=14ns
.measure tran consumo_estaticoa100lh avg(i(v1)*v(VDD)) from=14.97ns to=15ns

* a101
.measure tran consumo_estaticoa101hl avg(i(v1)*v(VDD)) from=16.97ns to=17ns
.measure tran consumo_estaticoa101lh avg(i(v1)*v(VDD)) from=17.97ns to=18ns

* a110
.measure tran consumo_estaticoa110hl avg(i(v1)*v(VDD)) from=19.97ns to=20ns
.measure tran consumo_estaticoa110lh avg(i(v1)*-v(VDD)) from=20.97ns to=21ns

* 0b00
.measure tran consumo_estatico0b00hl avg(i(v1)*v(VDD)) from=22.97ns to=23ns
.measure tran consumo_estatico0b00lh avg(i(v1)*v(VDD)) from=23.97ns to=24ns

* 0b01
.measure tran consumo_estatico0b01hl avg(i(v1)*v(VDD)) from=25.97ns to=26ns
.measure tran consumo_estatico0b01lh avg(i(v1)*v(VDD)) from=26.97ns to=27ns

* 0b10
.measure tran consumo_estatico0b10hl avg(i(v1)*-v(VDD)) from=28.97ns to=29ns
.measure tran consumo_estatico0b10lh avg(i(v1)*v(VDD)) from=29.97ns to=30ns

* 0b11
.measure tran consumo_estatico0b11hl avg(i(v1)*-v(VDD)) from=31.97ns to=32ns
.measure tran consumo_estatico0b11lh avg(i(v1)*v(VDD)) from=32.97ns to=33ns

* 1b00
.measure tran consumo_estatico1b00hl avg(i(v1)*-v(VDD)) from=34.97ns to=35ns
.measure tran consumo_estatico1b00lh avg(i(v1)*v(VDD)) from=35.97ns to=36ns

* 1b01
.measure tran consumo_estatico1b01hl avg(i(v1)*-v(VDD)) from=37.97ns to=38ns
.measure tran consumo_estatico1b01lh avg(i(v1)*v(VDD)) from=38.97ns to=39ns

* 1b10
.measure tran consumo_estatico1b10hl avg(i(v1)*-v(VDD)) from=40.97ns to=41ns
.measure tran consumo_estatico1b10lh avg(i(v1)*v(VDD)) from=41.97ns to=42ns

* 00c0
.measure tran consumo_estatico00c0hl avg(i(v1)*-v(VDD)) from=43.97ns to=44ns
.measure tran consumo_estatico00c0lh avg(i(v1)*v(VDD)) from=44.97ns to=45ns

* 00c1
.measure tran consumo_estatico00c1hl avg(i(v1)*-v(VDD)) from=46.97ns to=47ns
.measure tran consumo_estatico00c1lh avg(i(v1)*v(VDD)) from=47.97ns to=48ns

* 01c0
.measure tran consumo_estatico01c0hl avg(i(v1)*-v(VDD)) from=49.97ns to=50ns
.measure tran consumo_estatico01c0lh avg(i(v1)*v(VDD)) from=50.97ns to=51ns

* 01c1
.measure tran consumo_estatico01c1hl avg(i(v1)*v(VDD)) from=52.97ns to=53ns
.measure tran consumo_estatico01c1lh avg(i(v1)*v(VDD)) from=53.97ns to=54ns

* 10c0
.measure tran consumo_estatico10c0hl avg(i(v1)*v(VDD)) from=55.97ns to=56ns
.measure tran consumo_estatico10c0lh avg(i(v1)*v(VDD)) from=56.97ns to=57ns

* 10c1
.measure tran consumo_estatico10c1hl avg(i(v1)*v(VDD)) from=58.97ns to=59ns
.measure tran consumo_estatico10c1lh avg(i(v1)*v(VDD)) from=59.97ns to=60ns

* 11c0
.measure tran consumo_estatico11c0hl avg(i(v1)*-v(VDD)) from=61.97ns to=62ns
.measure tran consumo_estatico11c0lh avg(i(v1)*v(VDD)) from=62.97ns to=63ns

* 111d
.measure tran consumo_estatico111Dhl avg(i(v1)*v(VDD)) from=64.97ns to=65ns
.measure tran consumo_estatico111Dlh avg(i(v1)*v(VDD)) from=65.97ns to=66ns

.end
