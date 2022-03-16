
.global _main // Provide program starting address
.align 2


_main:  
	//read input data value into x4
	ldr  x4, [x1, #8]			// Get the pointer at x1 + 8 (the value at x1 is the name of the executable. [x1, #8] is the next argument passed which will be some integer)
	ldrb w4, [x4]           		// Load the Byte pointed to by that pointer into w4 (the lower 32 bits of register x4) 
	sub w4, w4, #'0'        		// Subtract the ascii value for '0'

case1:
	cmp x4, #0x1	//compare value to 1
	b.ne 	case2	// if not equal go to case2
	//write system call
	mov	x0, 	#1			//stdout
	mov	x16,	#4			//load 4 into x16 for darwin write system call
	adrp	x1,	msg1@PAGE		// load the message address page beggining to x1
	add	x1,	x1,	msg1@PAGEOFF    //load the message address page ending to x1
	mov	x2, 	#16			// length of string to be printed
	svc 	#0x80				//system interrupt
	b	exit

case2:  cmp x4,  #0x2
	b.ne	 case3
	//write system call
	mov	x0, 	#1			//stdout
	mov	x16,	#4			//load 4 into x16 for darwin write system call
	adrp	x1,	msg2@PAGE		// load the message address page beggining to x1
	add	x1,	x1,	msg2@PAGEOFF    //load the message address page ending to x1
	mov	x2, 	#16		
	svc 	#0x80				//system interrupt
	b	exit

case3:
	cmp x4, #0x3
	b.ne    default
	//write system call
	mov	x0, 	#1			//stdout
	mov	x16,	#4			//load 4 into x16 for darwin write system call
	adrp	x1,	msg3@PAGE		// load the message address page beggining to x1
	add	x1,	x1,	msg3@PAGEOFF    //load the message address page ending to x1
	mov	x2, 	#16			
	svc 	#0x80				//system interrupt	
	b	exit

default:
	//write system call
	mov	x0, 	#1				//stdout
	mov	x16,	#4				//load 4 into x16 for darwin write system call
	adrp	x1,	default_msg@PAGE		// load the message address page beggining to x1
	add	x1,	x1,	default_msg@PAGEOFF     //load the message address page ending to x1
	mov	x2, 	#42					//length of the string to be printed		
	svc 	#0x80					//system interrupt
	

exit:
	//exit system call
	mov	x0,	#0x41			//load 1 into darwin for exit system call
	mov	x16,	#1			//return value of 65 into x0 
	svc	#0x80				//system interrupt

.data
msg1: .ascii "The value was 1\n"
msg2: .ascii "The value was 2\n"
msg3: .ascii "The value was 3\n"

default_msg: .ascii "That number was not between one and three\n"
