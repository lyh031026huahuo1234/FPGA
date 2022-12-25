`timescale 1ns / 1ps

/*    we:1 for write enable
 *     reg1,reg2:register to get num
 *     regw:register to write num
 */

module RegFile(
    input clk,
    input rst_bar,
    input [2:0] reg1,
    input [2:0] reg2,
    input [2:0] regw,
    input we, 
    input signed [15:0] regw_value,
    output reg signed [15:0] reg1_value,
    output reg signed [15:0] reg2_value

);

reg signed [15:0] mem[7:0];    //regsiters R0 to R7

initial begin
    mem[0] = 0;
    mem[1] = 0;
    mem[2] = 0;
    mem[3] = 0;
    mem[4] = 0;
    mem[5] = 0;
    mem[6] = 0;
    mem[7] = 0;

end

reg [15:0] R0;
reg [15:0] R1;
reg [15:0] R2;
reg [15:0] R3;
reg [15:0] R4;
reg [15:0] R5;
reg [15:0] R6;
reg [15:0] R7;


// assign reg1_value = mem[1];
// assign reg2_value = mem[$unsigned(reg2)];

integer i;
always @(*) begin
    R0 = mem[0];
    R1 = mem[1];
    R2 = mem[2];
    R3 = mem[3];
    R4 = mem[4];
    R5 = mem[5];
    R6 = mem[6];
    R7 = mem[7];
    reg1_value = mem[$unsigned(reg1)];
    reg2_value = mem[$unsigned(reg2)];
    if(rst_bar == 1'b0) begin
        // for (i=0; i<16; i=i+1) begin
        //     mem[i][15:0] <= 0;
        // end
    end
    else if (we == 1'b1) begin
        mem[$unsigned(regw)] <= regw_value;
    end
end

endmodule
