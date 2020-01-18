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

	define(x_var, x19)		//define x variable for x19 
	define(index, x20)		//define index for x20 
	define(y_var, x24)		//define y variable for x24
	define(MAX, x25)		//define Maximum for x25
	define(coef, x26)		//define coefficient for x26 
	define(const,x27)		//define constant for x27 

	.balign 4                   	//makes sure the following instruction is divisible by 4
	.global main                	//makes sure the following instruction is divisible by 4 
main:                               	//create label for main 
	stp x29, x30, [sp,-16]!     	//save FP and LR to the stack 
	mov x29, sp                 	//set Fp to the stack address

	mov index, -6               	//set the initial x value to -6 and store it into the x19 reg
	mov MAX, -999               	//storing arbitrarly small number
	b loop_test			//branch to loop_test
	                  
	
loop_top:
	
	mov coef, 5			//store immeadiate in coef
	mov const, 45			//store immeadiate in const 
	madd y_var, coef, index, const  //y = 5(x) + 45, uses current index as x value to calculate
	
	mul x_var, index, index		//x^2 = (x)(x), multiply index by self to calculate x^2 
	mov coef, -27			//overwrite coef with new immeadiate 
	madd y_var, coef, x_var, y_var 	//y = -27(x^2) + (5x + 45), 5x + 45 is the old y value 
	
	mul x_var, x_var, index		//x^3 = (x^2)(x), multiply index with x^2 to get x^3
	mov coef, -4			//overwrite coef with new immeadiate
	madd y_var, coef, x_var, y_var 	//y = -4(x^3) + (-27(x^2) + 5x + 45)
	

	cmp y_var, MAX			//compare the y value for current x value with the value stored in x25 
	b.lt print			//if greater than current maximum branch to update
		


update:
	mov MAX, y_var              	//overwrite x25 value with x24

print:
	adrp x0, string1            	//set x0 pointer to the addres of the first charter of string1
	add x0, x0, :lo12:string1  	//put contents of string1 in x0
	mov x1, index               	//set arg2 to x19
	mov x2, y_var               	//set arg3 to x24
	mov x3, MAX                 	//set arg4 to x25
	bl printf                   	//printf(""x: %ld | y: %ld | MAX: %ld\n----------------------\n")  
	
	add index, index, 1         	//increment loop counter(index)



loop_test:                          	//create label for loop test
                                    	//pre-loop test meant to check if the x value is 
        			    	//within the  range of -6 <= x <= 5

   	cmp index, 5                	//compare the value within the x19 register to 5 and sets flags
	b.le loop_top               	//keep running through the range of -4X^3-27x^2+5x+45 
				    	//until the x value is greater than 5, 
		                    	//then branch to end 

	

	
end:
	adrp x0, string3            	//set x0 pointer to the addres of the first charter of string3 
	add x0, x0, :lo12:string3  	//put contents of string3 in x0
	mov x1, MAX                 	//set arg2 to x25
	bl printf                   	//printf("Absolute maximum: %ld\n\n")
	
	ldp x29, x30, [sp], 16      	//restore the stack
	ret			       	//return to os
