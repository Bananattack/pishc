L0:
# Initialize main frame pointer.
subi $fp, $sp, -1132
# Return address info is always generated, but has no purpose in main.
sw $0, 0($fp)
sw $0, -4($fp)
sw $0, -8($fp)
sw $0, -12($fp) # There is no old nesting entry for the main function (since it cannot call itself recursively).
sw $fp, 0($gp) # Set nesting entry for this function to new activation record.
sw $0, -16($fp) # No t1 value worth caring about yet.
sw $0, -20($fp) # No t2 value worth caring about yet.
sw $0, -24($fp) # No t3 value worth caring about yet.
sw $0, -28($fp) # No t4 value worth caring about yet.
sw $0, -32($fp) # No t5 value worth caring about yet.
sw $0, -36($fp) # No t6 value worth caring about yet.
sw $0, -40($fp) # No t7 value worth caring about yet.
j L1
# Error handler for out-of-bounds array access
IndexOutOfBounds:
.data
IOOB1: .asciiz "Index "
IOOB2: .asciiz " is outside of array bounds "
IOOB3: .asciiz " .. "
IOOB4: .asciiz ". Abort."
.text
la $a0, IOOB1
li $v0, 4
syscall
move $a0, $t2
li $v0, 1
syscall
la $a0, IOOB2
li $v0, 4
syscall
move $a0, $t3
li $v0, 1
syscall
la $a0, IOOB3
li $v0, 4
syscall
move $a0, $t4
li $v0, 1
syscall
la $a0, IOOB4
li $v0, 4
syscall
li $v0, 10
syscall
L1:
li $t1, 5
sw $t1, -1072($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testifstatement
addi $t1, $t1, -1068 # Local: &x
lw $t2, -1072($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
.data # String literal as words (written in reverse).
.word 0, 32, 61, 32, 120, 32, 58, 69, 82, 79, 70, 69
L2: .word 66
.text
la $t1, L2
sw $t1, -1076($fp) # Store temp
addi $t1, $fp, -1076 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L3: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L4# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L3# go to top of loop
L4: # done!
lw $t1, 0($gp) # Get stackframe for testifstatement
addi $t1, $t1, -1068 # Local: &x
sw $t1, -1080($fp) # Store temp
lw $t1, -1080($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0
L5: .word 10
.text
la $t1, L5
sw $t1, -1084($fp) # Store temp
lw $t1, -1084($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
 # Beginning of if statement
lw $t1, 0($gp) # Get stackframe for testifstatement
addi $t1, $t1, -1068 # Local: &x
sw $t1, -1092($fp) # Store temp
li $t1, 2
sw $t1, -1096($fp) # Store temp
lw $t2, -1092($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -1096($fp) # get temp
xor $t1, $t2, $t3
sltiu $t1, $t1, 1
sw $t1, -1088($fp) # Store temp
lw $t1, -1088($fp) # get temp
beq $t1, $0, L6 # Branch if we are equal to 0 (FALSE)
# Moving into the new scope.
.data # String literal as words (written in reverse).
.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 68, 69, 82, 69, 71, 71, 73, 82, 84, 32, 70
L8: .word 73
.text
la $t1, L8
sw $t1, -1100($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testifstatement
addi $t1, $t1, -44 # Local: &message
lw $t2, -1100($fp)
# Copy 14 words into t1 from t2
lw $t3, 0($t2) # Read
sw $t3, 0($t1) # Copy
lw $t3, -4($t2) # Read
sw $t3, -4($t1) # Copy
lw $t3, -8($t2) # Read
sw $t3, -8($t1) # Copy
lw $t3, -12($t2) # Read
sw $t3, -12($t1) # Copy
lw $t3, -16($t2) # Read
sw $t3, -16($t1) # Copy
lw $t3, -20($t2) # Read
sw $t3, -20($t1) # Copy
lw $t3, -24($t2) # Read
sw $t3, -24($t1) # Copy
lw $t3, -28($t2) # Read
sw $t3, -28($t1) # Copy
lw $t3, -32($t2) # Read
sw $t3, -32($t1) # Copy
lw $t3, -36($t2) # Read
sw $t3, -36($t1) # Copy
lw $t3, -40($t2) # Read
sw $t3, -40($t1) # Copy
lw $t3, -44($t2) # Read
sw $t3, -44($t1) # Copy
lw $t3, -48($t2) # Read
sw $t3, -48($t1) # Copy
lw $t3, -52($t2) # Read
sw $t3, -52($t1) # Copy
li $t1, 9
sw $t1, -1104($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testifstatement
addi $t1, $t1, -1068 # Local: &x
lw $t2, -1104($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
j L7# Jump to the end of the if
L6: # Else statement 
.data # String literal as words (written in reverse).
.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 68, 69, 82, 69, 71, 71, 73, 82, 84, 32, 69, 83, 76
L9: .word 69
.text
la $t1, L9
sw $t1, -1108($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testifstatement
addi $t1, $t1, -44 # Local: &message
lw $t2, -1108($fp)
# Copy 16 words into t1 from t2
lw $t3, 0($t2) # Read
sw $t3, 0($t1) # Copy
lw $t3, -4($t2) # Read
sw $t3, -4($t1) # Copy
lw $t3, -8($t2) # Read
sw $t3, -8($t1) # Copy
lw $t3, -12($t2) # Read
sw $t3, -12($t1) # Copy
lw $t3, -16($t2) # Read
sw $t3, -16($t1) # Copy
lw $t3, -20($t2) # Read
sw $t3, -20($t1) # Copy
lw $t3, -24($t2) # Read
sw $t3, -24($t1) # Copy
lw $t3, -28($t2) # Read
sw $t3, -28($t1) # Copy
lw $t3, -32($t2) # Read
sw $t3, -32($t1) # Copy
lw $t3, -36($t2) # Read
sw $t3, -36($t1) # Copy
lw $t3, -40($t2) # Read
sw $t3, -40($t1) # Copy
lw $t3, -44($t2) # Read
sw $t3, -44($t1) # Copy
lw $t3, -48($t2) # Read
sw $t3, -48($t1) # Copy
lw $t3, -52($t2) # Read
sw $t3, -52($t1) # Copy
lw $t3, -56($t2) # Read
sw $t3, -56($t1) # Copy
lw $t3, -60($t2) # Read
sw $t3, -60($t1) # Copy
li $t1, 3
sw $t1, -1112($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testifstatement
addi $t1, $t1, -1068 # Local: &x
lw $t2, -1112($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
L7: # End of if statement
lw $t1, 0($gp) # Get stackframe for testifstatement
addi $t1, $t1, -44 # Local: &message
sw $t1, -1116($fp) # Store temp
addi $t1, $fp, -1116 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
L10: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L11# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L10# go to top of loop
L11: # done!
.data # String literal as words (written in reverse).
.word 0, 32, 61, 32, 120, 32, 58, 82, 69, 84, 70
L12: .word 65
.text
la $t1, L12
sw $t1, -1120($fp) # Store temp
addi $t1, $fp, -1120 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L13: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L14# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L13# go to top of loop
L14: # done!
lw $t1, 0($gp) # Get stackframe for testifstatement
addi $t1, $t1, -1068 # Local: &x
sw $t1, -1124($fp) # Store temp
lw $t1, -1124($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0
L15: .word 10
.text
la $t1, L15
sw $t1, -1128($fp) # Store temp
lw $t1, -1128($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
# Exit the program.
li $v0, 10
syscall

