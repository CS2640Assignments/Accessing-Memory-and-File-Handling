# This macro allows for the file name to be properly converted in order to avoid errors
.macro process(%file)
    	move $t0, %file
loop:
        lb $t1, ($t0)  # Load a character from the buffer
        beqz $t1, done_processing  # Exit loop if null terminator
        beq $t1, 10, replace_newline  # Check for newline (ASCII 10)
        beq $t1, 13, replace_newline  # Check for carriage return (ASCII 13)
	j continue_loop
replace_newline:
	sb $zero, ($t0)  # Replace newline with null terminator
continue_loop:
        addi $t0, $t0, 1  # Move to the next character
        j loop

done_processing:
.end_macro

# Prints a new line
.macro nLine
  	li $v0, 4
  	la $a0, newLine
  	syscall
.end_macro

.data
filePrompt: .asciiz "Please enter a file name (include .txt) (max 50 characters): "
fileName:   .space 51
question: .asciiz "\nWhat have you enjoyed most about the class so far?"
buffer: .space 4000
answer: .space 500
buffer2: .space 4500
newLine: .asciiz "\n"

.text
	# Prompt the user to enter a file name.
	li $v0, 4
	la $a0, filePrompt
	syscall
	
    	# Read file name from user
    	li $v0, 8
    	la $a0, fileName
    	li $a1, 50
    	syscall	
    	la $t0, fileName # Loads the input as a file name 
	process($t0)
	
 	# Open for writing and appending
	li   $v0, 13       
  	la   $a0, fileName # output file name
  	li   $a1, 9        # 9 Writes and appends
  	syscall            
  	move $s0, $v0      # save the file descriptor 

  	# Write to file just opened
  	li   $v0, 15       # system call for write to file
  	move $a0, $s0      # file descriptor 
  	la   $a1, question   # address of buffer from which to write
  	li   $a2, 60       # hardcoded buffer length
  	syscall            # write to file
  	
  	# prompt the user the class question
	li $v0, 4
	la $a0, question
	syscall
  	
	nLine # Prints a new line for readability
  	
  	# Read user answer name from user
    	li $v0, 8
    	la $a0, answer
    	li $a1, 499
    	syscall	
    	la $t1, answer
  	
  	li   $v0, 15       
  	move $a0, $s0      
  	la   $a1, ($t1)    # Writes buffer of address $t1, the user answer
  	li   $a2, 499      
  	syscall            
  	
  	# Close the file 
  	li   $v0, 16       # system call for close file
  	move $a0, $s0      # file descriptor to close
  	syscall            # close file

	# opens file in read mode
	li $v0, 13	    
	la $a0, fileName
	li $a1, 0
	syscall
	move $s0, $v0
	
	# reads file and stores it in buffer
	li $v0, 14
	move $a0, $s0
	la $a1, buffer2
	li $a2, 4499
	syscall
	
	# prints file contents
	li $v0, 4
	la $a0, buffer2
	syscall

  	# Close the file 
  	li   $v0, 16      
  	move $a0, $s0      # Moves file descriptor to close
  	syscall            
	
exit:
	li $v0, 10
	syscall	
