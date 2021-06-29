.data
.word 22 #endereço 0x10010000
.word 15 #endereço 0x10010004
.word 30 #endereço 0x10010008
.word -212 #endereço 0x1001000c
.word 436 #endereço 0x10010010

.text
ori $t0, $zero, 0x1001
sll $t0, $t0, 16
lw $t1, 0($t0)
lw $t2, 4($t0)
lw $t3, 8($t0)
lw $t4, 12($t0)
lw $t5, 16($t0) 
add $t6, $t1, $t2 #t5 = 22 + 15 = 37
add $t7, $t3, $t4 #t6 = 30 - 212 = -182
add $t6, $t6, $t7 #t6 = 37 - 182 = -145
add $s1, $t6, $t5 #t7 = -145 + 436 = 291
#SOMATÓRIO DOS VALORES EM s1
ori $t6, $zero, 5
div $s1, $t6 #291/5
mflo $s0 #quociente da divisão
mfhi $t6 #resto
#VALOR MÉDIO DOS VALORES EM s0
mult $t1, $t2 #22 * 15
mflo $t6 #t6 = 330
mult $t3, $t4 # 30 * -212
mflo $t7 #t7 = -6.360
mult $t6, $t7 #330 * 6.360
mflo $t7 #t7 = -2098800
mult $t7, $t5 #436 * -2098800
#PRODUTO DOS VALORES EM s2
mflo $s2