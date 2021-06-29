.text
ori $t1, $zero, 527 #t1 = 527
ori $t2, $zero, -372 #t2 = 372
add $t4, $t1, $t2 #t4 = 527 + (-372)
ori $t1, $zero, 225 #t1 = 225 subscreveu o valor antigo, como já foi calculada a soma, que era o que nos importava.
ori $t2, $zero, -794 #t2 = 794 subscreveu o valor antigo ...
add $t5, $t1, $t2 #t5 = 225 + (-794)
add $t0, $t4, $t5 #t0 = resultado geral da soma de (527 + (-372)) + (225 + (-794)) = -414
