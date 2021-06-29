#-----------FLAGS-----------
#	s5 = ímpares entre 100 a 200 a cada iteração
#	t0 = contador i
.text
	addi $t0, $zero, 99 #t0 = 99
	lui $s1, 0x1001
	ori $t2, $zero, 1 #t2 = 1
	ori $s0, $zero, 2 #s0 = 2 => divisor por 2
main:	addi $t0, $t0, 1 #contador i dos números
	slti $t3, $t0, 200 #se t0 < 200 então t3 = 1, senão t3 = 0
	beq $t3, $s6, fim #se t3 == s6, observe que s6 tem 0 por padrão, pois não alteramos seu registrador, não quis adicionar mais uma instrução até mesmo pq seria uma redundância
#e se tratando de desempenho, busquei fazer com apenas as instruções necessárias, almejando otimizar ao máximo
	div $t0, $s0 #divisão de n/2 para saber se é par
	mfhi $t4 #armazenando o resto em t4
	bne $t4, $s6, impar #lembrando que s6 tem 0, então sempre que for par t4 vai ter 0 no registrador, pois é onde se encontra o resto da divisão, dessa forma t4!=s6 e teremos um ímpar
	beq $t4, $s6, main #senão, volta para o label principal
impar:	addi $t1, $t1, 1 #contador j dos impares
	or $s5, $zero, $t0 #movendo o valor do registrador t0 para o registrador s5
	ori $t5, $zero, 0x1001 #t5 = 1001
	sll $t5, $t5, 16 #shift esquerdo lógico 
	beq $t1, $t2, pulareg #aqui só fiz um condicional, para caso esteja na primeira iteração, pule uma instrução, essa instrução justamente é a escrita na memória, como vou adicionando
#4 ao valor 0x1001 ele vai escrevendo nas posições seguintes, porém quando estamos na primeira iteração, não queremos adicionar 4, pois o primeiro valor da memória é 0x10010000, se fizessemos
#isso acabaríamos pulando a primeira posição, então criei esse condicional apenas para pular essa instrução, se estiver na primeira iteração
	addi $t9, $t9, 4 #t9 = t9 + 4, pulando de 4 em 4
base:	add $t5, $t5, $t9 #0x10010000 + t9, ou seja a cada iteração pula uma posição na memória
	sw $s5, 0($t5) 
	j main
pulareg: j base
fim:	nop

	
