.text

li $s1, 0xfffffffb 	# $s1=-5
# abs $s0, $s1
sra $at, $s1, 31	# d?ch ph?i 31-bit 
xor $s0, $at, $s1	# xor $at v?i $s1 và gán kq vào $s0
subu $s0, $s0, $at	# th?c hi?n phép tr? không d?u v?i $at=-1 => k?t qu?