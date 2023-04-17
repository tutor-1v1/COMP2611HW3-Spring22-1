https://tutorcs.com
WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
# Your name:
# Your student id:
# Your email address:

.data
# output messages
initMsg: .asciiz "Please enter integers in array A[] one by one:\n"
EnterNumberMsg1: 	.asciiz "A["
EnterNumberMsg2: 	.asciiz "]: "
OutputMsg1: .asciiz "Here is the accumulative array of A:\n"
space: .asciiz" "
newLine: .asciiz"\n"

# array A[] has 10 elements, each element is of the size of one word, 32 bits.
A: .word 0:10
# array Accum[], 10 elements.
Accum: .word 0:10
# size: the number of elements in array A[]
size: .word 10

.text
.globl main

main:
	la $s0,A        #$s0 base address of array A[]
	la $s1,size
	lw $s1,0($s1)   #$s1 size of array A[]
	la $s2,Accum    #$s3 base address of array Accum
	
	
	# cout << "Please enter integers in array A[] one by one:\n"
	la $a0, initMsg
	addi $v0, $zero, 4
	syscall
	
	li $t0,0  # iterator i for printing A
	
input_array:
	beq $t0,$s1,exit_input
	
	# cout << "A["
	la $a0, EnterNumberMsg1
	addi $v0, $zero, 4
	syscall
	
	# print index
	move $a0,$t0
	addi $v0, $zero, 1
	syscall
	
	# cout << "]: "
	la $a0, EnterNumberMsg2
	addi $v0, $zero, 4
	syscall
	
	# read user input in $v0
	li $v0, 5
	syscall
	
	sll $t1,$t0,2
	add $t1,$t1,$s0 # $t1 = i*4 + base of A in $s0, addr of A[i]
	sw $v0, 0($t1)  # A[i] = $v0
	addi $t0,$t0,1
	j input_array
	
exit_input:
	
	add $a0,$s0,$zero
	add $a1,$s1,$zero
	add $a2,$s2,$zero
	jal AccumulateArray


	# cout << "Here is the accumulative array of A:" << endl;
	la $a0, OutputMsg1
	addi $v0, $zero, 4
	syscall

	li $t0,0  # iterator i for printing Accum
	
print_accum:
	beq $t0,$s1,exit

	# print Accum[i]
	sll $t1,$t0,2
	add $t1,$t1,$s2 # $t1 = i*4 + base of Accum in $s2, addr of Accum[i]
	lw $a0, 0($t1)  # $v0 = Accum[i]
	addi $v0, $zero, 1
	syscall
	la $a0, space
	addi $v0, $zero, 4
	syscall				# cout << Accum[i] << ' ';

	addi $t0,$t0,1  # i++
	j print_accum
	

exit:
	
	li $v0, 10 
	syscall	
	
# This function does the same thing as the function AccumulateArray() in the C++ program
# arguments are in $a0, $a1 and $a2
# $a0: base address of array A[]
# $a1: size of array A[] 
# $a2: base address of array Accum[]
# Return value: no return value.
# The calculated results are saved in Accum[].
# preserve registers as needed according to slide 76 of the ISA note set
# add labels as you wish

AccumulateArray:
	#TODO Below
	
	#TODO Above
	jr $ra
	
