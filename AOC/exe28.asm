.data
escolha: .asciiz "(1). Fatorial (2). Fibonnacci "
doEscolha: .asciiz "\nDeseja calcular novamente? 1. Menu - 2. Sair: "
numberFat: .asciiz "Fatorial de: "
numberFib: .asciiz "Fibonnacci de: "
resultado: .asciiz "Resultado: "

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
	beq $t0, $t1, fat
	beq $t0, $t2, calcFib
	bne $t0, $t1, .main
	beq $t0, $t2, .main
#fibbonacci recursivo
calcFib:	li $v0, 4
    		la $a0, numberFib
    		syscall

    		li $v0, 5
    		syscall
    		move $t4, $v0

    		addi $t1, $0, 1
    		addi $t2, $0, 1
    		addi $t3, $0, 1

    		ble	$t4, 2, ret
    		addi $t4, $t4, -2
    		jal fib
fib:	addi $t4, $t4, -1
    	move $t1, $t2
    	move $t2, $t3
    	add $t3, $t1, $t2
    	beq	$t4, 0, ret
    	jal fib
ret:	li $v0, 4
    	la $a0, resultado
    	syscall

    	li $v0, 1
    	move $a0, $t3
    	syscall

    	jal options
#fatorial recursivo
fat:	li $v0,4
	la $a0,numberFat
	syscall  
	   
	li $v0,5
	syscall
	
	move $a0,$v0     	     
	move $s0,$a0
	li $s7,1
	li $s3,1  
loop:
	beq $s0,$s7,mostraFat
	mul $s3,$s3,$s0
	subi $s0, $s0, 1		     
	     
	j loop
mostraFat:   
	     mflo $t9
	     li $v0,4
	     la $a0,resultado
	     syscall
	     
	     li $v0,1
	     move $a0,$t9
	     syscall
	     jal options
options:	ori $s7, $zero, 1
		li $v0, 4
		la $a0, doEscolha
		syscall
	
		li $v0, 5
		syscall
	
		move $s6, $v0
		beq $s6, $s7, .main
fim:	nop
	     