#-----------FLAGS-----------
#	t1 = 1 INFANTIL
#	t1 = 2 ADULTO
.data
.word 22

.text
main:	lui $t9, 0x1001
	lw $s0, 0($t9) #s0 = 22 (idade)
	ori $t8, $zero, 1 #t8 = 1
	slti $t2, $s0, 6 #se s0 < 6 então t2 = 1, senão t2 = 0
	beq $t2, $t8, fim #se t2 == t8, idade < 6, então ele não será infantil nem adulto, portanto o registrador t1 será 0, bastando pular para o fim
	slti $t2, $s0, 17 #se s0 < 17 então t2 = 1, senão t2 = 0
	beq $t2, $t8, INFANT #se t2 == t8 então 6 <= idade <= 17, pula para label INFANT
	slti $t2, $s0, 18 #se s0 < 18 então t2 = 1, senão t2 = 0
	bne $t2, $t8, ADULTO #se t2 != t8 então idade >= 18, pula para label ADULTO
INFANT: ori $t1, $zero, 1,
	j fim
ADULTO: ori $t1, $zero, 2,
	j fim
fim:	nop