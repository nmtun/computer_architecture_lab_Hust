.text 
li $t0, 0
li $s1, 0x7fffffff
li $s2,	1
addu $s3, $s1, $s2	# c?ng kh�ng d?u $s3=$s1+$s2
xor $t1, $s1, $s2	# ki?m tra $s1 v� $s2 c� c�ng d?u kh�ng
bltz $t1, exit		# n?u $t1<0, exit
xor $t2, $s3, $s1	# ki?m tra xem $s1 v� $s3 c� c�ng d?u kh�ng
bgtz $t2, exit		# n?u $t2>0, exit
j overFlow
overFlow:
	li $t0, 1	# n?u tr�n s?, %t0=1
exit: