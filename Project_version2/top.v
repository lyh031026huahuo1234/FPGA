`timescale 1ns / 1ps

module top(
		input wire clk,
		input wire rst_n
    );

reg[15:0] ip;
wire[15:0] next_ip;
wire[15:0] inst;

reg[4:0] type;
reg[2:0] SR1, SR2;
reg[2:0] DR;
reg[15:0] imm;

wire[4:0] in_type;
wire[2:0] in_SR1, in_SR2;
wire[2:0] in_DR;
wire[15:0] in_imm;
wire n;
wire z;
wire p;
wire[15:0] IP;

assign in_type = type;
assign in_SR1 = SR1;
assign in_SR2 = SR2;
assign in_DR = DR;
assign in_imm = imm;
assign IP = pc;

// fetch instruction
IF If(
		.clk(clk),
		.rst_n(rst_n),
		.next_ip(next_ip),
		.ip(pc),
		.inst(inst)
	);
	
// decode instruction
ID Id(
		.inst(inst),
		.type(type),
		.SR1(SR1),
		.SR2(SR2),
		.DR(DR),
		.imm(imm)
	);

// execute instruction	
EXE Exe(
			.clk(clk),
			.rst_n(rst_n),
			.inst(inst),
			.type(in_type),
			.SR1(in_SR1),
			.SR2(in_SR2),
			.DR(in_DR),
			.imm(in_imm),
			.n(n),
			.z(z),
			.p(p), 
			.IP(pc)
	);

endmodule
