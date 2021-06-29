.data
escolha: .asciiz "1. Área da circunferência 2. Área do Triangulo 3. Área do Retângulo: "
doEscolha: .asciiz "\nDeseja saber outra área? 1. Menu - 2. Sair: "
valorR: .asciiz "Raio da circunferência: "
valorA: .asciiz "Base: "
valorB:	.asciiz "Altura: "
resultado: .asciiz "A área será: "

.text
	#leitura da escolha
.main:	li $v0, 4
	la $a0, escolha
	syscall
	
	li $v0, 5
	syscall
	
	move $t0, $v0
#tratando as opções (menu)
menu: 	ori $t1, $zero, 1
	ori $t2, $zero, 2
	ori $t3, $zero, 3
	beq $t0, $t1, circunferencia
	beq $t0, $t2, triangulo
	beq $t0, $t3, retangulo
	bne $t0, $t1, .main
	beq $t0, $t2, .main
	beq $t0, $t3, .main
circunferencia:	
	#leitura do raio
	li $v0, 4
	la $a0, valorR
	syscall
	
	li $v0, 5
	syscall
	
	move $t0, $v0
	#calculando a área
	ori $t9, $zero, 3 #pi, arredondei para baixo o pi, como não estamos usando float na disciplina
	mult $t0, $t0 #r²
	mflo $t0
	mult $t0, $t9
	mflo $t5
#imprimindo o resultado na tela
imprimeAc:	li $v0, 4
		la $a0, resultado
		syscall
		
		li $v0, 1
		move $a0, $t5
		syscall
		j options
triangulo:	ori $t9, $zero, 2
		#leitura da base
		li $v0, 4
		la $a0, valorA
		syscall
	
		li $v0, 5
		syscall
		
		move $t0, $v0
		#leitura da altura
		li $v0, 4
		la $a0, valorB
		syscall
	
		li $v0, 5
		syscall
		
		move $s0, $v0
		#calculando a área
		mult $t0, $s0
		mflo $t0
		div $t0, $t9
		mflo $t0
imprimeAt:	li $v0, 4
		la $a0, resultado
		syscall
		
		li $v0, 1
		move $a0, $t0
		syscall
		j options
retangulo:	#leitura da base
		li $v0, 4
		la $a0, valorA
		syscall
	
		li $v0, 5
		syscall
		
		move $t0, $v0
		#leitura da altura
		li $v0, 4
		la $a0, valorB
		syscall
	
		li $v0, 5
		syscall
		
		move $s0, $v0
		#calculando a área
		mult $t0, $s0
		mflo $t0
		#imprimindo na tela
imprimeAr:	li $v0, 4
		la $a0, resultado
		syscall
		
		li $v0, 1
		move $a0, $t0
		syscall
		j options
options:	#Aqui fiz uma analogia ao do while, para ficar legal, depois que o usuário recebe o resultado da área ele tem a opção de seguir no programa calculando outras áreas ou sair
		#leitura da escolha secundária
		ori $s7, $zero, 1
		li $v0, 4
		la $a0, doEscolha
		syscall
	
		li $v0, 5
		syscall
	
		move $s6, $v0
		beq $s6, $s7, .main
fim:		nop