import org.junit.*;

import static edu.gvsu.mipsunit.munit.MUnit.Register.*;
import static edu.gvsu.mipsunit.munit.MUnit.*;

public class Lab03Test {

	@Before
    public void randomizeRegs() {
        // randomize registers to ensure the code does not depend on simulator initialised values or 
        //  illegal parameter passing
        randomizeRegisters(v0, v1, t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, k0, k1, a0, a1, a2, a3, ra);
   	    // Set the saved registers to veryify they are preserved after the function call
        set(s0, 0x123);
        set(s1, 0x124);
        set(s2, 0x125);
        set(s3, 0x126);
        set(s4, 0x127);
        set(s5, 0x128);
        set(s6, 0x129);
        set(s7, 0x12a);
    }

    @Test 
    public void test_mult() {
        int[][] tests = { {0, 0},
                          {1, 0},
                          {0, 1},
                          {1, 1},
                          {2, 3},
                          {10, 3}};
		String[] testMsgs = {"0x0 should be 0",
                             "1x0 shoulb be 0",
                             "0x1 should be 0",
                             "1x1 should be 1",
                             "2x3 should be 6",
                             "10x3 should be 30"
                            };
        for (int i = 0; i < tests.length; i += 1) {
            randomizeRegisters(v0, v1, t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, k0, k1, a0, a1, a2, a3, ra);
            // Run the programm
			// check if sp can be checked :-))
            int initStackPtr = get(sp);
            run("mulproc", tests[i][0], tests[i][1]);
            Assert.assertEquals(testMsgs[i], tests[i][0]* tests[i][1], get(v0));
            Assert.assertEquals("$s0 should be preserved across subroutine calls", 0x123, get(s0));
            Assert.assertEquals("$s1 should be preserved across subroutine calls", 0x124, get(s1));
            Assert.assertEquals("$s2 should be preserved across subroutine calls", 0x125, get(s2));
            Assert.assertEquals("$s3 should be preserved across subroutine calls", 0x126, get(s3));
            Assert.assertEquals("$s4 should be preserved across subroutine calls", 0x127, get(s4));
            Assert.assertEquals("$s5 should be preserved across subroutine calls", 0x128, get(s5));
            Assert.assertEquals("$s6 should be preserved across subroutine calls", 0x129, get(s6));
            Assert.assertEquals("$s7 should be preserved across subroutine calls", 0x12a, get(s7));
            Assert.assertEquals("$sp should be equal to its value before the call", initStackPtr, get(sp));
        }
    }

    @Test 
    public void test_prodMul_NULL() {

        int initStackPtr = get(sp);
        run("listProd", 0);

        Assert.assertEquals("$s0 should be preserved across subroutine calls", 0x123, get(s0));
        Assert.assertEquals("$s1 should be preserved across subroutine calls", 0x124, get(s1));
        Assert.assertEquals("$s2 should be preserved across subroutine calls", 0x125, get(s2));
        Assert.assertEquals("$s3 should be preserved across subroutine calls", 0x126, get(s3));
        Assert.assertEquals("$s4 should be preserved across subroutine calls", 0x127, get(s4));
        Assert.assertEquals("$s5 should be preserved across subroutine calls", 0x128, get(s5));
        Assert.assertEquals("$s6 should be preserved across subroutine calls", 0x129, get(s6));
        Assert.assertEquals("$s7 should be preserved across subroutine calls", 0x12a, get(s7));
        Assert.assertEquals("$sp should be equal to its value before the call", initStackPtr, get(sp));
        Assert.assertEquals("Return value $v0 should be ", 1, get(v0));
    }

    @Test 
    public void test_prodMul_0() {
        Label nHead = wordData(0, 0);  // This is placed at 0x10010000 by munit

        int initStackPtr = get(sp);
        run("listProd", nHead);

        Assert.assertEquals("$s0 should be preserved across subroutine calls", 0x123, get(s0));
        Assert.assertEquals("$s1 should be preserved across subroutine calls", 0x124, get(s1));
        Assert.assertEquals("$s2 should be preserved across subroutine calls", 0x125, get(s2));
        Assert.assertEquals("$s3 should be preserved across subroutine calls", 0x126, get(s3));
        Assert.assertEquals("$s4 should be preserved across subroutine calls", 0x127, get(s4));
        Assert.assertEquals("$s5 should be preserved across subroutine calls", 0x128, get(s5));
        Assert.assertEquals("$s6 should be preserved across subroutine calls", 0x129, get(s6));
        Assert.assertEquals("$s7 should be preserved across subroutine calls", 0x12a, get(s7));
        Assert.assertEquals("$sp should be equal to its value before the call", initStackPtr, get(sp));
        Assert.assertEquals("Return value $v0 should be ", 0, get(v0));
    }

    @Test 
    public void test_prodMul() {
        Label nLast = wordData(5, 0);  // This is placed at 0x10010000 by munit
	    Label n4    = wordData(2, 0x10010000);  // This is at 0x10010008
		// Cannot do:  wordData(2, nLast.address()) because labels are not bound
		// to addresses before run()
	    Label n3    = wordData(3, 0x10010008);  // @ 0x10010010
	    Label n2    = wordData(4, 0x10010010);  // @ 0x10010018
	    Label nHead = wordData(1, 0x10010018);  // @ 0x10010020

        int initStackPtr = get(sp);
        run("listProd", nHead);

        Assert.assertEquals("$s0 should be preserved across subroutine calls", 0x123, get(s0));
        Assert.assertEquals("$s1 should be preserved across subroutine calls", 0x124, get(s1));
        Assert.assertEquals("$s2 should be preserved across subroutine calls", 0x125, get(s2));
        Assert.assertEquals("$s3 should be preserved across subroutine calls", 0x126, get(s3));
        Assert.assertEquals("$s4 should be preserved across subroutine calls", 0x127, get(s4));
        Assert.assertEquals("$s5 should be preserved across subroutine calls", 0x128, get(s5));
        Assert.assertEquals("$s6 should be preserved across subroutine calls", 0x129, get(s6));
        Assert.assertEquals("$s7 should be preserved across subroutine calls", 0x12a, get(s7));
        Assert.assertEquals("$sp should be equal to its value before the call", initStackPtr, get(sp));
        Assert.assertEquals("Return value $v0 should be ", 5*2*3*4*1, get(v0));
    }

   }
