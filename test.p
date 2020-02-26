#include "jpp-pru-lib.hp" 
#include "pwm-registers.hp"

    
//////////////////////////
// Named registers  
//////////////////////////

#define tmp0                r1
#define tmp1                r2

    
    .setcallreg  r29.w2  // Use R29.W2 in the CALL/RET pseudo ops, not the default of r30 (used for GPIOS)
    .origin 0
    .entrypoint INIT

INIT:

    // init registers
    mov r0, INITIAL_REG_VALUE
    mov r1, INITIAL_REG_VALUE

        CLR  tmp0.t0
        SBBO tmp0, tmp1, OFFSET_CTRL, 4
        CLR  tmp0.w4
        SBBO tmp0, tmp1, OFFSET_CTRL, 4


    // Set up the PRU's ability to access memory outside its own private 8kB
    // http://exploringbeaglebone.com/chapter13/#The_Programs
    LBCO tmp0, C4, 4, 4 // Load Bytes Constant Offset (?)
    CLR  tmp0, tmp0, 4  // Clear bit 4 
    SBCO tmp0, C4, 4, 4 // Store Bytes Constant Offset

  // (The cycle counter lives in this family at offset 0xC)
    //http://theembeddedkitchen.net/beaglelogic-building-a-logic-analyzer-with-the-prus-part-1/449

    MOV    tmp1,    0x22028  // Constant table Programmable Pointer Register 0
    MOV    tmp2,    0x00000220  
    SBBO   tmp2,    tmp1, 0, 4