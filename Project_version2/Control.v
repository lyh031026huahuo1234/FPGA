`timescale 1ns / 1ps

module Control(
    input [15:0] IP,
    input [15:0] opcode,
    input n,
    input z,
    input p,
    input [15:0] imm,
    output [15:0] next_IP,
    output [15:0] next_IP2
);
/* the module for control the  flow of program execution*/

assign next_IP2[15:0] = IP[15:0] + 16'b1;

wire [3:0] control_code;    //get the operation code
assign control_code[3:0] = opcode[15:12];

reg [15:0] temp_next_ip;
reg judge_n;
reg judge_z;
reg judge_p;
reg judge_mode;
reg judge_BR;
reg signed[16:0] extend_imm;
reg signed[7:0] extend_8b;

assign next_IP[15:0] = temp_next_ip[15:0];

always @(*) begin
case(control_code[3:0])
    4'b1100:begin
        /* BR */
        judge_n = IP[11:11];
        judge_z = IP[10:10];
        judge_p = IP[9:9];
        judge_mode = IP[8:8];
        judge_BR = 0;

        if(judge_n == 1'b1) begin
            if(n == 1'b1) begin
                judge_BR = 1'b1;
            end
        end

        if(judge_z == 1'b1) begin
            if(z == 1'b1) begin
                judge_BR = 1'b1;
            end
        end

        if(judge_p == 1'b1) begin
            if(p == 1'b1) begin
                judge_BR = 1'b1;
            end
        end

        if(judge_BR == 1'b1) begin
            extend_8b = opcode[7:0];
				extend_imm[15:0] = {{8{opcode[7]}}, extend_8b};
            if(judge_mode == 1'b1) begin
                
                temp_next_ip[15:0] = IP[15:0] + extend_imm[15:0];
            end
            else begin
                temp_next_ip[15:0] = IP[15:0] - extend_imm[15:0];
            end
        end

        else begin
            temp_next_ip[15:0] = IP[15:0] + 16'b1;
        end

        


    end

    4'b1101: begin
        /* for JMP*/
        /* jump unconditionally*/
        judge_mode = IP[8:8];
		  
		  extend_8b = opcode[7:0];
        extend_imm[15:0] = {{8{opcode[7]}}, extend_8b};

        if(judge_mode == 1'b1) begin
            temp_next_ip[15:0] = IP[15:0] + extend_imm[15:0];
        end
        else begin
            temp_next_ip[15:0] = IP[15:0] - extend_imm[15:0];
        end


    end

    4'b1110: begin
        temp_next_ip[15:0] = imm[15:0];
    end

    4'b1111: begin
        temp_next_ip[15:0] = imm[15:0];
    end

    default: begin
        temp_next_ip[15:0] = IP[15:0] + 16'b1;
    end


endcase
end

endmodule
