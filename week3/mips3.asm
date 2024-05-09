.data
A: .space 256
msg_1: .asciiz "Nhap n (n < 64): "	# n la so ptu  
msg_2: .asciiz "Nhap ptu: "
msg_3: .asciiz "Ket qua la: "
msg_4: .asciiz " and "
nl: .asciiz "\n"

.text
main: 
    li $v0, 4   
    la $a0, msg_1  
    syscall
    
    li $v0, 5   # nhap ptu
    syscall
    move $t0, $v0   
    
    li $t1, 0   # i = 0
    la $t2, A   # load adress of A to $t2
    
insert: 
    beq $t1, $t0, find   # Nhap du -> nhay den find
    
    add $t4, $t1, $t1   # $t4 = 2 * i
    add $t4, $t4, $t4   # $t4 = 4 * i
    add $t4, $t4, $t2   # $t4 = 4i + A[0]
    
    li $v0, 4   
    la $a0, msg_2   # nhap cac ptu 
    syscall
    
    li $v0, 5   
    syscall
    sw $v0, ($t4)   # luu cac ptu vao A
    
    addi $t1, $t1, 1    # i++
    j insert    
    
find:
    li $t1, 0   # i = 0
    la $t2, A   # load adress of A to $t2
    
    li $t5, -999999 # $t5 = tich max
    li $t6, 0   # the first index 
    li $t7, 0   # the second index

loop:
    addi $t4, $t2, 4    # $t4 = $t2 + 4
    lw $t8, ($t2)   # load ptu i cua A -> $t8
    lw $t9, ($t4)   # load ptu i + 1 cua A -> $t9
    
    mul $s1, $t8, $t9 # $s1=$t8*$t9
    
    bgt $s1, $t5, update # if max > $s1 -> update
    
    addi $t1, $t1, 1    # i++
    addi $t2, $t2, 4    
    j loop 

update:
    move $t5, $s1  # $t5=max
    move $t6, $t1   # Lưu lại chỉ số của phần tử thứ nhất trong cặp có tích lớn nhất
    addi $t1, $t1, 1    # Tăng chỉ số lên 1 để trỏ đến phần tử tiếp theo
    move $t7, $t1   # Lưu lại chỉ số của phần tử thứ hai trong cặp có tích lớn nhất
    
    j print 
print:
    # in msg_3
    li $v0, 4   
    la $a0, msg_3   
    syscall
    # in ra ptu thu nhat
    li $v0, 1   
    lw $a0, ($t6)   # Load phần tử từ mảng A vào $a0
    syscall
    # in msg_4
    li $v0, 4   
    la $a0, msg_4
    syscall
    # in ra ptu thu hai 
    li $v0, 1   
    lw $a0, ($t7)   # Load phần tử từ mảng A vào $a0
    syscall
    # end
    li $v0, 10  
    syscall
