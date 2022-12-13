`timescale 1ns / 1ps


/*  this module include ALU operation and LD
 *  ALU operation will change n,z,p register
 **/
module ALU (
    input signed [15:0] regA,
    input signed [15:0] regB,
    input [15:0] opcode,
    input n,
    input z,
    input p,
    output signed [15:0] res,

);


wire [3:0] ALUop;
assign ALUop[3:0] = opcode[15:12];


wire signed [15:0] add_res;
wire signed [15:0] sub_res;
wire signed [15:0] not_res;
wire signed [15:0] and_res;
wire signed [15:0] or_res;
wire signed [15:0] xor_res;
wire  [15:0] mul_res;   //mul use unsigned mode
wire signed [15:0] div_res;
wire signed [15:0] shl_res;
wire signed [15:0] shr_res;
wire signed [15:0] shl_res_al;
wire signed [15:0] shr_res_ar;

reg signed [15:0] out_res;
reg next_n;
reg next_z;
reg next_p;

reg next_regA;



assign regA[15:0] = next_regA[15:0];
assign res[15:0] = out_res[15:0];
assign n = next_n;
assign z = next_z;
assign p = next_p;

/* the res for ALU*/
assign add_res[15:0] = regA[15:0] + regB[15:0];
assign sub_res[15:0] = regA[15:0] + ~regB[15:0] + 16'b1;
assign not_res[15:0] = ~regA[15:0];
assign and_res[15:0] = regA[15:0] & regB[15:0];
assign or_res[15:0] = regA[15:0] | regB[15:0];
assign xor_res[15:0] = regA[15:0] ^ regB[15:0];
assign shl_res[15:0] = (regA[15:0] << 1);
assign shr_res[15:0] = (regA[15:0] >> 1);
assign shl_res_al[15:0] = (regA[15:0] <<< 1);
assign shr_res_ar[15:0] = (regA[15:0] >>> 1);


/* the operate for MUL*/
wire[31:0] flag;
	wire[31:0] mul_res;
	wire[31:0] temp0, temp1, temp2, temp3, temp4, temp5, temp6, temp7;
	wire[31:0] temp8, temp9, temp10, temp11, temp12, temp13, temp14, temp15;
	wire[31:0] add0, add1, add2, add3, add4, add5, add6, add7;
	wire[31:0] add8, add9, add10, add11, add12, add13;
	
	// ��num1��num2ÿһλ��˵Ľ�������16���Ĵ�����
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

	// ����Щ���������ӣ����յõ��˷�����Ľ��
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


/* the operate for DIV*/

/* end of DIV*/

always @(*) begin

case(ALUop[3:0]) 

4'b0000: begin
    /* ADD*/
    out_res[15:0] = add_res[15:0];
    next_regA[15:0] = regA[15:0];
end

4'b0001:begin
    /* NOT*/
    out_res[15:0] = not_res[15:0];
    next_regA[15:0] = regA[15:0];
end

4'b0010:begin
    /* SUB*/
    out_res[15:0] = sub_res[15:0];
    next_regA[15:0] = regA[15:0];
end

4'b0011:begin
    /*AND*/
    out_res[15:0] = and_res[15:0];
    next_regA[15:0] = regA[15:0];
end

4'b0100:begin
    /*OR*/
    out_res[15:0] = or_res[15:0];
    next_regA[15:0] = regA[15:0];
end

4'b0101:begin
    /*XOR*/
    out_res[15:0] = xor_res[15:0];
    next_regA[15:0] = regA[15:0];
end

4'b0110:begin
    /*MUL*/
    out_res[15:0] = mul_res[15:0];
     next_regA[15:0] = regA[15:0];
end

4'b0111:begin
    /*DIV*/
    out_res[15:0] = div_res[15:0];
     next_regA[15:0] = regA[15:0];
end

4'b1000:begin
    /*SHL*/
    if(opcode[8] == 1'b1) begin 
        out_res[15:0] = shl_res[15:0];
    end
    else begin
        out_res[15:0] = shl_res_al[15:0];
    end

     next_regA[15:0] = regA[15:0];
end

4'b1001: begin
    /*SHR*/
    if(opcode[8] == 1'b1) begin
        out_res[15:0] = shr_res[15:0];
    end
    else begin
        out_res[15:0] = shr_res[15:0];
    end

     next_regA[15:0] = regA[15:0];
end

4'b1010: begin
    /*CMP*/
    if(sub_res[15] == 1'b1) begin
        n = 1;
        z = 0;
        p = 0;

    end
    else if(out_res[15:0] == 16'b0) begin
        z = 1;
        n = 0;
        p = 0;
    end
    else begin
        p = 1;
        n = 0;
        z = 0;
    end

     next_regA[15:0] = regA[15:0];
end

4'b1011:begin
    /* LD*/
    if(opcode[8] == 1'b1) begin
        next_regA[15:0] = regB[15:0];
    end
    else begin
        next_regA[7:0] = opcode[7:0];
        next_regA[15:8] = 8'b0;
    end

     next_regA[15:0] = regA[15:0];
end

default: begin
    out_res[15:0] = 16'b0;

     next_regA[15:0] = regA[15:0];
end

endcase

if(ALUop[3:0] < 4'b1010) begin
    if(out_res[15] == 1'b1) begin
        n = 1;
        z = 0;
        p = 0;
    end
    else if(out_res[15:0] == 16'b0) begin
        z = 1;
        n = 0;
        p = 0;
    end 
    else begin
        p = 1;
        n = 0;
        z = 0;
    end
end



end





endmodule