`timescale 1ns / 1ps
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

initial begin
    ExtSel = 0;
    change = 1;
    InstMemRW = 1;
    RegWE = 0;
    ALUOp = 0;
    PCSel = 0;
    ALUSrc2Sel = 0;
    MemRW = 0;
    WriteDateSel = 0;
end

always @(*) begin 
    case(inst[15:12]) 
    // ADD
    4'b0000: begin
        case(inst[5])
        1'b0: begin
            change = 1;
            ALUSrc2Sel = 0;
            WriteDateSel = 0;
            RegWE = 1;
            InstMemRW = 1;
            MemRW = 0;
            ExtSel = 0;
            PCSel = 0;
            ALUOp = 4'b0000;
        end
        1'b1: begin
            change = 1;
            ALUSrc2Sel = 1;
            WriteDateSel = 0;
            RegWE = 1;
            InstMemRW = 1;
            MemRW = 0;
            ExtSel = 1;
            PCSel = 0;
            ALUOp = 4'b0000;
        end
        endcase
    end
    // NOT
    4'b0001: begin
        change = 1;
        ALUSrc2Sel = 0;
        WriteDateSel = 0;
        RegWE = 1;
        InstMemRW = 1;
        MemRW = 0;
        ExtSel = 0;
        PCSel = 0;
        ALUOp = 4'b0001;
    end
    // SUB
    4'b0010: begin
        case(inst[5])
        1'b0: begin
            change = 1;
            ALUSrc2Sel = 0;
            WriteDateSel = 0;
            RegWE = 1;
            InstMemRW = 1;
            MemRW = 0;
            ExtSel = 0;
            PCSel = 0;
            ALUOp = 4'b0010;
        end
        1'b1: begin
            change = 1;
            ALUSrc2Sel = 1;
            WriteDateSel = 0;
            RegWE = 1;
            InstMemRW = 1;
            MemRW = 0;
            ExtSel = 1;
            PCSel = 0;
            ALUOp = 4'b0010;
        end
        endcase
    end
    // AND
    4'b0011: begin
        case(inst[5])
        1'b0: begin
            change = 1;
            ALUSrc2Sel = 0;
            WriteDateSel = 0;
            RegWE = 1;
            InstMemRW = 1;
            MemRW = 0;
            ExtSel = 0;
            PCSel = 0;
            ALUOp = 4'b0011;
        end
        1'b1: begin
            change = 1;
            ALUSrc2Sel = 1;
            WriteDateSel = 0;
            RegWE = 1;
            InstMemRW = 1;
            MemRW = 0;
            ExtSel = 1;
            PCSel = 0;
            ALUOp = 4'b0011;
        end
        endcase
    end
    // OR
    4'b0100: begin
        case(inst[5])
        1'b0: begin
            change = 1;
            ALUSrc2Sel = 0;
            WriteDateSel = 0;
            RegWE = 1;
            InstMemRW = 1;
            MemRW = 0;
            ExtSel = 0;
            PCSel = 0;
            ALUOp = 4'b0100;
        end
        1'b1: begin
            change = 1;
            ALUSrc2Sel = 1;
            WriteDateSel = 0;
            RegWE = 1;
            InstMemRW = 1;
            MemRW = 0;
            ExtSel = 1;
            PCSel = 0;
            ALUOp = 4'b0100;
        end
        endcase
    end
    // XOR
    4'b0101: begin
        case(inst[5])
        1'b0: begin
            change = 1;
            ALUSrc2Sel = 0;
            WriteDateSel = 0;
            RegWE = 1;
            InstMemRW = 1;
            MemRW = 0;
            ExtSel = 0;
            PCSel = 0;
            ALUOp = 4'b0101;
        end
        1'b1: begin
            change = 1;
            ALUSrc2Sel = 1;
            WriteDateSel = 0;
            RegWE = 1;
            InstMemRW = 1;
            MemRW = 0;
            ExtSel = 1;
            PCSel = 0;
            ALUOp = 4'b0101;
        end
        endcase
    end
    // MUL
    4'b0110: begin
        case(inst[5])
        1'b0: begin
            change = 1;
            ALUSrc2Sel = 0;
            WriteDateSel = 0;
            RegWE = 1;
            InstMemRW = 1;
            MemRW = 0;
            ExtSel = 0;
            PCSel = 0;
            ALUOp = 4'b0110;
        end
        1'b1: begin
            change = 1;
            ALUSrc2Sel = 1;
            WriteDateSel = 0;
            RegWE = 1;
            InstMemRW = 1;
            MemRW = 0;
            ExtSel = 1;
            PCSel = 0;
            ALUOp = 4'b0110;
        end
        endcase
    end
    // SHL
    4'b0111: begin
        change = 1;
        ALUSrc2Sel = 0;
        WriteDateSel = 0;
        RegWE = 1;
        InstMemRW = 1;
        MemRW = 0;
        ExtSel = 0;
        PCSel = 0;
        ALUOp = 4'b0111;
    end
    // SHR
    4'b1000: begin
        change = 1;
        ALUSrc2Sel = 0;
        WriteDateSel = 0;
        RegWE = 1;
        InstMemRW = 1;
        MemRW = 0;
        ExtSel = 0;
        PCSel = 0;
        ALUOp = 4'b1000;
    end
    // ST
    4'b1001: begin
        change = 1;
        ALUSrc2Sel = 1;
        WriteDateSel = 0;
        RegWE = 0;
        InstMemRW = 1;
        MemRW = 1;
        ExtSel = 1;
        PCSel = 0;
        ALUOp = 4'b0000;
    end
    // LD
    4'b1010: begin
        change = 1;
        ALUSrc2Sel = 1;
        WriteDateSel = 1;
        RegWE = 1;
        InstMemRW = 1;
        MemRW = 0;
        ExtSel = 1;
        PCSel = 0;
        ALUOp = 4'b1111;
    end
    // BRz
    4'b1011: begin
        if (z) begin
            PCSel = 1;
        end else begin
            PCSel = 0;
        end
        WriteDateSel = 0;
        change = 1;
        ALUSrc2Sel = 0;
        RegWE = 0;
        InstMemRW = 1;
        MemRW = 0;
        ExtSel = 1;
        ALUOp = 4'b1111;
    end
    // BRn
    4'b1100: begin
        if (n) begin
            PCSel = 1;
        end else begin
            PCSel = 0;
        end
        WriteDateSel = 0;
        change = 1;
        ALUSrc2Sel = 0;
        RegWE = 0;
        InstMemRW = 1;
        MemRW = 0;
        ExtSel = 1;
        ALUOp = 4'b1111;
    end
    // BRp
    4'b1101: begin
        if (p) begin
            PCSel = 1;
        end else begin
            PCSel = 0;
        end
        WriteDateSel = 0;
        change = 1;
        ALUSrc2Sel = 0;
        RegWE = 0;
        InstMemRW = 1;
        MemRW = 0;
        ExtSel = 1;
        ALUOp = 4'b1111;
    end
    // JMP
    4'b1110: begin
        PCSel = 1;
        WriteDateSel = 0;
        change = 1;
        ALUSrc2Sel = 0;
        RegWE = 0;
        InstMemRW = 1;
        MemRW = 0;
        ExtSel = 1;
        ALUOp = 4'b0010;
    end
    // HALT
    4'b1111: begin
        change = 0;
        ALUSrc2Sel = 0;
        WriteDateSel = 0;
        RegWE = 0;
        InstMemRW = 0;
        MemRW = 0;
        ExtSel = 0;
        ALUOp = 4'b1111;
    end
    endcase
end

endmodule
