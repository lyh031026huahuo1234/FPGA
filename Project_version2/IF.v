`timescale 1ns / 1ps

/* fetch instruction */

`timescale 1ns / 1ps

/* fetch instruction */
module IF(
		input wire clk,
		input wire rst_n,						// br = 1'b1 means the next pc should be loaded with br_pc
		input wire[15:0] next_ip,			// br_pc refers to the next pc of operation "BR" / "JMP" / "CALL"
		output reg[15:0] ip,
		output wire[15: 0] inst
    );

reg [15:0] insts[65535:0];				// memory to store instructions
assign inst = insts[$unsigned(next_ip)];

always @ (posedge clk or negedge rst_n) begin
		// reset pc to -1 but not 0
		// it confirms that the first instruction won't be ignored
		if (~rst_n) begin
			ip <= 0;
			// store the instructions
			insts[0] <= 16'b0011001001100000,  // AND R1, R1, #0   R1 = 0
			insts[1] <= 16'b0011010010100000,  // AND R2, R2, #0   R1 = 0  R2 = 0
			insts[2] <= 16'b0000001001100001,  // ADD R1, R1, #1   R1 = 1  R2 = 0
			insts[3] <= 16'b0000010010100011,  // ADD R2, R2, #3   R1 = 1  R2 = 3
			insts[4] <= 16'b0000011010000001,  // ADD R3, R2, R1   R1 = 1  R2 = 3  R3 = 4
			insts[5] <= 16'b0001001000000000,  // NOT R1           R1 = -2 R2 = 3  R3 = 4
			insts[6] <= 16'b0010001010000011,  // SUB R1, R3, R2   R1 = 1  R2 = 3  R3 = 4
			insts[7] <= 16'b0110011010000001,  // MUL R3, R2, R1   R1 = 1  R2 = 3  R3 = 3
			insts[8] <= 16'b0100001010000001,  // OR  R1, R3, R1   R1 = 3  R2 = 3  R3 = 3
			insts[9] <= 16'b0101001001000010,  // XOR R1, R1, R2   R1 = 0  R2 = 3  R3 = 3
			insts[10] <= 16'b1000010100000000,  // SHL R2           R1 = 0  R2 = 6  R3 = 3
			insts[11] <= 16'b1001011000000000,  // SHR R3           R1 = 0  R2 = 6  R3 = 1
			insts[12] <= 16'b0000010010111111,  // ADD R2, R2, #-1  R1 = 0  R2--    R3 = 1
			insts[13] <= 16'b1100110100000010;  // BRnz #-2
		end
		else begin
			ip <= next_ip;
		end
end

// inst_mem irom(.a(ip), .spo(inst));

endmodule