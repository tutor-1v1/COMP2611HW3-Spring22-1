https://tutorcs.com
WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
# Your name:
# Your student id:
# Your email address:

.data
# output messages
PleaseMsg1: .asciiz "Please enter the size of your matrix:\n"
PleaseMsg2: .asciiz "Please enter integers in array A[] one by one:\n"
InputMsg1: 	.asciiz "A["
InputMsg2: 	.asciiz "]["
InputMsg3: 	.asciiz "]: "
OutMsg1:	.asciiz "Is it a skew-symmetric matrix ? "
Outyes:		.asciiz "YES."
Outno:		.asciiz "NO."
space: .asciiz "\t"
newline: .asciiz "\n"

# at most 25 elements for a 5x5 Matrix, each element is initalized with 0
A: .word 0:25

.text
.globl main

main:
	la $s0,A       #$s0 base address of array A[]

	# cout << "Please enter the size of your matrix:"
	la $a0, PleaseMsg1
	addi $v0, $zero, 4
	syscall
		
	# read the size of the matrix, copy it to $s1
	li $v0, 5
	syscall
	addi $s1,$v0,0

	# cout << "Please enter integers in array A[] one by one:\n"
	la $a0, PleaseMsg2
	addi $v0, $zero, 4
	syscall
	
	li $t0,0 # iterator i
	
outside_for: # nested for loop to get the complete matrix
             # this part is like:
             # for (i=0;i<n;i++){
             #     for {j=0;j<n;j++){} 
             #     }
	beq $t0,$s1,exit_outside_for
        li $t1,0 # iterator j
    inside_for:
	beq $t1,$s1,exit_inside_for 

	# cout << "A["
	la $a0, InputMsg1
	addi $v0, $zero, 4
	syscall
	
	# print index
	move $a0,$t0
	addi $v0, $zero, 1
	syscall
	
	# cout << "]["
	la $a0, InputMsg2
	addi $v0, $zero, 4
	syscall

	# print index
	move $a0,$t1
	addi $v0, $zero, 1
	syscall
	
	# cout << "]: "
	la $a0, InputMsg3
	addi $v0, $zero, 4
	syscall
	
	# read user input in $v0
	li $v0, 5
	syscall
	move $v1,$v0
	
	move $a0,$t0
	move $a1,$s1
	jal multiply
	move $t3,$v0 # $t3 = $t0*$s1
	add $t3,$t3,$t1 # $t3 = $t0*$s1 + $t1

	sll $t3,$t3,2
	add $t3,$t3,$s0 # $t3 = i*4 + base of A in $s0, addr of A[i]
	sw $v1, 0($t3)  # A[i] = $v1

    	addi $t1,$t1,1 #j++
    	j inside_for
exit_inside_for:
	addi $t0,$t0,1 #i++
	j outside_for
	
	exit_outside_for:
        
	move $a0,$s0 # $a0: base address of array A[]
	move $a1,$s1 # $a1: size of the matrix stored in A[], for example if $a1=5, then the matrices are 5x5
	jal IsSkewSymmetric # call IsSkewSymmetric
	move $t5,$v1 # move result from IsSkewSymmetric() to $t5, if $t5=1 it is skew symmetric, if $t5=0 it is not
        
	# cout << "Is it a skew-symmetric matrix ? :" << endl;
	la $a0, OutMsg1
	addi $v0, $zero, 4
	syscall    

if1_part:
	beq $t5,$zero,else1_part

	# print YES
	la $a0, Outyes
	addi $v0, $zero, 4
	syscall   
	j end_if1_else1

	# print NO
else1_part:
	la $a0, Outno
	addi $v0, $zero, 4
	syscall   

end_if1_else1:
        
	# exit the program
exit:
	addi $v0, $zero, 10 
	syscall



# provide function multiply()
# inputs: $a0,$a1
# outputs: $v0 = $a0 x $a1
multiply:
	
	li $t4,0
	li $v0,0

enter_m_for:
	beq $t4,$a1,exit_m_for
	add $v0,$v0,$a0
	addi $t4,$t4,1
	j enter_m_for
	
exit_m_for:
	jr $ra

# This function does the same thing as the function IsSkewSymmetric() in the C++ program
# arguments are in $a0, $a1
# $a0: base address of array A[]
# $a1: size of the matrix stored in A[], for example if $a1=5, then the matrices are 5x5
# Return value: $v1, if skewsymmetric $v1=1, else $v1=0
# preserve registers as needed according to slide 76 of the ISA note set
# add labels as you wish
IsSkewSymmetric:
	#TODO Below
	

	#TODO Above
	jr $ra
