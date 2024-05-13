#Laboratory Exercise 5, Home Assignment 1
.data
test: .asciiz "Nguyen_Manh_Tung_VN07_K67"
.text
li $v0, 4	# lựa chọn chức năng	
la $a0, test	# cập nhật dữ liệu cần in cho $a0
syscall		# in ra màn hình 