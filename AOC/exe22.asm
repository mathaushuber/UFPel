.data 
vetor: .word 1, 2, 3, 4, 5

.text
	la $s1, vetor #inicializando ponteiro para o vetor
	addi $s2, $s1, 16 #s2 = 0x10010000 + 16
	ori $s6, $zero, 2 #s6 = 2
loop:	beq $s6, $s7, fim #condicional para o número de iterações, nesse caso duas, quando o contador s6 == s7 pula para o fim
	lw $t5, 0($s1) #lendo a primeira posição do vetor na memória de dados
	lw $t6, 0($s2) #lendo a última posição do vetor na memória de dados
	move $t9, $t5 #movendo o primeiro valor do vetor para um registrador auxiliar t9, na segunda iteração o segundo valor vai para o lugar do penultimo, e assim por diante
	move $t5, $t6 #movendo o ultimo valor do vetor para o registrador que contém o primeiro valor do vetor
	sw $t5, 0($s1) #sobrescrevendo, o último valor do vetor passa para o primeiro
	sw $t9, 0($s2) #o valor da variável auxiliar passa para s2
	addi $s1, $s1, 4 #incrementando o ponteiro do inicio do vetor
	subi $s2, $s2, 4 #decrementando o ponteiro do final do vetor
	addi $s7, $s7, 1 #incrementando o contador
	j loop 
fim: 	nop