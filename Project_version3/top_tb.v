/*
module top(
    input clk,
    input reset,
    output [15:0] inst,
    output [3:0] opcode,
    output [2:0] SR1,
    output [2:0] SR2,
    output [2:0] DR,
    output [4:0] imm5,
    output [15:0] SR1_value,
    output [15:0] SR2_value,
    output [15:0] DR_value,
    output [15:0] DataOut,
    output [15:0] currentPC,
    output [15:0] res
    );

*/


`timescale 1ns / 1ps
`include "top.v"

module top_tb;



reg clk;
reg reset;

wire [15:0] inst;
wire [3:0] opcode;
wire [2:0] SR1;
wire [2:0] SR2;
wire [2:0] DR;
wire [4:0] imm5;
wire [15:0] SR1_value;
wire [15:0] SR2_value;
wire [15:0] DR_value;
wire [15:0] DataOut;
wire [15:0] currentPC;
wire [15:0] res;


 top uut(
    .clk(clk),
    .reset(reset),
    .inst(inst),
    .opcode(opcode),
    .SR1(SR1),
    .SR2(SR2),
    .DR(DR),
    .imm5(imm5),
    .SR1_value(SR1_value),
    .SR2_value(SR2_value),
    .DR_value(DR_value),
    .DataOut(DataOut),
    .currentPC(currentPC),
    .res(res)
    );

initial begin

    $dumpfile("top_tb.vcd");
    $dumpvars(0, top_tb);
	reset = 1;
	clk = 1;
	#5;
	clk = 0;
	#5;
	repeat(300) begin
	reset = 0;
	clk = 1;
	#5;
	clk = 0;
	#5;
	end
	end



endmodule
