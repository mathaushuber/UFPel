.data
a: .word -3
b: .word 6
c: .word 4
d: .word -2
e: .word 8
x: .word 3
y: .space 4

.text
ori $t7, $zero, 0x1001
sll $t7, $t7, 16
lw $t0, 0($t7)
lw $t1, 4($t7)
lw $t2, 8($t7)
lw $t3, 12($t7)
lw $t4, 16($t7)
lw $t5, 20($t7)
lw $t6, 24($t7)
mult $t0, $t0 # a*a
mflo $s0 #t0 = 9
mult $s0, $s0 #a⁴
mflo $s0 #s0 = 81
mult $t5, $t5# x*x
mflo $s5 #x² = 9
mult $t5, $s5 #x^3
mflo $s1 #s1 = 27
mult $t1, $s1 #b*x³
mflo $s1 #s1 = 162
mult $t2, $s5 #c*x²
mflo $s2 #s2 = 36
mult $t3, $t5 #d*x
mflo $s3 #s3 = -6
ori $s7, $zero, 1
nor $s6, $zero ,$s7
add $s7, $s6, $s7 #complemento de 2
mult $s0, $s7 #a*-1
mflo $s0 #s0 = -a
add $s4, $s0, $s1 #s4 = a⁴ + b*x³ = -81 + 162 = 81
sub $s4, $s4, $s2 #s4 = a⁴ + b*x³ - c*x² = 81 - 36 = 45
add $s4, $s4, $s3 #s4 = a⁴ + b*x³ - c*x² -d*x = 45 - 6 = 39
add $s4, $s4, $t4 #s4 = a⁴ + b*x² - c*x² -d*x + e 39 + 8 = 47
sb $s4, 24($t7) #y = 47
