`timescale 1ns / 1ps


/*
 *  MemCode store the code need to execute
 *  if we=1 we will write an opcode to Memory
 *  we = 0, we will get and opcode to excute
 */
module MemCode (
    input clk,
    input we,
    input [15:0] IP,
    input [15:0] w_opcode,
    output [15:0] r_opcode
);


reg [15:0] Code[15:0];  //store all codes


//get code from memory
assign r_opcode = Code[$unsigned(IP)];


always @(posedge clk) begin
    if (we == 1'b1) begin
        //write opcode to memory
        Code[$unsigned(IP)] <= w_opcode;
    end
end


endmodule