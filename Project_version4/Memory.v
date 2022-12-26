`timescale 1ns / 1ps
module Memory(
    input MemRW,                // 内存读写控制信号，1为写，0为读
    input PopControl,         //为1时进行栈的操作
    input PushControl,         
    input [15:0]CurrentSP,            //在栈操作时CurrentSP代表内存地址,Addr为要存放的数据
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
    wire [7:0] s1;
    wire [7:0] s2;
    wire [7:0] s3;
    wire [7:0] s4;
    wire [7:0] s5;
    wire [7:0] s6;
    wire [7:0] s7;
    wire [7:0] s8;
    wire [7:0] s9;
    wire [7:0] s10;
    wire [7:0] s11;

    assign s1 = memory[63];
    assign s2 = memory[62];
    assign s3 = memory[61];
    assign s4 = memory[60];
    assign s5 = memory[59];
    assign s6 = memory[58];
    assign s7 = memory[57];
    assign s8 = memory[56];
    assign s9 = memory[55];
    assign s10 = memory[54];
    assign s11 = memory[53];



    always @(*) begin
        // 写内存
        if (MemRW) begin
            if(PushControl) begin
                memory[CurrentSP] <= Addr[15:8];
                memory[CurrentSP+1] <= Addr[7:0];
            end
            else begin
            memory[Addr] <= DataIn[15:8];
            memory[Addr + 1] <= DataIn[7:0];
            end
        end
        // 读内存
        else begin
            if(PopControl) begin
                DataOut[15:8] <= memory[CurrentSP+3];
                DataOut[7:0] <= memory[CurrentSP+2];
            end
            else begin
            DataOut[15:8] <= memory[Addr];
            DataOut[7:0] <= memory[Addr + 1];
            end
        end
    end

endmodule
