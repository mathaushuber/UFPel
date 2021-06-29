.text
addi $t1, $zero, 4 #t1 = b = (4)
addi $t2, $zero, 2 #t2 = B = (2)
addi $t3, $zero, 8 #t3 = h = (8)
addi $t4, $zero, 2 #t4 = 2 = denominador
add $t1, $t1, $t2 #t1 = B + b = (6)
mult $t1, $t3 #t1 = (B + b)*h 
mflo $t1 #t1 = (48)
div $t1, $t4 #48/2
mfhi $t5 # t5 = resto da divisão = 0
mflo $t4 # t4 = quociente = 24