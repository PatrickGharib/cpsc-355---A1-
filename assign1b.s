//////////////////////////////////////////////////////////////////////////////////
//										//
//			File: 	   assign1b					//
//			Author:    Patrick Abou Gharib				//
//			StudentID: 10137116					//
//			Date: 	   October 3rd, 2017				//
//										//
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
// Description: 								//
//										//
// program finds the maximum of y = -4x^3 - 27x^2 + 5x + 45 in the range of 	//
// -6 <= x <= 5 and prints the results on the screen after each itteration of 	//
// the loop within the range specified. 					//
//////////////////////////////////////////////////////////////////////////////////



				   	//string1 label defines the string "x: %ld | y: %ld | MAX: %ld" in memory

string1:	.string "x: %ld | y: %ld | MAX: %ld\n----------------------\n"
                                   
					//string3 label defines the string "Absolute maximum: %ld\n\n" in memory
string3:	.string "Absolute maximum: %ld\n\n" 

			//define x variable for x19 
			//define x20 for x20 
			//define y variable for x24
			//define Maximum for x25
			//define coefficient for x26 
			//define constant for x27 

	.balign 4                   	//makes sure the following instruction is divisible by 4
	.global main                	//makes sure the following instruction is divisible by 4 
main:                               	//create label for main 
	stp x29, x30, [sp,-16]!     	//save FP and LR to the stack 
	mov x29, sp                 	//set Fp to the stack address

	mov x20, -6               	//set the initial x value to -6 and store it into the x19 reg
	mov x25, -999               	//storing arbitrarly small number
	b loop_test			//branch to loop_test
	                  
	
loop_top:
	
	mov x26, 5			//store immeadiate in x26
	mov x27, 45			//store immeadiate in x27 
	madd x24, x26, x20, x27  //y = 5(x) + 45, uses current x20 as x value to calculate
	
	mul x19, x20, x20		//x^2 = (x)(x), multiply x20 by self to calculate x^2 
	mov x26, -27			//overwrite x26 with new immeadiate 
	madd x24, x26, x19, x24 	//y = -27(x^2) + (5x + 45), 5x + 45 is the old y value 
	
	mul x19, x19, x20		//x^3 = (x^2)(x), multiply x20 with x^2 to get x^3
	mov x26, -4			//overwrite x26 with new immeadiate
	madd x24, x26, x19, x24 	//y = -4(x^3) + (-27(x^2) + 5x + 45)
	

	cmp x24, x25			//compare the y value for current x value with the value stored in x25 
	b.lt print			//if greater than current maximum branch to update
		


update:
	mov x25, x24              	//overwrite x25 value with x24

print:
	adrp x0, string1            	//set x0 pointer to the addres of the first charter of string1
	add x0, x0, :lo12:string1  	//put contents of string1 in x0
	mov x1, x20               	//set arg2 to x19
	mov x2, x24               	//set arg3 to x24
	mov x3, x25                 	//set arg4 to x25
	bl printf                   	//printf(""x: %ld | y: %ld | x25: %ld\n----------------------\n")  
	
	add x20, x20, 1         	//increment loop counter(x20)



loop_test:                          	//create label for loop test
                                    	//pre-loop test meant to check if the x value is 
        			    	//within the  range of -6 <= x <= 5

   	cmp x20, 5                	//compare the value within the x19 register to 5 and sets flags
	b.le loop_top               	//keep running through the range of -4X^3-27x^2+5x+45 
				    	//until the x value is greater than 5, 
		                    	//then branch to end 

	

	
end:
	adrp x0, string3            	//set x0 pointer to the addres of the first charter of string3 
	add x0, x0, :lo12:string3  	//put contents of string3 in x0
	mov x1, x25                 	//set arg2 to x25
	bl printf                   	//printf("Absolute maximum: %ld\n\n")
	
	ldp x29, x30, [sp], 16      	//restore the stack
	ret			       	//return to os
