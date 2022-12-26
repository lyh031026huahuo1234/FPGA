`timescale 1ns / 1ps
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

    reg[7:0] mem[0:63];        // 定义一个64大小的8位寄存器数组来保存从文件输入的全部指令(最多存储32条指令)
                               // 每条指令16位，前半部分和后半部分分别存储在mem[addr]和mem[addr + 1]中

    initial begin
        $readmemb("test/test.txt", mem);    //读取测试文档中的指令
    end

    // 根据指令地址提取指令信息
    assign inst[15:8] = mem[addr];
    assign inst[7:0] = mem[addr + 1];
    assign opcode = mem[addr][7:4];
    assign DR = mem[addr][3:1];
    assign SR1[2] = mem[addr][0];
    assign SR1[1:0] = mem[addr + 1][7:6];
    assign SR2 = mem[addr + 1][2:0];
    assign imm5 = mem[addr + 1][4:0];

endmodule
