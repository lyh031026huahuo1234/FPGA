`timescale 1ns / 1ps

/* execute the instruction */
module EXE(
		input wire clk,
		input wire rst_n,
		input wire[15:0] inst,
		input wire[4:0] type,
		input wire[2:0] SR1,
		input wire[2:0] SR2,
		input wire[2:0] DR,
		input wire[15:0] imm,
		input wire [15:0] IP,
		output reg[15:0] next_IP
    );

wire signed [15:0] SR1_value;
wire signed [15:0] SR2_value;
wire signed [15:0] DR_value;
//wire[15:0] next_IP;

reg we;

reg n;
reg z;
reg p;

RegFile regfile(.clk(clk), .rst_bar(rst_n), .reg1(SR1), .reg2(SR2), .regw(DR), .we(we), 
				.regw_value(DR_value), .reg1_value(SR1_value), .reg2_value(SR2_value));

assign IP = next_IP;

always @(*) begin
	ALU alu(.regA(SR1_value), .regB(SR2_value), .imm(imm),.opcode(inst), .n(n), .z(z), .p(p),.IP(IP),.next_IP(next_IP),.res(DR_value));
	Control ctrl2(.IP(IP), .opcode(inst), .n(n), .z(z), .p(p), .next_IP2(DR_value), next_IP(next_IP), .imm(imm));
	case(type)
		5'b00110,
		5'b00111,
		5'b00100,
		5'b00101,
		5'b10001:
			begin
				we = 1;
			end
		default:
			begin
				we = 0;
			end
	endcase
end
endmodule
