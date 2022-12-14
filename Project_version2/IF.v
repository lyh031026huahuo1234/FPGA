`timescale 1ns / 1ps

/* fetch instruction */
module IF(
		input wire clk,
		input wire rst_n,						// br = 1'b1 means the next pc should be loaded with br_pc
		input wire[15:0] next_ip,			// br_pc refers to the next pc of operation "BR" / "JMP" / "CALL"
		output reg[15:0] ip,
		output wire[15: 0] inst
    );

always @ (posedge clk or negedge rst_n) begin
		// reset pc to -1 but not 0
		// it confirms that the first instruction won't be ignored
		if (~rst_n) begin
			ip <= 0;
		end
		else begin
			ip <= next_ip;
		end
end

inst_mem irom(.a(ip), .spo(inst));

endmodule
