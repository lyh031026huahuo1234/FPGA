`timescale 1ns / 1ps
//在这个Module中存储了使用到的寄存器
//SR1, SR2为要读取的寄存器
//DR为将要写入的寄存器
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

    //在这个module中管理了8个寄存器,每个寄存器的数据为16位
    reg [15:0] register[7:0];
    reg [15:0] R0;
    reg [15:0] R1;
    reg [15:0] R2;
    reg [15:0] R3;
    reg [15:0] R4;
    reg [15:0] R5;
    reg [15:0] R6;
    reg [15:0] R7;
    

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
        R0 = register[0];
        R1 = register[1];
        R2 = register[2];
        R3 = register[3];
        R4 = register[4];
        R5 = register[5];
        R6 = register[6];
        R7 = register[7];

        //写使能信号
        if (RegWE) begin
            register[DR] = DR_value;
        end
    end

endmodule
