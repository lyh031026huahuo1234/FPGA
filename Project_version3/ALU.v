`timescale 1ns / 1ps
module ALU(
    input [3:0] ALUOp,
    input [15:0] A,
    input [15:0] B,
    output reg n,
    output reg z,
    output reg p,
    output reg [15:0] res
    );

    /* the operate for MUL*/
	wire[31:0] flag, mul_res;
	wire[31:0] temp0, temp1, temp2, temp3, temp4, temp5, temp6, temp7;
	wire[31:0] temp8, temp9, temp10, temp11, temp12, temp13, temp14, temp15;
	wire[31:0] add0, add1, add2, add3, add4, add5, add6, add7;
	wire[31:0] add8, add9, add10, add11, add12, add13;
	
	// In order to improve the efficiency of multiplication 
	// and enable it to be implemented within one clock cycle,
	// pipelined multiplier is adopted
	assign temp0 = B[0] ? {16'b0, A} : 32'b0;
	assign temp1 = B[1] ? {15'b0, A, 1'b0} : 32'b0;
	assign temp2 = B[2] ? {14'b0, A, 2'b0} : 32'b0;
	assign temp3 = B[3] ? {13'b0, A, 3'b0} : 32'b0;
	assign temp4 = B[4] ? {12'b0, A, 4'b0} : 32'b0;
	assign temp5 = B[5] ? {11'b0, A, 5'b0} : 32'b0;
	assign temp6 = B[6] ? {10'b0, A, 6'b0} : 32'b0;
	assign temp7 = B[7] ? {9'b0, A, 7'b0} : 32'b0;
	assign temp8 = B[8] ? {8'b0, A, 8'b0} : 32'b0;
	assign temp9 = B[9] ? {7'b0, A, 9'b0} : 32'b0;
	assign temp10 = B[10] ? {6'b0, A, 10'b0} : 32'b0;
	assign temp11 = B[11] ? {5'b0, A, 11'b0} : 32'b0;
	assign temp12 = B[12] ? {4'b0, A, 12'b0} : 32'b0;
	assign temp13 = B[13] ? {3'b0, A, 13'b0} : 32'b0;
	assign temp14 = B[14] ? {2'b0, A, 14'b0} : 32'b0;
	assign temp15 = B[15] ? {1'b0, A, 15'b0} : 32'b0;

	// store each bit's mul_res of num1 and num2 in 16 registers
	assign add0 = temp0 + temp1;
	assign add1 = temp2 + temp3;
	assign add2 = temp4 + temp5;
	assign add3 = temp6 + temp7;
	assign add4 = temp8 + temp9;
	assign add5 = temp10 + temp11;
	assign add6 = temp12 + temp13;
	assign add7 = temp14 + temp15;

	assign add8 = add0 + add1;
	assign add9 = add2 + add3;
	assign add10 = add4 + add5;
	assign add11 = add6 + add7;
	
	assign add12 = add8 + add9;
	assign add13 = add10 + add11;

	assign mul_res = add12 + add13;
    /* end of MUL*/

    // 进行ALU计算
    always @(*) begin
    // 进行运算
    if(ALUOp <4'b1001) begin
        case (ALUOp)
            4'b0000 : res = A + B;          // ADD
            4'b0001 : res = ~A;             // NOT
            4'b0010 : res = A - B;          // SUB
            4'b0011 : res = A & B;          // AND
            4'b0100 : res = A | B;          // OR
            4'b0101 : res = A ^ B;          // XOR
            4'b0110 : res = mul_res[15:0];  // MUL
            4'b0111 : res = (A << 1);       // SHL
            4'b1000 : res = (A >> 1);       // SHR
            default : res = 0;
        endcase
        // 设置nzp
        if(res[15] == 1'b1 && ALUOp[3:0]!=4'b1111) begin
            n = 1;
            z = 0;
            p = 0;
        end
        else if(res[15:0] == 16'b0 && ALUOp[3:0]!=4'b1111) begin
            z = 1;
            n = 0;
            p = 0;
        end 
        else if(ALUOp[3:0]!=4'b1111) begin
            p = 1;
            n = 0;
            z = 0;
        end
    end 
        else if(ALUOp[3:0]== 4'b1111) begin
            p = p;
            n = n;
            z = z;
            res[15:0] = res[15:0];
        end
    end

endmodule
