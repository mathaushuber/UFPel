.text
#Armazenando variáveis
addi $t1, $zero, 2 #x = 2
addi $t2, $zero, 4 #y = 4
#Armazenando constantes
addi $t0, $zero, 9 # t0 = 9
addi $t5, $zero, 3 # t5 = 3
addi $t6, $zero, -7 #t6 = -7
addi $t7, $zero, 2 #t7 = 2
addi $s0, $zero, 8 #s0 = 8
#Calculando o numerador
mult $t0, $t1 # 9 * x
mflo $t0 # t0 = 9x = (18) 
mult $t5, $t2 # 3 * y
mflo $t5 # t5 = 3y = (12)
add $t0, $t0, $t5 #t0 = 9x + 3y = (30)
add $t0, $t0, $t6 #t0 = 9x + 3y -7 = (23)
#Calculando o denominador
mult $t7, $t1 # 2 * x
mflo $t7 # t7 = 2x = (4)
add $t5, $zero, -4 #t5 = -y = (-4)
add $t7, $t7, $t5 #t7 = 2x - y = (0)
add $t7, $t7, $s0 #t7 = 2x - y + 8 = (8)
#Calculando a divisão
div $t0, $t7 # 23/8
mfhi $t3 # resto da divisão
mflo $t4 # quociente da divisão

#Acontece que quando o x é 0 e y é -8 temos uma divisão por zero, fazendo que o resto e o quociente dessa divisão, ou seja os nossos registradores t3 e t4 
#recebam zero.