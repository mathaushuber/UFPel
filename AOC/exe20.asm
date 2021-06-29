.data
string: .asciiz "eu sou aluno do centro de desenvolvimento tecnologico da ufpel."

#Lógica é simples, percorro a string e toda vez que encontrar um espaço, adiciono um byte no ponteiro, assim ele pegará o próximo caracter e subtraio 32 do valor desse ponteiro
#pois todo caracter minusculo subtraido de 32 é o seu correspondente capitalizado, de acordo com a tabela ascii	
.text
	la $t1, string
	ori $t9, $zero, 1
	ori $t8, $zero, 32 #t8 = espaço
	#capitalizando a primeira letra
	lbu $t2, 0($t1) 
	sub $t2, $t2, $t8
	sb $t2, 0($t1)
loop:	lbu $t2, 0($t1)
	addi $t1, $t1, 1
	beq $t2, $zero, fim #se for nula, pula pro fim
	beq $t2, $t8, CAPITALIZAR
	j loop
CAPITALIZAR:	lbu $t2, 0($t1)
		sub $t2, $t2, $t8
		sb $t2, 0($t1)
		j loop
fim:	nop