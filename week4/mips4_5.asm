.text 
addi $s0, $zero, 5		# s? ?? nhân			
addi $s1, $zero, 1024		# l?y th?a 10 c?a 2
addi $t0,$zero, 1		# $t0=1
loop:
beq $s1, $t0, exit		# n?u $s1=1, exit
sll $s0, $s0, 1			# $s0=$s1*2
srl $s1, $s1, 1			# $s1=$s1/2
j loop
exit: 
add $s2, $zero, $s0		# ghi kq vào $s2
