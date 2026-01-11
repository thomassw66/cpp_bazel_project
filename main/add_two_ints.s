.global _examples_add_two_ints
.align 4  // Align the next instruction to a 4 byte memory 

_examples_add_two_ints:
	stp x29, x30, [sp, #-16]! ; store the Frame Pointer (FP) and link register (LR) onto the stack 
	mov x29, sp               ; set the Frame Pointer to the current Stack Pointer 

	add x0, x0, x1

	mov sp, x29
	ldp x29, x30, [sp], #16   ; restore Frame Pointer (FP) and Link Register (LR) from the stack 
	ret												; return from the function

