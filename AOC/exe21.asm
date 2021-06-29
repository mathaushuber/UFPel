#-----------FLAGS-----------
#	t0 = 0 NÃO ORDENADO
#	t1 = 1 ORDENADO
.data
tamanho: .word 10
vetor:	 .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

#Lógica: percorro o vetor até o contador for menor ou igual ao seu tamanho, se o elemento atual for menor que o próximo elemento o registrador flag t0 recebe 1 a cada iteração,
#caso o elemento atual for maior que o próximo o vetor não é ordenado e a flag t0 = 0
.text
	la $s0, tamanho #inicializando ponteiro para o tamanho do vetor
	la $s1, vetor #inicializando ponteiro para o vetor
	lw $s0, tamanho #lendo o conteudo do ponteiro, (tamanho do vetor)
	ori $t8, $zero, 4 #t8 = 4
	ori $s7, $zero, 8 #s7 = 8
	lui $t9, 0x1001 #t9 = 0x1001
	add $t9, $t9, $s7 #t9 = 0x10010008
loop:	slt $t1, $t2, $s0 #if t2 < s0 -> t1 = 1 senão t1 = 0
	beq $t1, $zero, fim 
	lw $t5, 0($s1) #t5 = valor da memória, elemento atual
	lw $t6, 0($t9) #t6 = valor da memória elemento posterior
	beq $t6, $zero, fim #se o valor posterior for zero, fim do loop, pula para o fim
	slt $t0, $t5, $t6 #if t5 < t6 -> t0 = 1 senão t0 = 0
	beq $t0, $zero, fim #se t0 == 0 significa que o conteúdo do ponteiro prox é maior do que o conteudo do ponteiro atual, logo não são ordenados, pula para o fim
	add $s1, $s1, $t8 #incrementa o contador i do elemento atual
	add $t9, $t9, $t8 #incrementa o contador j do elemento proximo
	j loop
fim: nop