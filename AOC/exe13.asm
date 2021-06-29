#-----------FLAGS-----------
#	t1 = 0 par,
#       t1 = 1 ímpar 
#       t2 = 0 zero,
#       t2 = 1 positivo
#       t2 = 2 negativo
.data
.word -13

.text
main:	lui $t9, 0x1001
	lw $s0, 0($t9) #s0 = 4
	ori $t8, $zero, 0 #t8 = 0
	ori $t9, $zero, 1 #t9 = 1
	ori $t7, $zero, 2 #t7, divisor por 2, para futuramente saber se é par
	div $s0, $t7 #divisão numero por 2/4 = resto 0 = par
	mfhi $t5 #t5 = resto
	beq $t8, $t5, par #se t5 == 0 (resto), cairá no condicional $t5 == $t8 e irá para o label par 
	bne $t8, $t5, impar#se t5 != 0 (resto), cairá no condicional $t5 != $t8 e irá para o label impar, basicamente um else 
obs:	beq $s0, $t8, ZERO #se s0 == t8 pula pra label ZERO
	slti $t3, $s0, 0 #se s0 < 0 então t3 = 1, senão t3 = 0
	beq $t3, $t9, NEGAT #se t3 == t9 então pula para label NEGAT
	bne $t3, $t9, POSIT #se t3 != t9 então pula para label POSIT, basicamente um else
par:	ori $t1, $zero, 0,
	j obs
impar:	ori $t1, $zero, 1
	j obs
ZERO:	ori $t2, $zero, 0
	j fim
POSIT:	ori $t2, $zero, 1
	j fim
NEGAT:	ori $t2, $zero, 2
	j fim
fim: 	nop