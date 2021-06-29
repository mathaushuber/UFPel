.text
#Armazenando a variável x
ori $t5, $zero, 2 #t5 = x = (2)
#Armazenando constantes
addi $t0, $zero, 3 #t0 = 3
addi $t1, $zero, -5 #t1 = -5
addi $t2, $zero, 7#t2 = 7
#Calculando a equação
mult $t5, $t5 #x^2 = (4)
mflo $t6 #t6 = x^2 = (4)
mult $t1, $t5 #-5*2 = -5x
mflo $t1 #t1 = -5x = (-10)
mult $t0, $t6 #3*x^2
mflo $t0 # t0 = 3x^2 = (12)
add $t0, $t0, $t1 #t0 = 3x^2 + (-5x) = (2)
add $t6, $t0, $t2 #t6 = (3x^2 -5x) + 7 = 9

#Os resultados se mantem, visto que mudaria, se os valores fossem positivos e negativos, e tivéssemos uma instrução do tipo
#sem sinal, ou seja, um addiu por exemplo.