/*栈指针寄存器*/
`timescale 1ns / 1ps
module SP(
    input clk,                         // 时钟
    input reset,                       // 重置信号
    input changeSP,                      // 更改信号，changeSP=1时标志SP发生更改
    input [15:0] nextSP,               // 下一个SP
    output reg[15:0] currentSP         // 当前SP
    );
//currentPC代表了将要取得的指令的地址
//将这个地址首先初始化为0
initial begin
    currentSP <= 62;
end

always@(posedge clk or posedge reset) begin
    if(reset == 1) begin
        currentSP <= 62;             // 如果接收到Reset信号，将currentPC重置为0
    end
    else begin
        if(changeSP) begin           // 如果接收到change信号，将nextPC赋值给currentPC
            currentSP <= nextSP;
        end
        else begin                  // 如果接收到change信号(即HALT之后)，currentPC不再改变
            currentSP <= currentSP;
        end
    end
end

endmodule
