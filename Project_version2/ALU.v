`timescale 1ns / 1ps

/*  this module include ALU operation and LD
 *  ALU operation will change n,z,p register
 **/

module ALU (
    input signed [15:0] regA,
    input signed [15:0] regB,
    input signed [15:0] imm,
    input [15:0] opcode,
    input n,
    input z,
    input p,
    input [15:0] IP,
    output [15:0] next_IP,
    output reg signed [15:0] out_res

);
assign next_IP[15:0] = IP[15:0] + 16'b1;

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

wire signed [15:0] add_res_imm;
wire signed [15:0] sub_res_imm;
wire signed [15:0] and_res_imm;
wire signed [15:0] or_res_imm;
wire signed [15:0] xor_res_imm;


//reg signed [15:0] out_res;
reg next_n;
reg next_z;
reg next_p;

//reg[15:0] next_regA;



//assign regA[15:0] = next_regA[15:0];
//assign res[15:0] = out_res[15:0];
assign n = next_n;
assign z = next_z;
assign p = next_p;

/* the res for ALU*/
assign add_res[15:0] = regA[15:0] + regB[15:0];
assign add_res_imm[15:0] = regA[15:0] + imm[15:0];
assign sub_res[15:0] = regA[15:0] + ~regB[15:0] + 16'b1;
assign sub_res_imm[15:0] = regA[15:0] + ~imm[15:0] + 16'b1;
assign not_res[15:0] = ~regA[15:0];
assign and_res[15:0] = regA[15:0] & regB[15:0];
assign and_res_imm[15:0] = regA[15:0] & imm[15:0];
assign or_res[15:0] = regA[15:0] | regB[15:0];
assign or_res_imm[15:0] = regA[15:0] | imm[15:0];
assign xor_res[15:0] = regA[15:0] ^ regB[15:0];
assign xor_res_imm[15:0] = regA[15:0] ^ imm[15:0];
assign shl_res[15:0] = (regA[15:0] << 1);
assign shr_res[15:0] = (regA[15:0] >> 1);
assign shl_res_al[15:0] = (regA[15:0] <<< 1);
assign shr_res_ar[15:0] = (regA[15:0] >>> 1);


/* the operate for MUL*/
	wire[31:0] flag;
	wire[31:0] temp0, temp1, temp2, temp3, temp4, temp5, temp6, temp7;
	wire[31:0] temp8, temp9, temp10, temp11, temp12, temp13, temp14, temp15;
	wire[31:0] add0, add1, add2, add3, add4, add5, add6, add7;
	wire[31:0] add8, add9, add10, add11, add12, add13;
	
	// In order to improve the efficiency of multiplication 
	// and enable it to be implemented within one clock cycle,
	// pipelined multiplier is adopted
	assign temp0 = regB[0] ? {16'b0, regA} : 32'b0;
	assign temp1 = regB[1] ? {15'b0, regA, 1'b0} : 32'b0;
	assign temp2 = regB[2] ? {14'b0, regA, 2'b0} : 32'b0;
	assign temp3 = regB[3] ? {13'b0, regA, 3'b0} : 32'b0;
	assign temp4 = regB[4] ? {12'b0, regA, 4'b0} : 32'b0;
	assign temp5 = regB[5] ? {11'b0, regA, 5'b0} : 32'b0;
	assign temp6 = regB[6] ? {10'b0, regA, 6'b0} : 32'b0;
	assign temp7 = regB[7] ? {9'b0, regA, 7'b0} : 32'b0;
	assign temp8 = regB[8] ? {8'b0, regA, 8'b0} : 32'b0;
	assign temp9 = regB[9] ? {7'b0, regA, 9'b0} : 32'b0;
	assign temp10 = regB[10] ? {6'b0, regA, 10'b0} : 32'b0;
	assign temp11 = regB[11] ? {5'b0, regA, 11'b0} : 32'b0;
	assign temp12 = regB[12] ? {4'b0, regA, 12'b0} : 32'b0;
	assign temp13 = regB[13] ? {3'b0, regA, 13'b0} : 32'b0;
	assign temp14 = regB[14] ? {2'b0, regA, 14'b0} : 32'b0;
	assign temp15 = regB[15] ? {1'b0, regA, 15'b0} : 32'b0;

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


/* the operate for DIV*/

/* end of DIV*/

always @(*) begin

case(ALUop[3:0]) 

4'b0000: begin
    /* ADD*/
    if(opcode[5] == 1'b1) begin
        out_res[15:0] = add_res_imm[15:0];
    end
    else begin
        out_res[15:0] = add_res[15:0];
    end

    //next_regA[15:0] = regA[15:0];
end

4'b0001:begin
    /* NOT*/
    out_res[15:0] = not_res[15:0];
   // next_regA[15:0] = not_res[15:0];
end

4'b0010:begin
    /* SUB*/
    if(opcode[5] == 1'b1) begin
        out_res[15:0] = sub_res_imm[15:0];
    end
    else begin
        out_res[15:0] = sub_res[15:0];
    end
   
 //   next_regA[15:0] = regA[15:0];
end

4'b0011:begin
    /*AND*/
    if(opcode[5] == 1'b1) begin
        out_res[15:0] = and_res_imm[15:0];
    end
    else begin
        out_res[15:0] = and_res[15:0];
    end
  //  next_regA[15:0] = regA[15:0];
end

4'b0100:begin
    /*OR*/
    if(opcode[5] == 1'b1) begin
        out_res[15:0] = or_res_imm[15:0];
    end
    else begin
        out_res[15:0] = or_res[15:0];
    end
   // next_regA[15:0] = regA[15:0];
end

4'b0101:begin
    /*XOR*/
    if(opcode[5] == 1'b1) begin
        out_res[15:0] = xor_res_imm[15:0];
    end
    else begin
        out_res[15:0] = xor_res[15:0];
    end
  //  next_regA[15:0] = regA[15:0];
end

4'b0110:begin
    /*MUL*/
    out_res[15:0] = mul_res[15:0];
  //   next_regA[15:0] = regA[15:0];
end

4'b0111:begin
    /*DIV*/
    out_res[15:0] = div_res[15:0];
 //    next_regA[15:0] = regA[15:0];
end

4'b1000:begin
    /*SHL*/
    if(opcode[8] == 1'b1) begin 
        out_res[15:0] = shl_res[15:0];
    end
    else begin
        out_res[15:0] = shl_res_al[15:0];
    end

 //    next_regA[15:0] = regA[15:0];
end

4'b1001: begin
    /*SHR*/
    if(opcode[8] == 1'b1) begin
        out_res[15:0] = shr_res[15:0];
    end
    else begin
        out_res[15:0] = shr_res[15:0];
    end

  //   next_regA[15:0] = regA[15:0];
end

4'b1010: begin
    /*CMP*/
    if(sub_res[15] == 1'b1) begin
        next_n = 1;
        next_z = 0;
        next_p = 0;

    end
    else if(out_res[15:0] == 16'b0) begin
        next_z = 1;
        next_n = 0;
        next_p = 0;
    end
    else begin
        next_p = 1;
        next_n = 0;
        next_z = 0;
    end

  //   next_regA[15:0] = regA[15:0];
end

4'b1011:begin
    /* LD*/
    if(opcode[8] == 1'b1) begin
     //   next_regA[15:0] = regB[15:0];
    end
    else begin
     //   next_regA[7:0] = opcode[7:0];
      //  next_regA[15:8] = 8'b0;
    end
end

//default: begin
//    out_res[15:0] = 16'b0;
//
//     next_regA[15:0] = regA[15:0];
//end

endcase

if(ALUop[3:0] < 4'b1010) begin
    if(out_res[15] == 1'b1) begin
        next_n = 1;
        next_z = 0;
        next_p = 0;
    end
    else if(out_res[15:0] == 16'b0) begin
        next_z = 1;
        next_n = 0;
        next_p = 0;
    end 
    else begin
        next_p = 1;
        next_n = 0;
        next_z = 0;
    end
end


end

endmodule
