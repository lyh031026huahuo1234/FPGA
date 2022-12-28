/*对栈指针进行选择的模块*/
`timescale 1ns / 1ps
module SPMUX (
    input PopControl,
    input PushControl,
    input [15:0] push_sp,
    input [15:0] pop_sp,
    input [15:0] current_sp,
    output [15:0] out
);

 assign out = PopControl ? pop_sp : PushControl ? push_sp : current_sp;

endmodule