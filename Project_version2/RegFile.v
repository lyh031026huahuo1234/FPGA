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
    output signed [15:0] reg1_value,
    output signed [15:0] reg2_value

);

reg [15:0] mem[7:0];    //regsiters R0 to R7

assign reg1_value = mem[$unsigned(reg1)];
assign reg2_value = mem[$unsigned(reg2)];

integer i;
always @(*) begin
    if(rst_bar == 1'b0) begin
        for (i=0; i<16; i=i+1) begin
            mem[i][15:0] <= 0;
        end
    end
    else if (we == 1'b1) begin
        mem[$unsigned(regw)] <= regw_value;
    end
end

endmodule
