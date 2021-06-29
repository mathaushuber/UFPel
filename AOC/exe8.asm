.data
a: .word 2
b: .word 4
c: .word 8

.text
ori $t0, $zero, 0x1001 #t0 = 0x1001
sll $t0, $t0, 16 
lw $t1, 0($t0)
lw $t2, 4($t0)
lw $t3, 8($t0)
ori $t4, $zero, 0xd000 #t4 = 0xd000
add $t5, $t0, $t4 #t5 = 0x1001 + 0xd000
#Como há uma quantidade ímpar de valores numéricos, a mediana vai ser o valor central do conjunto numérico, no nosso caso a mediana de 2, 4, 8 é 4
#como o nosso n=3 é um valor ímpar, só fiz a colocação do valor 4 na posição de memória 0x1001D000.
sw $t2, 0($t5)
