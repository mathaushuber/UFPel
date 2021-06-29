#-----------FLAGS-----------
#	s6 = resultado da taboada a cada iteração
#	s0 = contador i
.data
.word 5

.text
	lui $t1, 0x1001
	lw $t0, 0($t1)
	ori $t9, $zero, 1 #t9 = 1
	slti $t2, $t0, 11 #se t1 < 10, então t2 = 1, senão t2 = 0
	slti $t3, $t0, 1 #se t1 < 1, então t3 = 1, senão t3 = 0
	beq $t3, $t9, fim #se t3 == t9 número é menor que 1, pula para o fim
	bne $t2, $t9, fim #se t2 != t9 número é maior que 10, pula para o fim
main:	addi $s0, $s0, 1 #contador i
	slti $t8, $s0, 11 #enquanto contador menor que 11, t8 = 1, senão t8 = 0
	beq $t8, $t9, taboa #se t8 == 1 significa que o contador ainda é menor que 11, então pula para a taboada
	bne $t8, $t9, fim #senão, pula para o fim
taboa:	addi $t5, $t5, 1 #contador auxiliar
	mult $t0, $s0 #número*contador, no nosso caso, 5*i
	mflo $s6 #resultado armazenado em s6
	ori $s5, $zero, 0x1001 #s5 = 1001
	sll $s5, $s5, 16 #shift lógico esquerdo
	beq $t5, $t9, pulareg #condicional para pular a próxima instrução, caso esteja na primeira iteração
	addi $t4, $t4, 4 #t4 = t4 + 4
base:	add $s5, $s5, $t4 #s5 = 0x1001 + t4
	sw $s6, 0($s5) 
	j main
pulareg: j base
fim: 	nop