.text
ori $t0, $zero, 0x70000000 #t0 = 0
addu $t1, $t0, $t0 #0x70000000
# O resultado foi e0000000 em hexadecimal, que corresponde a 3758096384 em decimal. o que acontece é que a instrução addu faz a adição SEM SINAL de um número
# sem overflow, o resultado está correto, pois 0x70000000 em decimal seria 1879048192 que é a metade do número que está no registrador t1. Se essa instrução
# fosse feita com add, o registrador t1 não receberia nenhum valor, pois ocorreria um overflow, visto que, a instrução addu calcula uma soma SEM SINAL e SEM OVERFLOW
# já a instrução add, permite o overflow, fazendo que não fosse possível essa adição.
