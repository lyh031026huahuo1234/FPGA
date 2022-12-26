`timescale 1ns / 1ps
module RegFile(
    input clk,
    input RegWE,
    input [2:0] SR1,
    input [2:0] SR2,
    input [2:0] DR,
    input [15:0] DR_value,
    output [15:0] SR1_value,
    output [15:0] SR2_value
    );

    reg [15:0] register[7:0];

    integer i;
    initial begin
        for(i = 0; i < 16; i = i + 1) begin
            register[i] <= 0;
        end
    end

    // 读取源寄存器
    assign SR1_value = register[SR1];
    assign SR2_value = register[SR2];

    // 写入目的寄存器
    always @(posedge clk) begin
        if (RegWE) begin
            register[DR] = DR_value;
        end
    end

endmodule
