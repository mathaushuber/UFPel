.text
######## Armazenando constantes
ori $t4, $zero, 8 #t4 = 8
ori $t5, $zero, -4 #t5 = -4
ori $t6, $zero, 6 #t6 = 6
######## Armazenando variáveis
ori $t1, $zero, 2 #testando variável x com valor de 2
ori $t2, $zero, 2 #testando variável y com valor de 2
ori $t3, $zero, 2 #testando variável z com valor de 2
######## Calculando equação
mult $t4, $t1 #8*x 
mflo $t4 #t4 = 16
mult $t5, $t2 #4*y
mflo $t5 #t5 = -8
mult $t6, $t3 #6*z
mflo $t6 #t6 = 12
add $t1, $t4, $t5 #t1 = 8x - 4y
add $t0, $t1, $t6 #t0 = 8x - 4y + 6z = (20)
