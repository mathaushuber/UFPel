.data

numberFat: .asciiz "Qual fatorial você deseja? "
resultado: .asciiz "Resultado: "

.text
#leitura do número
	li $v0, 4
	la $a0, numberFat
	syscall
	
	li $v0, 5
	syscall
	
	move $t0, $v0
#Calculando o seu fatorial
		move $s0, $t0 
		ori $t1, $zero, 1
		ori $t7, $zero, 1
calculaFat:	beq $t0, $t1, imprime
		sub $t2, $t0, $t7
		mult $s0, $t2
		mflo $s0
		addi $t7, $t7, 1
		addi $t1, $t1, 1
		j calculaFat
#imprimindo o resultado na tela
imprime:	li $v0, 4
		la $a0, resultado
		syscall
		
		li $v0, 1
		move $a0, $s0
		syscall