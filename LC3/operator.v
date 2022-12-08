`timescale 1ns / 1ps

module moduleName (
    input [15:0] operate,
    input [15:0] IP,
    output reg all_registers[7:0][15:0]     //the value of the registers

);


initial begin
    /* the initial of registers*/
end


/* some temp registers fot operate*/
reg [15:0] temp_reg1;
reg [15:0] temp_reg2;
reg [15:0] temp_reg3;

wire [3:0] this_op;
assign this_op[3:0] = operate[15:12];

always @(*) begin
   case(this_op)
   //THis is the start fot ALU operation
    4'b0000: begin
        /* operate for ADD*/
    end
    
    4'b0001: begin
        /*  operate for NOT*/
    end

    4'b0010: begin
        /* operate for SUB*/
    end

    4'b0011: begin
        /* operate for AND */
    end

    4'b0100: begin
        /*  operate for OR*/
    end

    4'b0101: begin
        /* operate for XOR*/
    end

    4'b0110: begin
        /*  operate for  MUL   */
        /*  It's a difficult job done by Zhu Guangcheng*/
    end

    4'b0111: begin
        /* operate fot DIV*/
        /* It's a difficult job done by Lei Yuanhang */
    end

    4'b1000: begin
        /* operator for SHL*/
    end

    4'b1001: begin
        /* operator for SHR */
    end

    4'b1010: begin
        /* operate for CMP*/
    end

    //This is the end of operation of ALU operations

    4'b1011: begin
        /*  operate for LD*/
    end

    4'b1100: begin
        /*  operate for BR*/
    end

    4'b1101: begin
        /*  operate for JMP*/
    end

    4'b1110: begin
        /*  operator for CALL*/
    end

    4'b1111: begin
        /*  operator for RET*/
    end

   endcase 
end
    
endmodule