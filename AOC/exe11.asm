#-----------FLAGS-----------
#	t0 = 0 ZERO
#	t0 = 1 POSITIVO
#	t0 = 2 NEGATIVO
.data
.word -10

.text
main:	lui $t5, 0x1001
	lw $t2, 0($t5) #t2 = 10
	beq $t3, $t2, ZERO #if t3 == t2 pula pra label ZERO
	ori $t7, $zero, 1 #adicionei 1 ao registrador t7, para fazer o condicional slti
	slti $t0, $t2, 0 #if t5 < 0, ou seja, negativo, coloca 1 em t0, senão coloca 0 em t0
	beq $t0, $t7, NEGATIVO #if t0 == t1, pula para label NEGATIVO, ou seja, registrador t0 é o destino do nosso condicional slti, onde vai colocar 1, caso negativo, e zero caso positivo
	#então aquela instução ori que coloquei na linha 8 para o registrador t7, foi justamente para testar o condicional da linha 10, onde fizemos um se t0 == t1 pula pra label NEGATIVO 
	bne $t0, $t7, POSITIVO #if t0 != t1, ou seja, t0 = 0, pois t7 vai ser sempre igual a 1, pois coloquei aquele valor anteriormente através do ori, onde o nosso slti cai no else, ou seja, t5 > 0
	#sendo assim positivo, e t0 = 0, então pulamos para o label POSITIVO 
ZERO:   ori $t0, $zero, 0,
	j fim
POSITIVO: ori $t0, $zero, 1,
	  j fim
NEGATIVO: ori $t0, $zero, 2,
	  j fim
fim: nop