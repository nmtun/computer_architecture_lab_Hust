.data
msg_1: .asciiz "The sum of "
msg_2: .asciiz " and "
msg_3: .asciiz " is "

.text
add $s0, $zero, 28	# $s0=28
add $s1, $zero, 10	# $s1=10
add $t0, $s0, $s1 	# $t0=$s0+$s1
# print msg_1
li $v0, 4
la $a0, msg_1
syscall 
# print value of $s0
li $v0, 1
move $a0, $s0
syscall
# print msg_2
li $v0, 4
la $a0, msg_2
syscall 
# print value of $s1
li $v0, 1
move $a0, $s1
syscall
# print msg_3
li $v0, 4
la $a0, msg_3
syscall 
# print réult
li $v0, 1
move $a0, $t0
syscall