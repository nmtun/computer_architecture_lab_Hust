#Laboratory Exercise 5, Home Assignment 3
.data
string: .space 50
msg_1: .asciiz "Nhap xau: "
msg_2: .asciiz "Do dai xau la: "
.text
main:
get_string:
li $v0, 54			# get str fr dialog
la $a0, msg_1			# load address msg_1 to $a0
la $a1, string			# load address string to $s1
la $a2, 50			# max 50 characters
syscall
get_length: 
la $a0,string 			# $a0 = address(string[0])
add $t0,$zero,$zero 		# $t0 = i = 0
check_char:
add $t1,$a0,$t0 		# $t1 = $a0 + $t0
				# = address(string[i])
lb $t2, 0($t1) 			# $t2 = string[i]
beq $t2, $zero, end_of_str 	# is null char?
addi $t0, $t0, 1 		# $t0 = $t0 + 1 -> i = i + 1 
j check_char
end_of_str:
end_of_get_length:
print_length:
addi $t0, $t0, -1
li $v0, 56
la $a0, msg_2
move $a1, $t0
syscall