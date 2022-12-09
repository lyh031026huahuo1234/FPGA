`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:15:06 12/09/2022 
// Design Name: 
// Module Name:    MUL 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module MUL(
	input[15:0] num1,
	input[15:0] num2,
	output[15:0] res,
	output Co
    );
	// 为了提高乘法的效率，使其能够在一个时钟周期内实现，采用流水线乘法器的实现方法
	wire[31:0] flag;
	wire[31:0] mul_res;
	wire[31:0] temp0, temp1, temp2, temp3, temp4, temp5, temp6, temp7;
	wire[31:0] temp8, temp9, temp10, temp11, temp12, temp13, temp14, temp15;
	wire[31:0] add0, add1, add2, add3, add4, add5, add6, add7;
	wire[31:0] add8, add9, add10, add11, add12, add13;
	
	// 将num1和num2每一位相乘的结果存放在16个寄存器中
	assign temp0 = num2[0] ? {16'b0, num1} : 32'b0;
	assign temp1 = num2[1] ? {15'b0, num1, 1'b0} : 32'b0;
	assign temp2 = num2[2] ? {14'b0, num1, 2'b0} : 32'b0;
	assign temp3 = num2[3] ? {13'b0, num1, 3'b0} : 32'b0;
	assign temp4 = num2[4] ? {12'b0, num1, 4'b0} : 32'b0;
	assign temp5 = num2[5] ? {11'b0, num1, 5'b0} : 32'b0;
	assign temp6 = num2[6] ? {10'b0, num1, 6'b0} : 32'b0;
	assign temp7 = num2[7] ? {9'b0, num1, 7'b0} : 32'b0;
	assign temp8 = num2[8] ? {8'b0, num1, 8'b0} : 32'b0;
	assign temp9 = num2[9] ? {7'b0, num1, 9'b0} : 32'b0;
	assign temp10 = num2[10] ? {6'b0, num1, 10'b0} : 32'b0;
	assign temp11 = num2[11] ? {5'b0, num1, 11'b0} : 32'b0;
	assign temp12 = num2[12] ? {4'b0, num1, 12'b0} : 32'b0;
	assign temp13 = num2[13] ? {3'b0, num1, 13'b0} : 32'b0;
	assign temp14 = num2[14] ? {2'b0, num1, 14'b0} : 32'b0;
	assign temp15 = num2[15] ? {1'b0, num1, 15'b0} : 32'b0;

	// 将这些结果两两相加，最终得到乘法运算的结果
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
	
	assign res = mul_res[15:0];

endmodule
