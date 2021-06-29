.data
tamanho: .word 7
vetor1: .word -30, -23, 56, -43, 72, -18, 71
vetor2: .word 45, 23, 21, -23, -82, 0, 69
soma: .word 0, 0, 0, 0, 0, 0, 0

.text
	la $t0, tamanho #inicializando ponteiro para o tamanho vetor
	la $t1, vetor1 #inicializando ponteiro para o vetor1
	la $t2, vetor2 #inicializando ponteiro para o vetor2
	la $s0, soma #inicializando ponteiro para o vetor que resulta na soma
	lw $s1, tamanho #lendo o tamanho do vetor
loop:	slt $t9, $t8, $s1 #if t8 < s1 -> t9 = 1, else t9 = 0
	beq $t9, $zero, fim #se t9 == 0 pila para o fim
	lw $t3, 0($t1) #lendo o conteúdo do vetor 1
	lw $t4, 0($t2) #lendo o conteúdo do vetor 2
	add $t5, $t3, $t4 #somando o valor dos dois vetores soma[i] = vetor1[i] + vetor2[i]
	sw $t5, 0($s0) #escrevendo a soma na memória de dados
	addi $t1, $t1, 4 #incrementando o endereço da memória do vetor1
	addi $t2, $t2, 4 #incrementando o endereço da memória do vetor2
	addi $s0, $s0, 4 #incrementando o endereço da memória do vetor soma
	addi $t8, $t8, 1 #incrementando o contador
	j loop
fim: nop 