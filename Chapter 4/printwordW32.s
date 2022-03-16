//
// Assembler program to print a 32 bit word from a register in hex
// to stdout.
//
// X0-X2 - parameters to linux function services
// X1 - is also address of byte we are writing
// X4 - register to print
// W5 - loop index
// W6 - current character
// X8 - linux function number
//

.global _main    // Provide program starting address
.align 2

_main:
	//load 64 bit address into x4 by inserting bits and then left shifting them out
	mov	x4,	#0x6E3A
	movk	x4,	#0x4f5D, lsl #16

	adrp	x1,	hexstr@PAGE		// create a page for start of string hexstr as it is in the .data section of the program
	add	x1,	x1,	hexstr@PAGEOFF	// load the final address of hexstr into x1
	add	x1,	x1,	#9		// start at least sig digit

// The loop is FOR W5 = 8 TO 1 STEP -1
	mov	w5,	#8			//load 8 into w5 
loop:	and	w6, 	w4, #0xf 		// mask of least sig hex digit

	cmp	w6,	#10			// If W6 >= 10 then goto letter (because in base 16 there are 0-9 and A-E)
	b.ge	letter

// Else its a number so convert to an ASCII digit
	add	w6,	w6,	#'0'
	B	cont	// goto to end if


letter:
	add	w6,	w6,	#('A'-10)	
cont:
	strb	w6,	[x1]		// store byte that was just processed
	sub	x1,	x1, 	#1	// decrement address for next digit
	lsr	x4,	x4, 	#4	// shift off the digit we just processed

// next W5
	subs	W5,	W5,	#1	// step W5 by -1
	b.ne	loop			// another for loop if not done

// Setup the parameters to print our hex number
// and then call Linux to do it.
	mov	x0, #1	    		// 1 = StdOut
	adrp	x1, hexstr@PAGE 	// start of string
	add	x1, x1, hexstr@PAGEOFF
	mov	x2, #11	    		// length of our string
	mov	x16, #4	    		// linux write system call
	svc	#0x80 	    		// Call linux to output the string

// Setup the parameters to exit the program
// and then call the kernel to do it.
	mov     x0, #0      	// Use 0 return code
        mov     x16, #1     	// System call number 1 terminates this program
        svc     #0x80           // Call kernel to terminate the program


.data
hexstr:	.ascii	"0x12345678\n"
