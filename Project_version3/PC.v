`timescale 1ns / 1ps
module PC(
    input clk,                         // 时钟
    input reset,                       // 重置信号
    input change,                      // 更改信号，change=1时标志PC发生更改
    input [15:0] nextPC,               // 下一个PC
    output reg[15:0] currentPC         // 当前PC
    );

initial begin
    currentPC <= 0;
end

always@(posedge clk or posedge reset) begin
    if(reset == 1) begin
        currentPC <= 0;             // 如果接收到Reset信号，将currentPC重置为0
    end
    else begin
        if(change) begin           // 如果接收到change信号，将nextPC赋值给currentPC
            currentPC <= nextPC;
        end
        else begin                  // 如果接收到change信号(即HALT之后)，currentPC不再改变
            currentPC <= currentPC;
        end
    end
end

endmodule
