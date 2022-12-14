`timescale 1ns / 1ps

/* decode instruction */
module ID(
		input wire[15: 0] inst,
		output reg[4:0] type,		// type[4] = 1 means Function Call operation
		output reg[2:0] SR1,		// type[3] = 1 means Control operation
		output reg[2:0] SR2,		// type[2] = 1 means ALU operation
		output reg[2:0] DR,			// type[1] = 1 means binocular operation / type[1] = 0 means moncular operation
		output reg[15:0] imm		// type[0] = 1 means operation refers to immediate number
    );
	 
reg signed[4:0] extend_5b;
reg signed[7:0] extend_8b;

always @(*) begin
		case(inst[15:12])
		4'b0000,		// ADD
		4'b0010, 	// SUB
		4'b0011,		// AND
		4'b0100,		// OR
		4'b0101,		// XOR
		4'b0110,		// MUL
		4'b0111:		// DIV
			begin
				case(inst[5])
				1'b0: begin
						type = 5'b00110;
						SR1 = inst[8:6];
						SR2 = inst[2:0];
						DR = inst[11:9];
					end
				1'b1: begin
						type = 5'b00111;
						SR1 = inst[8:6];
						DR = inst[11:9];
						extend_5b = inst[4:0];
						imm = {{8{inst[4]}}, extend_5b};
					end
				endcase
			end
		4'b0001,		// NOT
		4'b1000,		// SHL
		4'b1001:		// SHR
			begin
				type = 5'b00100;
				SR1 = inst[11:9];
				DR = inst[11:9];
			end
		4'b1010:		// CMP
			begin
				type = 5'b00110;
				SR1 = inst[8:6];
				SR2 = inst[2:0];
			end
		4'b1011:		// LD
			begin
				case(inst[8])
					1'b0: begin
						type = 5'b00101;
						DR = inst[11:9];
						extend_8b = inst[7:0];
						imm = {{8{inst[7]}}, extend_8b};
					end
					1'b1: begin
						type = 5'b00100;
						DR = inst[11:9];
						SR1 = inst[7:5];
					end
				endcase
			end
		4'b1100,		// BR
		4'b1101:		// JMP
			begin
				type = 5'b01001;
				extend_8b = inst[7:0];
				imm = {{8{inst[7]}}, extend_8b};
			end
		4'b1110:		// CALL
			begin
				type = 5'b10001;
				SR1 = inst[10:8];
				DR[2:0] = 3'b111;
				extend_8b = inst[7:0];
				imm = {{8{inst[7]}}, extend_8b};
			end
		4'b1111:		// RET
			begin
				type = 5'b10000;
				SR1[3:0] = 3'b111;
			end
		default:
			begin
				type = 5'b00000;
			end
		endcase
end

endmodule
