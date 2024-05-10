.data
    prompt: .asciiz "Nhap so phan tu cua mang: "
    array_prompt: .asciiz "Nhap phan tu thu "
    max_product_msg: .asciiz "Cap phan tu co tich lon nhat la: "
    newline: .asciiz "\n"

.text
main:
    # Nhập số phần tử của mảng từ bàn phím
    li $v0, 4               # syscall 4: in chuỗi
    la $a0, prompt         # Địa chỉ của prompt
    syscall

    li $v0, 5               # syscall 5: đọc số nguyên
    syscall
    move $s0, $v0           # Lưu số phần tử vào $s0

    # Khởi tạo mảng
    la $t0, array            # Địa chỉ bắt đầu của mảng
    move $t1, $zero          # Khởi tạo index của mảng = 0

    # Nhập các phần tử của mảng từ bàn phím
    la $a0, array_prompt    # Load prompt "Nhap phan tu thu "
    move $a1, $zero         # Khởi tạo index của phần tử = 0

input_loop:
    bge $a1, $s0, find_max_product  # Nếu index >= số phần tử, thoát khỏi vòng lặp nhập

    # In prompt "Nhap phan tu thu "
    li $v0, 4
    syscall

    # Đọc phần tử từ bàn phím
    li $v0, 5
    syscall
    sw $v0, ($t0)           # Lưu phần tử vào mảng
    addi $t0, $t0, 4        # Di chuyển địa chỉ của mảng tới phần tử tiếp theo
    addi $a1, $a1, 1        # Tăng index của phần tử lên 1
    j input_loop            # Quay lại vòng lặp nhập

find_max_product:
    # Khởi tạo biến lưu tích lớn nhất và cặp phần tử tương ứng
    li $s1, -9999999        # Khởi tạo tích lớn nhất là một giá trị nhỏ đủ nhỏ
    move $s2, $zero         # Phần tử đầu của cặp có tích lớn nhất
    move $s3, $zero         # Phần tử thứ hai của cặp có tích lớn nhất

    # Tìm cặp phần tử có tích lớn nhất
    la $t0, array            # Load địa chỉ bắt đầu của mảng
    li $t1, 0                # Khởi tạo index của mảng = 0

find_product_loop:
    bge $t1, $s0, print_max_product  # Nếu index >= số phần tử, thoát khỏi vòng lặp

    lw $t2, ($t0)           # Load phần tử thứ nhất của cặp
    lw $t3, 4($t0)          # Load phần tử thứ hai của cặp
    mul $t4, $t2, $t3       # Tính tích của cặp phần tử

    bgt $t4, $s1, update_max_product  # Nếu tích lớn hơn tích lớn nhất hiện tại, cập nhật

    addi $t0, $t0, 4        # Di chuyển địa chỉ của mảng tới phần tử tiếp theo
    addi $t1, $t1, 1        # Tăng index của mảng lên 1
    j find_product_loop     # Quay lại vòng lặp tìm kiếm tích lớn nhất

update_max_product:
    move $s1, $t4           # Cập nhật tích lớn nhất
    move $s2, $t2           # Lưu phần tử thứ nhất của cặp có tích lớn nhất
    move $s3, $t3           # Lưu phần tử thứ hai của cặp có tích lớn nhất
    addi $t0, $t0, 4        # Di chuyển địa chỉ của mảng tới phần tử tiếp theo
    addi $t1, $t1, 1        # Tăng index của mảng lên 1
    j find_product_loop     # Quay lại vòng lặp tìm kiếm tích lớn nhất

print_max_product:
    # In ra cặp phần tử có tích lớn nhất
    li $v0, 4               # syscall 4: in chuỗi
    la $a0, max_product_msg
    syscall

    # In ra phần tử thứ nhất của cặp
    li $v0, 1               # syscall 1: in số nguyên
    move $a0, $s2
    syscall

    # In ra dấu cách
    li $v0, 4               # syscall 4: in chuỗi
    la $a0, newline
    syscall

    # In ra phần tử thứ hai của cặp
    li $v0, 1               # syscall 1: in số nguyên
    move $a0, $s3
    syscall

    # Kết thúc chương trình
    li $v0, 10              # syscall 10: kết thúc chương trình
    syscall

# Mảng để lưu các phần tử nhập từ bàn phím
.data
    array: .space 100       # Mảng có thể chứa tối đa 25 phần tử, mỗi phần tử 4 byte
