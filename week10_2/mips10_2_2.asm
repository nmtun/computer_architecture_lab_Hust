.eqv KEY_CODE 0xFFFF0004      # Mã ASCII từ bàn phím, 1 byte
.eqv KEY_READY 0xFFFF0000     # =1 nếu có mã ký tự mới, tự động xóa sau khi lw
.eqv DISPLAY_CODE 0xFFFF000C   # Mã ASCII để hiển thị, 1 byte
.eqv DISPLAY_READY 0xFFFF0008  # =1 nếu màn hình đã sẵn sàng, tự động xóa sau khi sw

.text
    li $k0, KEY_CODE         # Địa chỉ của KEY_CODE
    li $k1, KEY_READY        # Địa chỉ của KEY_READY
    li $s0, DISPLAY_CODE     # Địa chỉ của DISPLAY_CODE (chứa ký tự cần in ra màn hình)
    li $s1, DISPLAY_READY    # Địa chỉ của DISPLAY_READY

loop:
    nop

WaitForKey:
    lw $t1, 0($k1)            # Đọc KEY_READY vào $t1
    beq $t1, $zero, WaitForKey # Nếu $t1 == 0 thì tiếp tục chờ

ReadKey:
    lw $t0, 0($k0)            # Đọc KEY_CODE vào $t0

WaitForDis:
    lw $t2, 0($s1)            # Đọc DISPLAY_READY vào $t2
    beq $t2, $zero, WaitForDis # Nếu $t2 == 0 thì tiếp tục chờ

Kiemtra:
KiemTraE:
    beq $t3, 1, KiemTraX
    beq $t0, 101, Co

KiemTraX:
    beq $t3, 2, KiemTraI
    beq $t0, 120, Co

KiemTraI:
    beq $t3, 3, KiemTraT
    beq $t0, 105, Co

KiemTraT:
    beq $t3, 4, Encrypt2
    beq $t0, 116, Co

Encrypt:
    addi $t3, $zero, 0

Encrypt2:
ChuHoa:
    bgt $t0, 90, ChuThuong
    blt $t0, 65, ChuThuong
    addi $t0, $t0, 32
    j ShowKey

ChuThuong:
    bgt $t0, 122, ChuSo
    blt $t0, 97, ChuSo
    addi $t0, $t0, -32
    j ShowKey

ChuSo:
    bgt $t0, 57, Khac
    blt $t0, 48, Khac
    j ShowKey

Khac:
    addi $t0, $zero, 42

ShowKey:
    sw $t0, 0($s0)            # Hiển thị ký tự
    nop
    beq $t3, 4, Exit
    j loop

Co:
    addi $t3, $t3, 1
    j Encrypt2

Exit:
    li $v0, 10
    syscall
