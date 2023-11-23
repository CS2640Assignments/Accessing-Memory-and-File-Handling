# CS 2640.01 program 3 task2
# November 22, 2023
# Authors: Joshua Estrada and Damian Varela
# Github Repo Link: https://github.com/CS2640Assignments/Accessing-Memory-and-File-Handling

.data
file: .asciiz "program3txtfile.txt"
buffer: .space 3633

.text
main:
	li $v0, 13
	la $a0, file
	li $a1, 0
	syscall
	move $s0, $v0
	
	li $v0, 14
	move $a0, $s0
	la $a1, buffer
	li $a2, 3632
	syscall
	
	li $v0, 4
	la $a0, buffer
	syscall
	
exit:
	li $v0, 10
	syscall	