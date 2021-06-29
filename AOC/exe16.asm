#-----------FLAGS-----------
#	s1 = resultado do fatorial
#	t8 = contador i
#	t5 = contador j
#	OBS: Costumo dar nome aos registradores como se fossem variáveis apenas para entender melhor o código na hora de desenvolver, ao exemplo de contador i, j, etc...
.data
.word 6

.text
	lui $t9, 0x1001
	lw $s0, 0($t9) #s0 = valor da memória
	ori $t0, $zero, 1 #t0 = 1
	sub $t2, $s0, $t0 #t2 = s0 - t0, ou melhor n-1, que é até onde vamos fazer o nosso loop
main:	addi $t8, $t8, 1 #contador i
	slt $t1, $t2, $t8 #se s0 < t8, então t1 = 1, senão t1 = 0
	bne  $t1, $t0, MULTI #se t1 == t0, significa que t1 ainda é menor que quatro, então pula para a multiplicação
	beq $t1, $t0, fim #senão, pula para o fim
MULTI: 	addi $t5, $t5, 1 #contador j
	sub $t3, $s0, $t5, #subtraindo o numero original da variavel contador ex: i=1 => 4-1 i=2 => 4-2
	bne $t0, $t5, fat #se t5 != t0, significa que não estamos na primeira iteração, ai faremos a multiplicação do valor contido no registrador s1, com o registrador t3
#que recebeu anteriormente a subtração do nosso valor inicial, nesse caso 6, com o contador. observe que se não fizessemos esse condicional na primeira iteração poderíamos fazer algo
#do tipo 4*4, que é algo que não nos interessa, e nosso algoritmo não seria de um fatorial.
	mult $s0, $t3, #multiplicando n*n-1
	mflo $s1 #s1 = n*n-1
	j main
fat:	mult $s1, $t3 #n*n-i
	mflo $s1 #s1 = multiplicação do fatorial n*n-i
	j main
fim: nop
	