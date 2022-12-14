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
		input wire n,
		input wire z,
		input wire p,
		input wire IP
    );

wire signed [15:0] SR1_value;
wire signed [15:0] SR2_value;
wire signed [15:0] DR_value;
wire[15:0] next_IP;

assign IP = next_IP;

always @(*) begin
	case(type)
			5'b00110: begin
				RegFile regfile1(.clk(clk), .rst_bar(rst_n), .reg1(SR1), .reg2(SR2), .regw(DR), .we(1'b0), 
				.regw_value(DR_value), .reg1_value(SR1_value), .reg2_value(SR2_value));
				ALU alu(.regA(SR1_value), .regB(SR2_value), .opcode(inst), .n(n), .z(z), .p(p), .res(DR_value));
				RegFile regfile2(.clk(clk), .rst_bar(rst_n), .reg1(SR1), .reg2(SR2), .regw(DR), .we(1'b1), 
				.regw_value(DR_value), .reg1_value(SR1_value), .reg2_value(SR2_value));
				end
			5'b00111: begin		// 3'b0 for the default register and 16'h0 for the default register value
				RegFile regfile3(.clk(clk), .rst_bar(rst_n), .reg1(SR1), .reg2(3'b000), .regw(DR), .we(1'b0), 
				.regw_value(DR_value), .reg1_value(SR1_value), .reg2_value(SR2_value));
				ALU alu(.regA(SR1_value), .regB(16'h0), .opcode(inst), .n(n), .z(z), .p(p), .res(DR_value));
				RegFile regfile4(.clk(clk), .rst_bar(rst_n), .reg1(SR1), .reg2(3'b000), .regw(DR), .we(1'b1), 
				.regw_value(DR_value), .reg1_value(SR1_value), .reg2_value(SR2_value));
				end
			5'b00100: begin
				RegFile regfile5(.clk(clk), .rst_bar(rst_n), .reg1(SR1), .reg2(3'b000), .regw(DR), .we(1'b0), 
				.regw_value(DR_value), .reg1_value(SR1_value), .reg2_value(SR2_value));
				ALU alu(.regA(SR1_value), .regB(16'h0), .opcode(inst), .n(n), .z(z), .p(p), .res(DR_value));
				RegFile regfile6(.clk(clk), .rst_bar(rst_n), .reg1(SR1), .reg2(3'b000), .regw(DR), .we(1'b1), 
				.regw_value(DR_value), .reg1_value(SR1_value), .reg2_value(SR2_value));
				end
			5'b00101: begin
				ALU alu(.regA(16'h0), .regB(16'h0), .opcode(inst), .n(n), .z(z), .p(p), .res(DR_value));
				RegFile regfile7(.clk(clk), .rst_bar(rst_n), .reg1(3'b000), .reg2(3'b000), .regw(DR), .we(1'b1), 
				.regw_value(DR_value), .reg1_value(SR1_value), .reg2_value(SR2_value));
				end
			5'b01001: begin
				Control ctrl(.IP(IP), .opcode(inst), .n(n), .z(z), .p(p), .next_IP(next_IP));
				end
			5'b10001: begin
				// to fill
				end
			5'b00000: begin
				// to fill
				end
	endcase
end
endmodule
