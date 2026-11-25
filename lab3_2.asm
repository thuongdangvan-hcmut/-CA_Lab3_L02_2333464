.data
msgA:   .asciiz "Please insert a: "
msgB:   .asciiz "Please insert b: "
msgC:   .asciiz "Please insert c: "
msgD:   .asciiz "Please insert d: "
msgE:   .asciiz "Please insert e: "
msgU:   .asciiz "Please insert u: "
msgV:   .asciiz "Please insert v: "
msgR:   .asciiz "\nResult = "

f2: .float 2.0
f6: .float 6.0
f7: .float 7.0

.text
.globl main

main:

#===== Nhap a =====
li $v0,4
la $a0,msgA
syscall

li $v0,6
syscall
mov.s $f0,$f0
mov.s $f20,$f0      # a

#===== Nhap b =====
li $v0,4
la $a0,msgB
syscall

li $v0,6
syscall
mov.s $f22,$f0      # b

#===== Nhap c =====
li $v0,4
la $a0,msgC
syscall

li $v0,6
syscall
mov.s $f24,$f0      # c

#===== Nhap d =====
li $v0,4
la $a0,msgD
syscall

li $v0,6
syscall
mov.s $f26,$f0      # d

#===== Nhap e =====
li $v0,4
la $a0,msgE
syscall

li $v0,6
syscall
mov.s $f28,$f0      # e

#===== Nhap u =====
li $v0,4
la $a0,msgU
syscall

li $v0,6
syscall
mov.s $f30,$f0      # u

#===== Nhap v =====
li $v0,4
la $a0,msgV
syscall

li $v0,6
syscall
mov.s $f2,$f0       # v

#################################################
# Tính u^2, u^6, u^7
#################################################

mul.s $f4,$f30,$f30      # u^2
mul.s $f6,$f4,$f30       # u^3
mul.s $f8,$f6,$f30       # u^4
mul.s $f10,$f8,$f30      # u^5
mul.s $f12,$f10,$f30     # u^6
mul.s $f14,$f12,$f30     # u^7

#################################################
# Tính v^2, v^6, v^7
#################################################

mul.s $f16,$f2,$f2       # v^2
mul.s $f18,$f16,$f2      # v^3
mul.s $f1,$f18,$f2       # v^4
mul.s $f3,$f1,$f2        # v^5
mul.s $f5,$f3,$f2        # v^6
mul.s $f7,$f5,$f2        # v^7

#################################################
# term1 = a*(u^7-v^7)/7
#################################################

sub.s $f8,$f14,$f7

l.s $f9,f7
div.s $f8,$f8,$f9

mul.s $f8,$f8,$f20

#################################################
# term2 = b*(u^6-v^6)/6
#################################################

sub.s $f10,$f12,$f5

l.s $f11,f6
div.s $f10,$f10,$f11

mul.s $f10,$f10,$f22

#################################################
# term3 = c*(u^2-v^2)/2
#################################################

sub.s $f12,$f4,$f16

l.s $f13,f2
div.s $f12,$f12,$f13

mul.s $f12,$f12,$f24

#################################################
# Numerator
#################################################

add.s $f14,$f8,$f10
add.s $f14,$f14,$f12

#################################################
# Denominator = d^4 + e^3
#################################################

mul.s $f15,$f26,$f26     # d^2
mul.s $f15,$f15,$f15     # d^4

mul.s $f17,$f28,$f28     # e^2
mul.s $f17,$f17,$f28     # e^3

add.s $f18,$f15,$f17

#################################################
# kq = numerator / denominator
#################################################

div.s $f20,$f14,$f18

#################################################
# In kết quả
#################################################

li $v0,4
la $a0,msgR
syscall

mov.s $f12,$f20
li $v0,2
syscall

# Kết thúc
li $v0,10
syscall