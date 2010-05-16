L0:
# Initialize main frame pointer.
subi $fp, $sp, -144
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
L2:
# Function square
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L3
L3:
lw $t1, 4($gp) # Get stackframe for square
lw $t1, -48($t1) # Argument: &*x
sw $t1, -56($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for square
lw $t1, -48($t1) # Argument: &*x
sw $t1, -60($fp) # Store temp
lw $t2, -56($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
lw $t3, -60($fp) # get temp
lw $t3, 0($t3) # deref temp to get variable
mul $t1, $t2, $t3
sw $t1, -52($fp) # Store temp
lw $t1, 4($gp) # Get stackframe for square
addi $t1, $t1, -44 # Local: &square
lw $t2, -52($fp) # get temp
sw $t2, 0($t1) # Store value into the function return value
# Return from function, and restore old calling stack.
lw $t1, -16($fp) # Restore t1 value
lw $t2, -20($fp) # Restore t2 value
lw $t3, -24($fp) # Restore t3 value
lw $t4, -28($fp) # Restore t4 value
lw $t5, -32($fp) # Restore t5 value
lw $t6, -36($fp) # Restore t6 value
lw $t7, -40($fp) # Restore t7 value
lw $t1 -12($fp)
sw $t1, 4($gp) # restore nesting entry
lw $ra, -8($fp) # load return address
lw $sp, -4($fp) # shrink stack
lw $fp, 0($fp) # restore frame pointer
jr $ra # return

L4:
# Function squarereal
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L5
L5:
lw $t1, 8($gp) # Get stackframe for squarereal
lw $t1, -48($t1) # Argument: &*x
sw $t1, -56($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for squarereal
lw $t1, -48($t1) # Argument: &*x
sw $t1, -60($fp) # Store temp
addi $t2, $fp, -56
lw $t2, -56($fp)
l.s $f6, 0($t2)
addi $t3, $fp, -60
lw $t3, -60($fp)
l.s $f8, 0($t3)
mul.s $f4, $f6, $f8
swc1 $f4, -52($fp) # Store temp
lw $t1, 8($gp) # Get stackframe for squarereal
addi $t1, $t1, -44 # Local: &squarereal
addi $t2, $fp, -52
l.s $f4, 0($t2)
swc1 $f4, 0($t1) # Store value into the function return value
# Return from function, and restore old calling stack.
lw $t1, -16($fp) # Restore t1 value
lw $t2, -20($fp) # Restore t2 value
lw $t3, -24($fp) # Restore t3 value
lw $t4, -28($fp) # Restore t4 value
lw $t5, -32($fp) # Restore t5 value
lw $t6, -36($fp) # Restore t6 value
lw $t7, -40($fp) # Restore t7 value
lw $t1 -12($fp)
sw $t1, 8($gp) # restore nesting entry
lw $ra, -8($fp) # load return address
lw $sp, -4($fp) # shrink stack
lw $fp, 0($fp) # restore frame pointer
jr $ra # return

L6:
# Function put
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L7
L7:
lw $t1, 12($gp) # Get stackframe for put
lw $t1, -48($t1) # Argument: &*s
sw $t1, -1072($fp) # Store temp
addi $t1, $fp, -1072 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
L8: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L9# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L8# go to top of loop
L9: # done!
# Return from function, and restore old calling stack.
lw $t1, -16($fp) # Restore t1 value
lw $t2, -20($fp) # Restore t2 value
lw $t3, -24($fp) # Restore t3 value
lw $t4, -28($fp) # Restore t4 value
lw $t5, -32($fp) # Restore t5 value
lw $t6, -36($fp) # Restore t6 value
lw $t7, -40($fp) # Restore t7 value
lw $t1 -12($fp)
sw $t1, 12($gp) # restore nesting entry
lw $ra, -8($fp) # load return address
lw $sp, -4($fp) # shrink stack
lw $fp, 0($fp) # restore frame pointer
jr $ra # return

L10:
# Function swap
sw $ra, -8($fp) # Save the caller return address RIGHT NOW.
j L11
L11:
.data # String literal as words (written in reverse).
.word 0, 32, 61, 32
L12: .word 120
.text
la $t1, L12
sw $t1, -60($fp) # Store temp
addi $t1, $fp, -60 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L13: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L14# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L13# go to top of loop
L14: # done!
lw $t1, 16($gp) # Get stackframe for swap
lw $t1, -48($t1) # Argument: &*x
sw $t1, -64($fp) # Store temp
lw $t1, -64($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0, 32, 61, 32, 121
L15: .word 32
.text
la $t1, L15
sw $t1, -68($fp) # Store temp
addi $t1, $fp, -68 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L16: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L17# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L16# go to top of loop
L17: # done!
lw $t1, 16($gp) # Get stackframe for swap
lw $t1, -52($t1) # Argument: &*y
sw $t1, -72($fp) # Store temp
lw $t1, -72($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0, 32, 61, 32, 112, 109, 101, 116
L18: .word 32
.text
la $t1, L18
sw $t1, -76($fp) # Store temp
addi $t1, $fp, -76 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L19: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L20# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L19# go to top of loop
L20: # done!
lw $t1, 16($gp) # Get stackframe for swap
addi $t1, $t1, -56 # Local: &temp
sw $t1, -80($fp) # Store temp
lw $t1, -80($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0
L21: .word 10
.text
la $t1, L21
sw $t1, -84($fp) # Store temp
lw $t1, -84($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
lw $t1, 16($gp) # Get stackframe for swap
lw $t1, -48($t1) # Argument: &*x
sw $t1, -88($fp) # Store temp
lw $t1, 16($gp) # Get stackframe for swap
addi $t1, $t1, -56 # Local: &temp
lw $t2, -88($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
sw $t2, 0($t1) # Store value into a variable
lw $t1, 16($gp) # Get stackframe for swap
lw $t1, -52($t1) # Argument: &*y
sw $t1, -92($fp) # Store temp
lw $t1, 16($gp) # Get stackframe for swap
lw $t1, -48($t1) # Argument: &*x
lw $t2, -92($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
sw $t2, 0($t1) # Store value into a variable
lw $t1, 16($gp) # Get stackframe for swap
addi $t1, $t1, -56 # Local: &temp
sw $t1, -96($fp) # Store temp
lw $t1, 16($gp) # Get stackframe for swap
lw $t1, -52($t1) # Argument: &*y
lw $t2, -96($fp) # get temp
lw $t2, 0($t2) # deref temp to get variable
sw $t2, 0($t1) # Store value into a variable
.data # String literal as words (written in reverse).
.word 0, 32, 61, 32
L22: .word 120
.text
la $t1, L22
sw $t1, -100($fp) # Store temp
addi $t1, $fp, -100 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L23: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L24# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L23# go to top of loop
L24: # done!
lw $t1, 16($gp) # Get stackframe for swap
lw $t1, -48($t1) # Argument: &*x
sw $t1, -104($fp) # Store temp
lw $t1, -104($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0, 32, 61, 32, 121
L25: .word 32
.text
la $t1, L25
sw $t1, -108($fp) # Store temp
addi $t1, $fp, -108 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L26: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L27# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L26# go to top of loop
L27: # done!
lw $t1, 16($gp) # Get stackframe for swap
lw $t1, -52($t1) # Argument: &*y
sw $t1, -112($fp) # Store temp
lw $t1, -112($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0, 32, 61, 32, 112, 109, 101, 116
L28: .word 32
.text
la $t1, L28
sw $t1, -116($fp) # Store temp
addi $t1, $fp, -116 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L29: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L30# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L29# go to top of loop
L30: # done!
lw $t1, 16($gp) # Get stackframe for swap
addi $t1, $t1, -56 # Local: &temp
sw $t1, -120($fp) # Store temp
lw $t1, -120($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0
L31: .word 10
.text
la $t1, L31
sw $t1, -124($fp) # Store temp
lw $t1, -124($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
.data # String literal as words (written in reverse).
.word 0, 10, 46, 101, 116, 101, 108, 112, 109, 111, 99, 32, 112, 97, 119
L32: .word 115
.text
la $t1, L32
sw $t1, -128($fp) # Store temp
addi $t1, $fp, -128 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L33: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L34# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L33# go to top of loop
L34: # done!
# Return from function, and restore old calling stack.
lw $t1, -16($fp) # Restore t1 value
lw $t2, -20($fp) # Restore t2 value
lw $t3, -24($fp) # Restore t3 value
lw $t4, -28($fp) # Restore t4 value
lw $t5, -32($fp) # Restore t5 value
lw $t6, -36($fp) # Restore t6 value
lw $t7, -40($fp) # Restore t7 value
lw $t1 -12($fp)
sw $t1, 16($gp) # restore nesting entry
lw $ra, -8($fp) # load return address
lw $sp, -4($fp) # shrink stack
lw $fp, 0($fp) # restore frame pointer
jr $ra # return

L1:
.data
L35: .float 66.5555
.text
l.s $f4, L35
swc1 $f4, -64($fp) # Store temp
# Call function squarereal.
sw $fp, 0($sp) # Old frame pointer
sw $sp, -4($sp) # Old stack pointer
sw $zero, -8($sp) # Return address (to be filled on function entry)
lw $t0, 8($gp) # Get old nesting entry.
sw $t0, -12($sp) # Save old nesting entry.
sw $sp, 8($gp) # Set nesting entry for this function to new activation record.
sw $t1, -16($sp) # Save t1 value
sw $t2, -20($sp) # Save t2 value
sw $t3, -24($sp) # Save t3 value
sw $t4, -28($sp) # Save t4 value
sw $t5, -32($sp) # Save t5 value
sw $t6, -36($sp) # Save t6 value
sw $t7, -40($sp) # Save t7 value
addi $t1, $fp, -64 # get address of temp
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 64 # expand stack
la $t7, L4 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
l.s $f4, -44($sp) # get return value of call
swc1 $f4, -60($fp) # Store temp
addi $t1, $fp, -60
l.s $f4, 0($t1)
cvt.w.s $f4, $f4 # convert to integer
mfc1 $t1, $f4 # move into int register
sw $t1, -56($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testproc
addi $t1, $t1, -48 # Local: &a
lw $t2, -56($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
li $t1, 42
sw $t1, -72($fp) # Store temp
# Call function square.
sw $fp, 0($sp) # Old frame pointer
sw $sp, -4($sp) # Old stack pointer
sw $zero, -8($sp) # Return address (to be filled on function entry)
lw $t0, 4($gp) # Get old nesting entry.
sw $t0, -12($sp) # Save old nesting entry.
sw $sp, 4($gp) # Set nesting entry for this function to new activation record.
sw $t1, -16($sp) # Save t1 value
sw $t2, -20($sp) # Save t2 value
sw $t3, -24($sp) # Save t3 value
sw $t4, -28($sp) # Save t4 value
sw $t5, -32($sp) # Save t5 value
sw $t6, -36($sp) # Save t6 value
sw $t7, -40($sp) # Save t7 value
addi $t1, $fp, -72 # get address of temp
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 64 # expand stack
la $t7, L2 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, -44($sp) # get return value of call
sw $t1, -68($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testproc
addi $t1, $t1, -52 # Local: &b
lw $t2, -68($fp) # get temp
sw $t2, 0($t1) # Store value into a variable
.data # String literal as words (written in reverse).
.word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 33, 111, 111, 119, 32, 44, 110, 111, 105, 116, 99, 110, 117, 102, 32, 97, 32, 111, 116, 32, 103, 110, 105, 114, 116, 115, 32, 97, 32, 103, 110, 105, 115, 115, 97
L36: .word 80
.text
la $t1, L36
sw $t1, -76($fp) # Store temp
# Call function put.
sw $fp, 0($sp) # Old frame pointer
sw $sp, -4($sp) # Old stack pointer
sw $zero, -8($sp) # Return address (to be filled on function entry)
lw $t0, 12($gp) # Get old nesting entry.
sw $t0, -12($sp) # Save old nesting entry.
sw $sp, 12($gp) # Set nesting entry for this function to new activation record.
sw $t1, -16($sp) # Save t1 value
sw $t2, -20($sp) # Save t2 value
sw $t3, -24($sp) # Save t3 value
sw $t4, -28($sp) # Save t4 value
sw $t5, -32($sp) # Save t5 value
sw $t6, -36($sp) # Save t6 value
sw $t7, -40($sp) # Save t7 value
addi $t1, $fp, -76 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
sw $t1, -48($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 1076 # expand stack
la $t7, L6 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
lw $t1, -44($sp) # get return value of call
.data # String literal as words (written in reverse).
.word 0, 32, 61, 32
L37: .word 97
.text
la $t1, L37
sw $t1, -80($fp) # Store temp
addi $t1, $fp, -80 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L38: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L39# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L38# go to top of loop
L39: # done!
lw $t1, 0($gp) # Get stackframe for testproc
addi $t1, $t1, -48 # Local: &a
sw $t1, -84($fp) # Store temp
lw $t1, -84($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0, 32, 61, 32, 98
L40: .word 32
.text
la $t1, L40
sw $t1, -88($fp) # Store temp
addi $t1, $fp, -88 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L41: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L42# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L41# go to top of loop
L42: # done!
lw $t1, 0($gp) # Get stackframe for testproc
addi $t1, $t1, -52 # Local: &b
sw $t1, -92($fp) # Store temp
lw $t1, -92($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0
L43: .word 10
.text
la $t1, L43
sw $t1, -96($fp) # Store temp
lw $t1, -96($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
lw $t1, 0($gp) # Get stackframe for testproc
addi $t1, $t1, -48 # Local: &a
sw $t1, -100($fp) # Store temp
lw $t1, 0($gp) # Get stackframe for testproc
addi $t1, $t1, -52 # Local: &b
sw $t1, -104($fp) # Store temp
# Call function swap.
sw $fp, 0($sp) # Old frame pointer
sw $sp, -4($sp) # Old stack pointer
sw $zero, -8($sp) # Return address (to be filled on function entry)
lw $t0, 16($gp) # Get old nesting entry.
sw $t0, -12($sp) # Save old nesting entry.
sw $sp, 16($gp) # Set nesting entry for this function to new activation record.
sw $t1, -16($sp) # Save t1 value
sw $t2, -20($sp) # Save t2 value
sw $t3, -24($sp) # Save t3 value
sw $t4, -28($sp) # Save t4 value
sw $t5, -32($sp) # Save t5 value
sw $t6, -36($sp) # Save t6 value
sw $t7, -40($sp) # Save t7 value
addi $t1, $fp, -100 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -48($sp)
addi $t1, $fp, -104 # get address of temp
lw $t1, 0($t1) # deref it to get address of variable
sw $t1, -52($sp)
move $fp, $sp # update frame pointer
subi $sp, $sp, 132 # expand stack
la $t7, L10 # load function label
jalr $ra, $t7 # Save return address and jump to function label.
.data # String literal as words (written in reverse).
.word 0, 32, 61, 32
L44: .word 97
.text
la $t1, L44
sw $t1, -108($fp) # Store temp
addi $t1, $fp, -108 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L45: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L46# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L45# go to top of loop
L46: # done!
lw $t1, 0($gp) # Get stackframe for testproc
addi $t1, $t1, -48 # Local: &a
sw $t1, -112($fp) # Store temp
lw $t1, -112($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0, 32, 61, 32, 98
L47: .word 32
.text
la $t1, L47
sw $t1, -116($fp) # Store temp
addi $t1, $fp, -116 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L48: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L49# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L48# go to top of loop
L49: # done!
lw $t1, 0($gp) # Get stackframe for testproc
addi $t1, $t1, -52 # Local: &b
sw $t1, -120($fp) # Store temp
lw $t1, -120($fp) # get temp
lw $t1, 0($t1) # deref temp to get variable
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0
L50: .word 10
.text
la $t1, L50
sw $t1, -124($fp) # Store temp
lw $t1, -124($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
L51: # Beginning of while loop
li $t1, 1
sw $t1, -128($fp) # Store temp
lw $t1, -128($fp) # get temp
beq $t1, $0, L52 # Branch if we are equal to 0 (FALSE)
li $a0, 0 # seed id 0
li $v0, 41 # Service: random
syscall
move $t1, $a0 # load result
andi $t1, $t1, 0x7fffffff # mask off sign bit
sw $t1, -132($fp) # Store temp
lw $t1, -132($fp) # get temp
move $a0, $t1 # Move arg into service address register
li $v0, 1 # Service: write integer
syscall # Call writeint
.data # String literal as words (written in reverse).
.word 0
L53: .word 10
.text
la $t1, L53
sw $t1, -136($fp) # Store temp
lw $t1, -136($fp) # get temp
lw $t1, 0($t1) # deref temp to get string
move $a0, $t1 # Move arg into service address register
li $v0, 11 # Service: write character
syscall # Call writechar
j L51# Jump to the beginning of the while loop
L52: # End of while loop
.data # String literal as words (written in reverse).
.word 0, 10, 46, 103, 110, 105, 116, 105, 120
L54: .word 101
.text
la $t1, L54
sw $t1, -140($fp) # Store temp
addi $t1, $fp, -140 # get address of temp
lw $t1, 0($t1) # deref it to get address of string
L55: # writestr is implemented as a loop over each character in a string.
lw $a0, 0($t1) # deref t1 to get character from string
beq $a0, $0, L56# exit when the character is 0. 
li $v0, 11 # Service: write character
syscall # Call writechar
addi $t1, $t1, -4 # Decrement pointer
j L55# go to top of loop
L56: # done!
# Exit the program.
li $v0, 10
syscall

