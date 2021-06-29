#-----------FLAGS-----------
#	t1 = 0 REPROVADO
#	t1 = 1 EXAME
#	t1 = 2 APROVADO
.data
.word 3

.text
main:   lui $t7, 0x1001
	lw $t0, 0($t7) #t0 = 8
	ori $t8, $zero, 1
	slti $t2, $t0, 3 #se t0 < 3 então t2 = 1, senão t2 = 0 
	beq $t2, $t8, REPROV #se t2 == t8 então pula para label REPROV
	slti $t2, $t0, 7 #se t0 < 7 então t2 == 1, senão t2 == 0
	beq $t2, $t8, EXAME #se t2 == t8 então pula para label EXAME
	slti $t2, $t0, 11 #se t0 < 11 então t2 == 1, senão t2 == 0
	beq $t2, $t8, APROV #se t2 == t8 então pula para label APROV
REPROV: ori $t1, $zero, 0,
	j fim
EXAME: 	ori $t1, $zero, 1,
	j fim
APROV:	ori $t1, $zero, 2,
	j fim
fim: 	nop 