
//
// 192-bit addition.
//no idea if this works

.global _main
.align 2

// Load the registers with some data
// First 96-bit number is 0x00000000000000040000000000000003FFFFFFFFFFFFFFFF

_main: mov x2, #0x0000000000000004 //Load in the first 32 bits
       mov x3, #0x0000000000000003 //Load in the second 32 bits
       mov x4, #0xFFFFFFFFFFFFFFF5 //Load in the third 32 bits

// First 96-bit number is 0x000000000000000500000000000000050000000000000001
       mov x5, #0x0000000000000005 //Load in the first 32 bits
       mov x6, #0x0000000000000005 //Load in the second 32 bits
       mov x7, #0x0000000000000001 //Load in the third 32 bits

       adds x10, x7, x4 // add lower order bits
       adc x9, x6, x3 // add middle order bits
       adc x8, x5, x2 // add higher order bits

// Setup the parameters to exit the programc
// and then call the kernel to do it.
// R0 is the return code and will be what we
// calculated above. 
       mov x16, #1 // System call number 1 terminates this program
       svc #0x80   // transfer control to linux kernel

