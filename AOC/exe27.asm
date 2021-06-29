#	Soma dos números pares, no endereço 0x10010040
#	Cada número par de 1 até N a partir do endereço 0x10010044
.data
N: .asciiz "Número de valores: "
S: .asciiz "Soma dos pares: "
Q: .asciiz "\nTotal de números pares: "

.text
	ori $t1, $zero, 1
	ori $t2, $zero, 2
	ori $s1, $zero, 4
	#leitura de N
.main:	li $v0, 4
	la $a0, N
	syscall
	
	li $v0, 5
	syscall
	
	move $t0, $v0
loop:	addi $t9, $t0, 1
	slt $s7, $t1, $t9
	beq $s7, $zero, imprimeSoma
	div $t1, $t2
	mfhi $s6
	beq $s6, $zero, soma
	addi $t1, $t1, 1
	j loop
soma:	add $t8, $t1, $t8
	lui $s3, 0x1001
	ori $t7, 0x00000040
	add $s3, $s3, $t7
	sw $t8, 0($s3)
	j total
total:	add $s4, $s3, $t7
	add $s4, $s3, $s1
	sw $t1, 0($s4) 
	addi $t1, $t1, 1
	addi $s5, $s5, 1
	addi $s1, $s1, 4
	j loop
imprimeSoma:	li $v0, 4
		la $a0, S
		syscall
		
		li $v0, 1
		move $a0, $t8
		syscall
imprimeTotal:	li $v0, 4
		la $a0, Q
		syscall
		
		li $v0, 1
		move $a0, $s5
		syscall