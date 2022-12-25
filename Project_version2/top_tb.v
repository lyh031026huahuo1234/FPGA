`timescale 1ns / 1ps
`include "top.v"

module top_tb;



reg clk;
reg rst_n;

top uut (
    .clk(clk),
    .rst_n(rst_n)
);

initial begin

    $dumpfile("top_tb.vcd");
    $dumpvars(0, top_tb);
	rst_n = 0;
	clk = 0;
	#5;
	clk = 1;
	#5;
	repeat(300) begin
	rst_n = 1;
	clk = 0;
	#5;
	clk = 1;
	#5;
	end
	end



endmodule
