.ORIG x3000
TRAP 0x36 ; check registers are all 0
TRAP 0x31 ; R0: x , R1: y , R2: z 
STI R0, X_ADDRESS ; Store X at x3100
STI R1, Y_ADDRESS ; Store Y at x3101
STI R2, Z_ADDRESS ; Store Z at x3102

AND R0, R0, #0 ; reset for later use
AND R1, R1, #0 ; reset for later use
AND R2, R2, #0 ; reset for later use

LDI R1, X_ADDRESS
LD R2, G_X
JSR SUBTRACT ; R1 - R2, stored in R3
STI R3, X_ADDRESS ; Store 6 at x3107
AND R3, R3, #0 ; reset for later use

LDI R1, Y_ADDRESS
LD R2, G_Y
JSR SUBTRACT ; R1 - R2, stored in R3
STI R3, Y_ADDRESS ; Store 6 at x3107
AND R3, R3, #0 ; reset for later use

LDI R1, Z_ADDRESS
LD R2, G_Z
JSR SUBTRACT ; R1 - R2, stored in R3
STI R3, Z_ADDRESS ; Store 6 at x3107
AND R3, R3, #0 ; reset for later use

HALT

SUBTRACT ; R1 - R2, stored in R3
    NOT R6, R2 ; To negate the subtrahend, we take it's 'not' value and add one. 
    ADD R6, R6, #1
    ADD R3, R1, R6 ; Then we can add that to the minuend
    BRzp ABSOLUTE
        NOT R3 R3
        ADD R3, R3, #1
    ABSOLUTE
    AND R0, R0, #0 ; reset for later use
    AND R1, R1, #0 ; reset for later use
    AND R2, R2, #0 ; reset for later use
    RET

; Note: Please do not change the names of the constants below
X_ADDRESS .FILL x3100 ; Will this interfere with anything else?
Y_ADDRESS .FILL x3101
Z_ADDRESS .FILL x3102
G_X .FILL #7
G_Y .FILL #-8
G_Z .FILL #5
GOAL_DIST .FILL #10
.END