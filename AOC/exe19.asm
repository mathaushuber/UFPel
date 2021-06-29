.data
str: .asciiz "Eu passarei na disciplina de AOC-I."

#A lógica é simples, criei um ponteiro para o caracter atual, e um ponteiro para o próximo, e fui iterando, se o caracter atual for um espaço, sobrescrevo ele(atual) com o próximo
#e posteriormente, movo o próximo com o seguinte, e assim por diante, até encontrar o caracter "." que indica o final da string, quando encontro o caracter final, sobrescrevo o resto com \0.
#É necessário sobrescrever, visto que, com espaço, antes tínhamos um total de 35 caracteres, como removemos os espaços movendo os caracteres posteriores para o seu lugar, na memória, ainda
#teremos os 35 caracteres, e a nossa string por consequencia da remoção dos espaços diminuiu, restando os outros 5 caracteres como lixo, então simplesmente adicionei \0 ao final.

.text
main:	lui $t3, 0x1001
	lui $t4, 0x1001
        ori $s1, $zero, 32 #s1 = 32, espaço em decimal
        ori $t8, $zero, 1
        ori $s4, $zero, 4
        ori $s7, $zero, 46 #s7 = 46, "." ponto em decimal
        add $t4, $t4, $t8
loop:	lbu $t2, 0($t3) #lendo caracter
	lbu $t7, 0($t4) #lendo próximo caracter
	beq $t2, $zero, fim #se for nula, pula pro fim
	beq $t2, $s1, mover #se for espaço pula para mover
	sb $t2, 0($t3) #se não for, apenas copia a string novamente
	add $t3, $t3, $t8 #contador i onde aponta para o caracter atual
	add $t4, $t4, $t8 #contador j, onde aponta para o pŕoximo caracter
	j loop 
mover: 	move $t2, $t7 #caso for espaço, move o próximo caracter da string no lugar
	sb $t2, 0($t3) #subscrevendo na memória de dados, onde era espaço passou a ser o próximo caracter
	add $t3, $t3, $t8 #incrementando contador i que aponta para o caracter atual
	add $t4, $t4, $t8 #incrementando contador j que aponta para o pŕoximo caracter
	lbu $t7, 0($t4) #lendo o próximo carcater da memória
	beq $t2, $zero, ponto #se for "." vai para ponto
	beq $t7, $s1, move2 #se o próximo caracter for um espaço pula para mover2, onde faço a mesma lógica, apenas pulando o número de casas necessárias para sobrescrever o espaço
	bne $t2, $s1, mover#se for diferente de espaço, segue o loop
	j move2
move2:	add $t4, $t4, $t8 #incrementando contador j que aponta para o pŕoximo caracter
	lbu $t7, 0($t4) #lendo o próximo carcater da memória de dados
	move $t2, $t7 #movendo o valor do próximo com o valor do atual
	sb $t2, 0($t3) #sobrescrevendo na memória 
	add $t3, $t3, $t8 #incrementando contador i que aponta para o caracter atual
	add $t4, $t4, $t8 #incrementando contador j que aponta para o pŕoximo caracter
	lbu $t7, 0($t4) #lendo o próximo caracter da memória de dados
	beq $t2, $zero, fim #se for nula, pula pro fim
	j mover
ponto:	beq $s5, $s4, fim #iterei 4 vezes para sobrescrever com \0 como uma word, através de um sw, só que aqui usei 4 vezes o sb 
	sb $zero, 0($t3)
	add $t3, $t3, $t8 
	addi $s5, $s5, 1
	j ponto
fim: nop


