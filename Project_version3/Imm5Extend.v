`timescale 1ns / 1ps
module Imm5Extend(
    input ExtSel,               // 选择信号，如果为1，进行有符号扩展；如果为0，进行无符号扩展
    input [4:0] imm5,
    output [15:0] imm16
    );

    assign imm16[4:0] = imm5;
    assign imm16[15:5] = ExtSel ? (imm5[4] ? 11'b11111111111 : 11'b00000000000) : 11'b00000000000;

endmodule
