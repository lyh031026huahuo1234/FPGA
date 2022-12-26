`timescale 1ns / 1ps
`include "ControlUnit.v"
`include "PC.v"
`include "InstMem.v"
`include "RegFile.v"
`include "ALU.v"
`include "Memory.v"
`include "MUX.v"
`include "Imm5Extend.v"


module top(
    input clk,
    input reset,
    output [15:0] inst,
    output [3:0] opcode,
    output [2:0] SR1,
    output [2:0] SR2,
    output [2:0] DR,
    output [4:0] imm5,
    output [15:0] SR1_value,
    output [15:0] SR2_value,
    output [15:0] DR_value,
    output [15:0] DataOut,
    output [15:0] currentPC,
    output [15:0] res
    );

    wire [3:0] ALUOp; 
    wire [15:0] B, nextPC;
    wire [15:0] currentPC_2, imm16, currentPC_imm;  
    wire n, z, p, PCSel, change, ALUSrc2Sel, WriteDateSel, RegWE, InstMemRW, MemRW, ExtSel;

    /*
    module ControlUnit(
        input [15:0] inst,
        input n,
        input z,
        input p,
        output reg PCSel,           // 接入多路选择器，控制nextPC的选择
        output reg change,          // 更改信号，change=1时标志PC发生更改(主要用于对HALT的处理)
        output reg ALUSrc2Sel,      // 接入多路选择器，控制ALU运算第二个运算数SR2/imm的选择
        output reg WriteDateSel,    // 接入多路选择器，控制写入寄存器的数据的选择，ALU运算结果/内存读取值
        output reg RegWE,           // RegFile写使能信号，为1时允许写入
        output reg InstMemRW,       // InstMem读写控制信号，1为写，0为读
        output reg MemRW,           // Memory读写控制信号，1为写，0为读
        output reg ExtSel,          // Imm8Extend/Imm5Extend符号扩展选择信号，如果为1，进行有符号扩展；如果为0，进行无符号扩展
        output reg [3:0] ALUOp      // ALU操作控制
    );
    */
    //ControlUnit cu(inst, n, z, p, PCSel, change, ALUSrc2Sel, WriteDateSel, RegWE, InstMemRW, MemRW, ExtSel, ALUOp);
    ControlUnit cu(.inst(inst), .n(n), .z(z), .p(p), .PCSel(PCSel), .change(change), .ALUSrc2Sel(ALUSrc2Sel), .WriteDateSel(WriteDateSel), 
    .RegWE(RegWE), .InstMemRW(InstMemRW), .MemRW(MemRW), .ExtSel(ExtSel), .ALUOp(ALUOp));

    /*
    module PC(
        input clk,                         // 时钟
        input reset,                       // 重置信号
        input change,                      // 更改信号，change=1时标志PC发生更改
        input [15:0] nextPC,               // 下一个PC
        output reg[15:0] currentPC         // 当前PC
    );
    */
    PC pc(clk, reset, change, nextPC, currentPC);

    /*
    module InstMem(
        input InstMemRW,           // 读写控制信号，1为写，0为读
        input [15:0] addr,         // 指令地址
        output [15:0] inst,
        output [3:0] opcode,
        output [2:0] SR1,
        output [2:0] SR2,
        output [2:0] DR,
        output [4:0] imm5,
    );
    */
    InstMem im(InstMemRW, currentPC, inst, opcode, SR1, SR2, DR, imm5);

    /*
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
    */
    RegFile rf(clk, RegWE, SR1, SR2, DR, DR_value, SR1_value, SR2_value);

    /*
    module ALU(
        input [3:0] ALUOp,
        input [15:0] A,
        input [15:0] B,
        output reg n,
        output reg z,
        output reg p,
        output reg [15:0] res
    );
    */
    ALU alu(ALUOp, SR1_value, B, n, z, p, res);

    /*
    module Imm5Extend(
        input ExtSel,               // 选择信号，如果为1，进行有符号扩展；如果为0，进行无符号扩展
        input [4:0] imm5,
        output [15:0] imm16
    );
    */
    Imm5Extend ext(ExtSel, imm5, imm16);

    /*
    module Memory(
        input MemRW,                // 内存读写控制信号，1为写，0为读
        input [15:0] Addr,          // 内存地址
        input [15:0] DataIn,        // 写入的数据
        output reg [15:0] DataOut   // 输出的数据
    );
    */
    Memory memory(MemRW, res, DR_value, DataOut);

    assign currentPC_2 = currentPC + 2;
    assign currentPC_imm = currentPC_2 + (imm16 << 1);

    MUX m1(ALUSrc2Sel, imm16, SR2_value, B);
    MUX m2(WriteDateSel, DataOut, res, DR_value);
    MUX m3(PCSel, currentPC_imm, currentPC_2, nextPC);

endmodule
