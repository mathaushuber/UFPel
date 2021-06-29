.data
a: .half 30
b: .half 5
Q: .space 2
P: .space 4

.text
lui $t7, 0x1001
lh $t0, 0($t7)
lh $t1, 2($t7)
lb $t5, 4($t7)
lb $t6, 8($t7)
mult $t0, $t1 #a*b
mflo $t3 #t3 = 150
div $t0, $t1 #a/b
mflo $t4 #mflo **: quociente = 6
mfhi $t2 #mfhi **: resto
sb $t4, 4($t7) 
sb $t3, 8($t7)