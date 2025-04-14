xstart      DEFW    -400
xstep       DEFW    10
xend        DEFW    400

ystart      DEFW    -265
ystep       DEFW    10
yend        DEFW    265

        ALIGN

main
        LDR R1, =xstart
        LDR R1, [R1]
        LDR R2, =xend
        LDR R2, [R2]
        LDR R3, =xstep
        LDR R3, [R3]

y_axis_loop
        LDR R4, =ystart
        LDR R4, [R4]
        LDR R5, =yend
        LDR R5, [R5]
        LDR R6, =ystep
        LDR R6, [R6]

y_loop_start
        CMP R4, R5
        BGE end_y_axis_loop

        MOV R7, R1

x_axis_loop
        CMP R7, R2
        BGE next_y

        MOV R9, #1
        MOV R9, R9, LSL #12      

        MOV R10, #0
        MOV R11, #0
        MOV R12, #0
        MOV R13, #0

do_while
        SUB R14, R11, R12
        ADD R14, R14, R7
        MUL R13, R10, R13
        ADD R13, R13, R13
        MOV R13, R13, ASR #8
        ADD R13, R13, R4
        MOV R10, R14
        MUL R11, R10, R10
        MOV R11, R11, ASR #8
        MUL R12, R13, R13
        MOV R12, R12, ASR #8
        ADD R14, R11, R12

        CMP R14, #1024
        BGT end_do_while
        SUBS R9, R9, #1
        
        BNE do_while

end_do_while
        CMP R9, #0
        BEQ print_blank

        MOV R0, #'*'
        SWI 0
        B continue_x_axis_loop

print_blank
        MOV R0, #' '
        SWI 0

continue_x_axis_loop
        ADD R7, R7, R3
        B x_axis_loop

next_y
        MOV R0, #10
        SWI 0
        ADD R4, R4, R6
        B y_loop_start

end_y_axis_loop
        SWI 2
