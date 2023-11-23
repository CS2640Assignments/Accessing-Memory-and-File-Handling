# CS 2640.01 program 3
# November 22, 2023
# Authors: Joshua Estrada and Damian Varela
# Github Repo Link: https://github.com/CS2640Assignments/Accessing-Memory-and-File-Handling

# defines a macro that prints characters
.macro printChar(%char)
li $v0, 11
la $a0, %char
syscall
.end_macro

# defines a macro that prints strings
.macro printStr(%str)
li $v0, 4
la $a0, %str
syscall
.end_macro

# defines a macro that prints integers
.macro printInt(%int)
li $v0, 1
add $a0, $zero, %int
syscall
.end_macro

.data
newline: .asciiz "\n"
scores: .word 32, 56, 78, 66, 88, 90, 93, 100, 101, 82 # array containing all scores
exitText: .asciiz "Exiting Program..."
extra: .asciiz "A with extra credit"
names: .asciiz "Joshua and Damian"
gradeText: .asciiz "The grade for "
gradeText2: .asciiz " is: "

.text
main:
	# load array into $s0
	la $s0, scores
	
	# set counter to 0
	move $t0, $zero
loop:
	# get array element
	lw $t1, 0($s0)
	printStr(gradeText)
	
	# get appropriate letter grade
	bgt $t1, 100, extracred
	bge $t1, 90, a # 90 and up is an A
	bge $t1, 80, b # 80 and up is a B
	bge $t1, 70, c # 70 and up is a C
	bge $t1, 60, d # 60 and up is a D
	j f 		  # below 60 is an F	
count:	
	# increments array counter
	addi $s0, $s0, 4
	addi $t0, $t0, 1
	# loop while elements remain
	blt  $t0, 10, loop	

	printStr(names)
	printStr(newline)
	j exit	


exit:
	printStr(exitText)
	li $v0, 10
	syscall

extracred:
	printInt($t1)
	printStr(gradeText2)
	printStr(extra)
	printStr(newline)
	j count
a:
	printInt($t1)
	printStr(gradeText2)
	printChar('A')
	printStr(newline)
	j count
b:
	printInt($t1)
	printStr(gradeText2)
	printChar('B')
	printStr(newline)
	j count
c:
	printInt($t1)
	printStr(gradeText2)
	printChar('C')
	printStr(newline)
	j count
d:
	printInt($t1)
	printStr(gradeText2)
	printChar('D')
	printStr(newline)
	j count
f:
	printInt($t1)
	printStr(gradeText2)
	printChar('F')
	printStr(newline)
	j count
	