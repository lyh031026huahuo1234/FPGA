/*二选一MUX模块*/
`timescale 1ns / 1ps
module MUX(
    input control,
    input [15:0] in1,
    input [15:0] in0,
    output [15:0] out
    );

    assign out = control ? in1 : in0;

endmodule
