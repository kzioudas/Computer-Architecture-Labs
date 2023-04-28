
# lab02.asm - Binary search in an array of 32bit signed integers
#   coded in  MIPS assembly using MARS
# for MYΥ-505 - Computer Architecture, Fall 2020
# Department of Computer Science and Engineering, University of Ioannina
# Instructor: Aris Efthymiou

        .globl bsearch # declare the label as global for munit
        
###############################################################################
        .data
sarray: .word 1, 5, 9, 20, 321, 432, 555, 854, 940

###############################################################################
        .text 
# label main freq. breaks munit, so it is removed...
        la         $a0, sarray
        li         $a1, 9
		li         $a2, 1  # the number sought


bsearch:
###############################################################################
# Write you code here.
# Any code above the label bsearch is not executed by the tester! 
###############################################################################
   
	

###############################################################################
# End of your code.
###############################################################################
exit:
        addiu      $v0, $zero, 10    # system service 10 is exit
        syscall                      # we are outta here.


