
.text
.global _main
.align 2


_main:
	cmp 	x0, #1		// check that we have more than one input value
	b.le	exit		// if no, go to exit
	//read in data value
	ldr 	x4, [x1, #8]	// Get the pointer at x1 + 8 (the value at x1 is the name of the executable. [x1, #8] is the next argument passed which will be some integer)
	ldrb	w4, [x4]	// Load the Byte pointed to by that pointer into w4
	sub	w4, w4, #'0'    // Subtract the ascii value for '0'

do:
	sub	x4,	x4,	#1	//decrement our number
	b	condition		//branch to condition

condition:
	cmp	x4,	#5		//check if the number is equal to 5
	b.eq	exit			//branch to exit if yes
	b	do			//continue going to the action


exit:
	//exit system call
	mov 	x0, 	#0x41		//move 65 into x0
	mov 	x16, 	#1		//load 1 into x16 for darwin exit system call
	svc 	#0x80			//superisor call
