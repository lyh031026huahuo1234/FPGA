`timescale 1ns / 1ps

module moduleName
#(  parameter  TOTALBIT = 128,
    parameter  ADDRESS_ABILITY = 16,
    parameter OPSIZE = 16,
    parameter REGSIZE = 8,
    parameter REGBIT = 3
)
(
    input [OPSIZE-1:0] operate,
    input [ADDRESS_ABILITY-1:0] IP,
    output reg all_registers[TOTALBIT-1:0]   //the value of the registers

);


initial begin
    /* the initial of registers*/
    all_registers[TOTALBIT:0] = 0; 
end

reg [ADDRESS_ABILITY-1:0] mem [REGSIZE-1:0];  //use memory to store the value of memory

/* some temp registers fot operate*/
reg [REGBIT-1:0] temp_reg1;
reg [REGBIT-1:0] temp_reg2;
reg [REGBIT-1:0] temp_reg3;
/* the value for reference operate*/
reg[ADDRESS_ABILITY-1 : 0] temp_reg1_value;
reg[ADDRESS_ABILITY-1 : 0] temp_reg2_value;
reg[ADDRESS_ABILITY-1 : 0] temp_reg3_value;

/* the immediate value that will be used*/
reg[ADDRESS_ABILITY-1 : 0] immediate_num;

/* used to judge the mode of operation */
reg flag;

/* Get the encoding of the operation */
wire [3:0] this_op;
assign this_op[3:0] = operate[15:12];


/*  The entire execution process*/
always @(*) begin: main_always
                      
    integer i; 
    //copy all_registers to mem
    for (i=0; i<REGSIZE; i=i+1) begin
        mem[i] <= all_registers[16*i+15:16*i]
    end

   case(this_op)
   //THis is the start fot ALU operation
    4'b0000: begin
        /* operate for ADD*/

        //get the register will be used for ADD
        temp_reg1 <= operate[11:9];
        temp_reg2 <= operate[8:6];
        temp_reg3 <= operate[2:0];

        //we should know the mode of operate
        flag <= operate[5];

        if(flag == 1'b0) begin
            /* R1 = R2 + R3*/
            temp_reg1_value <= mem[temp_reg2] + mem[temp_reg3];
            mem[temp_reg1] <= temp_reg1_value;
        end

        else begin
            /* R1 = R2 + imm5*/
            immediate_num <= {11'b0,operate[4:0]};
            temp_reg1_value <= mem[temp_reg2] + immediate_num;
            mem[temp_reg1] <= temp_reg1_value;
        end
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

        // get the first two register used for MUL
        temp_reg1 <= operate[11:9];
        temp_reg2 <= operate[8:6];

        // check operate[5] to determine which MUL mode is chosen
        flag <= operate[5];
        if(flag == 1'b0) begin
            /* R1 = R2 * R3 */
            temp_reg3 <= operate[2:0];
            MUL mul(.num1(mem[temp_reg2]), .num2(mem[temp_reg3]), .res(temp_reg1_value));
            mem[temp_reg1] <= temp_reg1_value;
        end
        else begin
            /* R1 = R2 * imm5*/
            immediate_num <= {11'b0, operate[4:0]};
            MUL mul(.num1(mem[temp_reg2]), .num2(immediate_num), .res(temp_reg1_value));
            mem[temp_reg1] <= temp_reg1_value;
        end
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