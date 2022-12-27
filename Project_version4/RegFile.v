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
    wire [15:0] R0;
    wire [15:0] R1;
    wire [15:0] R2;
    wire [15:0] R3;
    wire [15:0] R4;
    wire [15:0] R5;
    wire [15:0] R6;
    wire [15:0] R7;
    
    initial begin
        $readmemb("test/reg.txt", register);    //读取测试文档中的指令
    end
    // integer i;
    // initial begin
    //     for(i = 0; i < 16; i = i + 1) begin
    //         register[i] <= 0;
    //     end
    // end

    // 读取源寄存器
    assign SR1_value = register[SR1];
    assign SR2_value = register[SR2];

    assign        R0 = register[0];
    assign    R1 = register[1];
    assign    R2 = register[2];
     assign   R3 = register[3];
     assign   R4 = register[4];
     assign   R5 = register[5];
     assign   R6 = register[6];
     assign   R7 = register[7];

    // 写入目的寄存器
    always @(negedge clk) begin
       
        //写使能信号
        if (RegWE==1'b1) begin
            register[DR] = DR_value;
        end




    end

endmodule
