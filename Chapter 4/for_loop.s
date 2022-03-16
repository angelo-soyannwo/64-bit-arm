
.text
.global _main
.align 2


_main:
	//read data in system call
	mov w12, 0xff		// Prepare for error case 
	cmp x0, #2		// Make sure we have precisely two arguments
	bne exit		// If it is not: exit
	ldr x4, [x1, #8]	// Get the pointer at x1 + 8 (the value at x1 is the name of the executable. [x1, #8] is the next argument passed which will be some integer)
	ldrb w4, [x4]		// Load the Byte pointed to by that pointer into w4
	sub w4, w4, #'0' 	// Subtract the ascii value for '0'

loop:
	cmp x4, #0
	b.eq exit 

	//write system call
	mov x0, #1		//STDout
	mov x16, #4		// move 4 into x16 for darwin write system call
	adrp x1, hello@PAGE
	add x1, x1, hello@PAGEOFF
	mov x2, #6 		// length of string to be printed	
	svc #0x80		// system interrupt
	sub x4, x4, #1		// decrement counter

	b loop
	

exit:
	// exit system call 
	mov x16, #1		//move 1 into x16 for darwin exit system call

	mov x0, #0x41		//return value is placed in x0

	svc #0x80		// system interrupt

.data
hello:	.ascii "hello\n"
