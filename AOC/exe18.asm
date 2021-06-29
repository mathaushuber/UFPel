#-----------FLAGS-----------
#	t0 = contador i (números de 1 a 10)
#	s4 = contador j (números pares)
#	t3 = contador k (números ímpares)
#	s3 = resultado da soma dos números ímpares
#	t6 = resultado da soma dos números pares
#	t7 = resultado da média dos ímpares	
.text
main:	addi $t0, $t0, 1 #contador i
	ori $t9, $zero, 1 #t9 = 1
	ori $t4, $zero, 2 #t7, divisor por 2, para futuramente saber se é par
	slti $s0, $t0, 11 #se t0 < 11 então s0 = 1, senão s0 = 0
	beq $s0, $t9, verify #se s0 == t9 então pula para verify
	bne $s0, $t9, fim #senão fim do programa
verify:	div $t0, $t4 #divisão do contador i por 2
	mfhi $t1 #resto em t1
	beq $t1, $t8, par #se o resto for igual a 0, então é par, pula para o label par
	bne $t1, $t8 impar #senão, é impar, pula para o label ímpar
par:	addi $s4, $s4, 1 #contador j do par
	or $t5, $zero, $t0 #movendo o contador i em t0 para o registrador t5
	add $t6, $t6, $t5 # s2 = fazendo a soma dos números ímpares
	j main
impar:  ori $s7, $zero, 5
	addi $t3, $t3, 1 #contador k do impar
	or $s2, $zero, $t0 #movendo o contador i em t0 para o registrador t6
	add $s3, $s3, $s2 # s3 = fazendo a soma dos números ímpares
	beq $t3, $s7, media #se t3 == s7, ou seja na ultima iteração onde já temos todas as somas dos números ímpares, fazemos a divisão para achar a média
	j main
media:	div $s3, $s7
	mflo $t7
	j main
fim:	nop	