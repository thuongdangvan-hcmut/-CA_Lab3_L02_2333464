.data
msg1:       .asciiz "Solution ax^2 + bx + c = 0\n"
msg2:       .asciiz "Please insert a: "
msg3:       .asciiz "Please insert b: "
msg4:       .asciiz "Please insert c: "
msgNo:      .asciiz "\nThere is no real solution"
msgOne:     .asciiz "\nThere is one solution x = "
msgX1:      .asciiz "\nx1 = "
msgX2:      .asciiz " and x2 = "

zero:       .float 0.0
two:        .float 2.0
four:       .float 4.0

.text
.globl main

main:

    # printf("Solution ax^2 + bx + c = 0\n");
    li $v0, 4
    la $a0, msg1
    syscall

    # nhập a
    li $v0, 4
    la $a0, msg2
    syscall

    li $v0, 6
    syscall
    mov.s $f2, $f0         # a

    # nhập b
    li $v0, 4
    la $a0, msg3
    syscall

    li $v0, 6
    syscall
    mov.s $f4, $f0         # b

    # nhập c
    li $v0, 4
    la $a0, msg4
    syscall

    li $v0, 6
    syscall
    mov.s $f6, $f0         # c

    # delta = b*b - 4*a*c

    mul.s $f8, $f4, $f4       # b*b

    l.s $f10, four
    mul.s $f12, $f2, $f6      # a*c
    mul.s $f12, $f12, $f10    # 4*a*c

    sub.s $f14, $f8, $f12     # delta

    # if(delta < 0)

    l.s $f0, zero
    c.lt.s $f14, $f0
    bc1t NO_SOLUTION

    # if(delta == 0)

    c.eq.s $f14, $f0
    bc1t ONE_SOLUTION

    # delta > 0

TWO_SOLUTIONS:

    sqrt.s $f16, $f14         # sqrt(delta)

    l.s $f18, two

    # denominator = 2*a
    mul.s $f20, $f18, $f2

    # x1 = (-b + sqrt(delta))/(2*a)

    neg.s $f22, $f4
    add.s $f24, $f22, $f16
    div.s $f24, $f24, $f20

    # x2 = (-b - sqrt(delta))/(2*a)

    sub.s $f26, $f22, $f16
    div.s $f26, $f26, $f20

    li $v0, 4
    la $a0, msgX1
    syscall

    mov.s $f12, $f24
    li $v0, 2
    syscall

    li $v0, 4
    la $a0, msgX2
    syscall

    mov.s $f12, $f26
    li $v0, 2
    syscall

    j EXIT

ONE_SOLUTION:

    l.s $f18, two
    mul.s $f20, $f18, $f2

    neg.s $f22, $f4
    div.s $f24, $f22, $f20

    li $v0, 4
    la $a0, msgOne
    syscall

    mov.s $f12, $f24
    li $v0, 2
    syscall

    j EXIT

NO_SOLUTION:

    li $v0, 4
    la $a0, msgNo
    syscall

EXIT:

    li $v0, 10
    syscall