//
// Example of 128-Bit subtraction with the ADD/ADC instructions.
//
.global _main	            // Provide program starting address to linker
.align 2

// Load the registers with some data
// First 64-bit number is 0x00000000000000070000000000000001
_main:	mov	X2, #0x0000000000000007 // load in the higher order bits
	mov	X3, #0x0000000000000001	// load in the lower order bits

// Second 64-bit number is 0x00000000000000050000000000000001
	mov	X4, #0x000000000000005 // load the first half of the 64 bit in
	mov	X5, #0x000000000000001 //load in the lower half of the second 64 bit number


	subs    X3, X3, X5
	sbc     X2, X2, X4
	add     X7, X2, X3
// Setup the parameters to exit the programc
// and then call the kernel to do it.
// R0 is the return code and will be what we
// calculated above.

	mov     x16, X7 // System call number 1 terminates this program
	svc	#0x80	// Call kernel to terminate the program
