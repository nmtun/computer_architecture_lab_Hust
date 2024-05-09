#Laboratory 3, Home Assigment 
.data
arr: .word 1, 2, 3, 4, 5, 0, 6, 7, 8, 9, 10, 11 # kh?i t?o các ph?n t? c?a m?ng arr
.text
addi $s3, $zero, 10 # s? các ph?n t? c?a m?ng arr
addi $s4, $zero, 1 # b??c nh?y b?ng 1
la $s2, arr # l?u ??a ch? ??u tiên c?a m?ng vào $s2
addi $s5, $zero, 0 # sum = 0
addi $s1, $zero, 0 # i = 0
loop: 
#slt $t2, $s5, $zero # if i<=n, goto endloop

add $t1, $s1, $s1 # $t1 = 2 * $s1
add $t1, $t1, $t1 # $t1 = 4 * $s1
add $t1, $t1, $s2 # $t1 store the address of A[i]
lw $t0, 0($t1) # load value of A[i] in $t0
beq $t0, $zero, endloop
add $s5, $s5, $t0 # sum = sum + A[i]
add $s1, $s1, $s4 # i = i + step
j loop # goto loop
endloop: