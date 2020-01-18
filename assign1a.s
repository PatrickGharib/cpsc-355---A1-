//File: assign1a
//Author: Patrick Abou Gharib
//StudentID: 10137116
//Date: October 3rd, 2017
//
//description: 
//program finds the maximum of y = -4x^3 - 27x^2 + 5x + 45 in the range of -6 <= x <= 5
//and prints the results on the screen after each itteration of the loop within the range
//specified. 





        				//string1 label defines the string "x: %ld | y: %ld | MAX: %ld" in memory
string1:	.string "x: %ld | y: %ld | MAX: %ld\n----------------------\n"
	
        				//string3 label defines the string "Absolute maximum: %ld\n\n" in memory
string3:	.string "Absolute maximum: %ld\n\n" 

	.balign 4			//makes sure the following instruction is divisible by 4
	.global main			//ensures that the "main" label is visible to the linker

main:        				//create label for main
        				
	stp x29, x30, [sp,-16]!  	//save FP and LR to the stack
	mov x29, sp             	//set Fp to the stack address 

	mov x19, -6             	//set the initial x value to -6 and store it into the x19 reg
	mov x25, -999    		//storing arbitrarly small number
	
loop_test:				//create label for loop test
					//pre-loop test meant to check if the x value is 
        				//within the  range of -6 <= x <= 5
	                            
	cmp x19, 5             		//compare the value within the x19 register to 5 and sets flags
	b.gt end                	//keep running through the range of -4X^3-27x^2+5x+45 
					//until the x value is greater than 5, 
					//then branch to end 
loop_top:
	
	mul x20, x19, x19       	//a = x * x, a(store in register x20) is x^2 and will eventually be used to calulate x^3 used to calculate T0  
	mov x21, x20           		//set b = a, b(store in register x21) is x^2, which will be used to calculate T1
	mul x20, x20, x19       	//a = a * x, a(overwrite register x20) is now x^3 

	mov x26, -4                 	//store immeadiate into register x26, -4 is the coefficient of a
	mul x20, x20, x26       	//T0 = a * -4, T0(overwrite  register x20) will be used to calculate y and maximum of the function

	mov x26, -27                	//override register x26 with immeadiate, -27 is the coefficient of b 
	mul x21, x21, x26       	//T1 = b * -27, T1(overwrite  register x21) will be used to calculate y and maximum of the function


	mov x26, 5			//overwrite register x26 with 5, 5 is the coefficient of T2
	mul x22, x19, x26       	//T2 = x * 5, T2(store in register x22)  will be used to calculate y and maximum of the function

	mov x23, 45			//store immeadiate in register x23, 45 is T4

	add x24, x20, x21		//y = T0 + T1, y is stored in x24 register  
	add x24, x24, x22		//y = y + T2 = (T0 + T1) + T2, add x22 to x24 
	add x24, x24, x23		//y = y + T3 = (T0 + T1 + T2) + T3, 

	cmp x24, x25			//compare the y value for current x value with the value stored in x25       
	b.gt update			//if greater than current maximum branch to update
	b print				//branch to print 

update:

	mov x25, x24			//overwrite x25 value with x24
	
print:

	adrp x0, string1		//set x0 pointer to the addres of the first charter of string1      
	add x0, x0, :lo12:string1	//put contents of string1 in x0
	mov x1, x19                	//set arg2 to x19
	mov x2, x24                 	//set arg3 to x24
	mov x3, x25                 	//set arg4 to x25
	bl printf                   	//printf(""x: %ld | y: %ld | MAX: %ld\n----------------------\n")    
	
	add x19, x19, 1             	//increment loop counter(x value)
	b loop_test                 	//verify loop condition still holds


	
end:
	adrp x0, string3            	//set x0 pointer to the addres of the first charter of string3    
	add x0, x0, :lo12:string3  	//put contents of string3 in x0
	mov x1, x25                	//set arg2 to x25 
	bl printf                   	//printf("Absolute maximum: %ld\n\n")
	
	ldp x29, x30, [sp], 16     	//restore the stack
	ret                         	//return to os
