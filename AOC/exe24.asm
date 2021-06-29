#-----------FLAGS-----------
#	s0 = VALOR 1
#	s1 = VALOR 2
#	s2 = VALOR 3
#	t5 = Média dos três valores
.data

valor1: .asciiz "Primeiro número: "
valor2: .asciiz "Segundo número: "
valor3: .asciiz "Terceiro Número: "

.text
#leitura do primeiro número
	li $v0, 4
	la $a0, valor1
	syscall
	
	li $v0, 5
	syscall
	
	move $s0, $v0
#leitura do segundo número
	li $v0, 4
	la $a0, valor2
	syscall
	
	li $v0, 5
	syscall
	
	move $s1, $v0
#leitura do terceiro número
	li $v0, 4
	la $a0, valor3
	syscall
	
	li $v0, 5
	syscall
	
	move $s2, $v0
#Calculando a média
media:	add $t1, $s0, $s1
	add $t1, $t1, $s2
	ori $t4, $zero, 3
	div $t1, $t4
	mflo $t5
	