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
	case(type)
			5'b00110: begin
	
				we = 0;
				ALU alu(.regA(SR1_value), .regB(SR2_value), .imm(imm),.opcode(inst), .n(n), .z(z), .p(p),.IP(IP),.next_IP(next_IP),.res(DR_value));
				we = 1;
		
				end
			5'b00111: begin		// 3'b0 for the default register and 16'h0 for the default register value
				
				we = 0;
				ALU alu(.regA(SR1_value), .regB(16'h0), .opcode(inst), .n(n), .z(z), .p(p),.IP(IP),.next_IP(next_IP), .res(DR_value));
				we = 1;
			
				end
			5'b00100: begin
			
				we = 0;
				ALU alu(.regA(SR1_value), .regB(16'h0), .opcode(inst), .n(n), .z(z), .p(p),.IP(IP),.next_IP(next_IP), .res(DR_value));
				we = 1;
			
				end
			5'b00101: begin
				ALU alu(.regA(16'h0), .regB(16'h0), .opcode(inst), .n(n), .z(z), .p(p), .IP(IP),.next_IP(next_IP),.res(DR_value));
				we = 1;
				
				end
			5'b01001: begin
				Control ctrl1(.IP(IP), .opcode(inst), .n(n), .z(z), .p(p),.next_IP(next_IP));
				end
			5'b10001: begin
				// to fill
				/*call*/
				Control ctrl1(.IP(IP), .opcode(inst), .n(n), .z(z), .p(p), .next_IP2(DR_value), next_IP(next_IP), .imm(imm));
				we = 1;

				end
			5'b00000: begin
				// to fill
				/*ret*/
				we = 0;
				//then SR1_value store the IP should be changed to
				Control ctrl1(.IP(IP), .opcode(inst), .n(n), .z(z), .p(p), next_IP(next_IP), .imm(imm));
				end
	endcase
end
endmodule
