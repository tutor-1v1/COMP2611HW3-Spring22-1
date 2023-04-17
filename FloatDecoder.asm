https://tutorcs.com
WeChat: cstutorcs
QQ: 749389476
Email: tutorcs@163.com
# Your name:
# Your student id:
# Your email address:

.data
# Define the string messages and the array
Msg1: .asciiz "Please enter the binary representation of your single precision float number :\n"
Msg2: .asciiz "\nThe integer part is :\n"
newline: .asciiz "\n"

# 0/1 code (input code)
Entercode: .byte 0:33 #33 characters because of the end of string character

.text
.globl main
main:

	# cout << "Please enter the binary representation of your single precision float number :"<<endl;
	la $a0, Msg1
	addi $v0, $zero, 4 
	syscall	

	la $s0,Entercode # s0 base address of Entercode      
	# your code (user's code)
	li $v0, 8
	move $a0,$s0
	li $a1,33 #33 characters because of the end of string character
	syscall

	la $s0,Entercode # s0 base address of Entercode      
	move $a0,$s0
	jal ToRegister

	move $a0,$v0
	jal FloatDecoder

    # cout << "The integer part is :" << endl;
	la $a0, Msg2
	addi $v0, $zero, 4 
	syscall	

	# print ineger part
	move $a0,$v1
	addi $v0, $zero, 1
	syscall

	exit:
	addi $v0, $zero, 10 
	syscall


# Input: $a0, base address of Entercode
# Output: return value store in $v0 
# mind that the digit 31 (Most significant digit) of the binary string is at the lowest address (i.e. $a0)
# digit 0 (Least significant digit) of the binary string is at the address $a0+31
# $a0+32 is holding end of string character
ToRegister:


	li $t0,0
	li $t1,31
	li $t2,'1'
	
forloop:
	beq $t0,$t1,endforloop
 	add $t3,$t0,$a0 #$t3 is the address of current digit of the input binary string
 	lbu $t4,($t3) # load the binary digit
 	beq $t4,$t2, addone
 	j shift
 	
		
addone:
	addi $v0,$v0,1
shift:
	sll $v0,$v0,1
	addi $t0,$t0,1
	j forloop

endforloop:
	
	#add the last digit
	add $t3,$t1,$a0
	lbu $t4,($t3)
	beq $t4,$t2,addlastone
	j return

addlastone:
	addi $v0,$v0,1
	
return:	

	jr $ra

# This function does the same thing as the function FloatDecoder() in the C++ program
# $a0:IEEE754EncodedNum
# Output: $v1, integer part of the IEEE754 encoded number
# preserve registers as needed
# Note if you use the srlv/sllv instructions, you need to be very careful, they will read 
# the lower 5-digit of the $rs register and use that value for shifting. 
# For example:
# srlv $s0, $s1, $s2
# sllv $s0, $s1, $s2
# if $s2 is holding 42, srlv/sllv will not shift $s1 by 42 bits, instead they will shift 
# $s1 by 10 bits (because the lower 5 bits of $s2 is 01010_2=10

FloatDecoder:

	#TODO Below

	#TODO above
	jr $ra

