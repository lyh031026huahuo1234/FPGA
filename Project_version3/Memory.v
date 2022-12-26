`timescale 1ns / 1ps
module Memory(
    input MemRW,                // 内存读写控制信号，1为写，0为读
    input [15:0] Addr,          // 内存地址
    input [15:0] DataIn,        // 写入的数据
    output reg [15:0] DataOut   // 输出的数据
    );

    // 模拟内存，以8位为一字节存储，共64字节
    reg [7:0] memory[0:63];

     initial begin
        $readmemb("test/Mem.txt", memory);    //读取测试文档中的指令
    end

    // integer i;
    // initial begin
    //     for (i = 0; i < 64; i = i + 1) begin
    //         memory[i] <= 0;
    //     end
    // end

    always @(Addr or DataIn) begin
        // 写内存
        if (MemRW) begin
            memory[Addr] <= DataIn[15:8];
            memory[Addr + 1] <= DataIn[7:0];
        end
        // 读内存
        else begin
            DataOut[15:8] <= memory[Addr];
            DataOut[7:0] <= memory[Addr + 1];
        end
    end

endmodule
