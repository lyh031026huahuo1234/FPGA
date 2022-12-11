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
    output reg[TOTALBIT-1:0] all_registers   //the value of the registers

);


initial begin
    /* the initial of registers*/
    all_registers[TOTALBIT-1:0] = 0; 
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
        mem[i] <= all_registers[(16*i)+:16];
    end

   case(this_op)
   //THis is the start fot ALU operation
    4'b0000: begin
        /* operate for ADD*/
        // get the first two register used for ADD
        temp_reg1 <= operate[11:9];
        temp_reg2 <= operate[8:6];

        // get the contains of temp_reg2
        case(temp_reg2)
        3'b000: begin
            temp_reg2_value <= mem[0];
            end
        3'b001: begin
            temp_reg2_value <= mem[1];
            end
        3'b010: begin
            temp_reg2_value <= mem[2];
            end
        3'b011: begin
            temp_reg2_value <= mem[3];
            end
        3'b100: begin
            temp_reg2_value <= mem[4];
            end
        3'b101: begin
            temp_reg2_value <= mem[5];
            end
        3'b110: begin
            temp_reg2_value <= mem[6];
            end
        3'b111: begin
            temp_reg2_value <= mem[7];
            end
        endcase

        // check operate[5] to determine which ADD mode is chosen
        flag <= operate[5];
        if(flag == 1'b0) begin
            /* R1 = R2 + R3*/
            temp_reg3 <= operate[2:0];
            // get the contains of temp_reg3
            case(temp_reg3)
            3'b000: begin
                temp_reg3_value <= mem[0];
                end
            3'b001: begin
                temp_reg3_value <= mem[1];
                end
            3'b010: begin
                temp_reg3_value <= mem[2];
                end
            3'b011: begin
                temp_reg3_value <= mem[3];
                end
            3'b100: begin
                temp_reg3_value <= mem[4];
                end
            3'b101: begin
                temp_reg3_value <= mem[5];
                end
            3'b110: begin
                temp_reg3_value <= mem[6];
                end
            3'b111: begin
                temp_reg3_value <= mem[7];
                end
            endcase
            temp_reg1_value <= temp_reg2_value + temp_reg3_value;
        end
        else begin
            /* R1 = R2 + imm5*/
            immediate_num <= {11'b0, operate[4:0]};
            temp_reg1_value <= temp_reg2_value + immediate_num;
        end

        // write the result to DR
        case(temp_reg1)
        3'b000: begin
            mem[0] <= temp_reg1_value;
            end
        3'b001: begin
            mem[1] <= temp_reg1_value;
            end
        3'b010: begin
            mem[2] <= temp_reg1_value;
            end
        3'b011: begin
            mem[3] <= temp_reg1_value;
            end
        3'b100: begin
            mem[4] <= temp_reg1_value;
            end
        3'b101: begin
            mem[5] <= temp_reg1_value;
            end
        3'b110: begin
            mem[6] <= temp_reg1_value;
            end
        3'b111: begin
            mem[7] <= temp_reg1_value;
            end
        endcase

    end
    
    4'b0001: begin
        /*  operate for NOT*/
        temp_reg1 <= operate[11:8];
        temp_reg2 <= operate[7:5];

        // get the contains of temp_reg2
        case(temp_reg2)
        3'b000: begin
            temp_reg2_value <= mem[0];
            end
        3'b001: begin
            temp_reg2_value <= mem[1];
            end
        3'b010: begin
            temp_reg2_value <= mem[2];
            end
        3'b011: begin
            temp_reg2_value <= mem[3];
            end
        3'b100: begin
            temp_reg2_value <= mem[4];
            end
        3'b101: begin
            temp_reg2_value <= mem[5];
            end
        3'b110: begin
            temp_reg2_value <= mem[6];
            end
        3'b111: begin
            temp_reg2_value <= mem[7];
            end
        endcase
        
        temp_reg1_value <= ~temp_reg2_value;
        // write the result to DR
        case(temp_reg1)
        3'b000: begin
            mem[0] <= temp_reg1_value;
            end
        3'b001: begin
            mem[1] <= temp_reg1_value;
            end
        3'b010: begin
            mem[2] <= temp_reg1_value;
            end
        3'b011: begin
            mem[3] <= temp_reg1_value;
            end
        3'b100: begin
            mem[4] <= temp_reg1_value;
            end
        3'b101: begin
            mem[5] <= temp_reg1_value;
            end
        3'b110: begin
            mem[6] <= temp_reg1_value;
            end
        3'b111: begin
            mem[7] <= temp_reg1_value;
            end
        endcase

    end

    4'b0010: begin
        /* operate for SUB*/
        // get the first two register used for SUB
        temp_reg1 <= operate[11:9];
        temp_reg2 <= operate[8:6];

        // get the contains of temp_reg2
        case(temp_reg2)
        3'b000: begin
            temp_reg2_value <= mem[0];
            end
        3'b001: begin
            temp_reg2_value <= mem[1];
            end
        3'b010: begin
            temp_reg2_value <= mem[2];
            end
        3'b011: begin
            temp_reg2_value <= mem[3];
            end
        3'b100: begin
            temp_reg2_value <= mem[4];
            end
        3'b101: begin
            temp_reg2_value <= mem[5];
            end
        3'b110: begin
            temp_reg2_value <= mem[6];
            end
        3'b111: begin
            temp_reg2_value <= mem[7];
            end
        endcase

        // check operate[5] to determine which SUB mode is chosen
        flag <= operate[5];
        if(flag == 1'b0) begin
            /* R1 = R2 - R3*/
            temp_reg3 <= operate[2:0];
            // get the contains of temp_reg3
            case(temp_reg3)
            3'b000: begin
                temp_reg3_value <= mem[0];
                end
            3'b001: begin
                temp_reg3_value <= mem[1];
                end
            3'b010: begin
                temp_reg3_value <= mem[2];
                end
            3'b011: begin
                temp_reg3_value <= mem[3];
                end
            3'b100: begin
                temp_reg3_value <= mem[4];
                end
            3'b101: begin
                temp_reg3_value <= mem[5];
                end
            3'b110: begin
                temp_reg3_value <= mem[6];
                end
            3'b111: begin
                temp_reg3_value <= mem[7];
                end
            endcase
            // get the two's complement of -temp_reg3_value
            temp_reg3_value <= ~temp_reg3_value;
            temp_reg3_value <= temp_reg3_value + 1;
            temp_reg1_value <= temp_reg2_value + temp_reg3_value;
        end
        else begin
            /* R1 = R2 - imm5*/
            immediate_num <= {11'b0, operate[4:0]};
            // get the two's complement of -immediate_num
            immediate_num <= ~immediate_num;
            immediate_num <= immediate_num + 1;
            temp_reg1_value <= temp_reg2_value + immediate_num;
        end

        // write the result to DR
        case(temp_reg1)
        3'b000: begin
            mem[0] <= temp_reg1_value;
            end
        3'b001: begin
            mem[1] <= temp_reg1_value;
            end
        3'b010: begin
            mem[2] <= temp_reg1_value;
            end
        3'b011: begin
            mem[3] <= temp_reg1_value;
            end
        3'b100: begin
            mem[4] <= temp_reg1_value;
            end
        3'b101: begin
            mem[5] <= temp_reg1_value;
            end
        3'b110: begin
            mem[6] <= temp_reg1_value;
            end
        3'b111: begin
            mem[7] <= temp_reg1_value;
            end
        endcase

    end

    4'b0011: begin
        /* operate for AND */
        // get the first two register used for AND
        temp_reg1 <= operate[11:9];
        temp_reg2 <= operate[8:6];

        // get the contains of temp_reg2
        case(temp_reg2)
        3'b000: begin
            temp_reg2_value <= mem[0];
            end
        3'b001: begin
            temp_reg2_value <= mem[1];
            end
        3'b010: begin
            temp_reg2_value <= mem[2];
            end
        3'b011: begin
            temp_reg2_value <= mem[3];
            end
        3'b100: begin
            temp_reg2_value <= mem[4];
            end
        3'b101: begin
            temp_reg2_value <= mem[5];
            end
        3'b110: begin
            temp_reg2_value <= mem[6];
            end
        3'b111: begin
            temp_reg2_value <= mem[7];
            end
        endcase

        // check operate[5] to determine which AND mode is chosen
        flag <= operate[5];
        if(flag == 1'b0) begin
            /* R1 = R2 & R3*/
            temp_reg3 <= operate[2:0];
            // get the contains of temp_reg3
            case(temp_reg3)
            3'b000: begin
                temp_reg3_value <= mem[0];
                end
            3'b001: begin
                temp_reg3_value <= mem[1];
                end
            3'b010: begin
                temp_reg3_value <= mem[2];
                end
            3'b011: begin
                temp_reg3_value <= mem[3];
                end
            3'b100: begin
                temp_reg3_value <= mem[4];
                end
            3'b101: begin
                temp_reg3_value <= mem[5];
                end
            3'b110: begin
                temp_reg3_value <= mem[6];
                end
            3'b111: begin
                temp_reg3_value <= mem[7];
                end
            endcase
            temp_reg1_value <= temp_reg2_value & temp_reg3_value;
        end
        else begin
            /* R1 = R2 & imm5*/
            immediate_num <= {11'b0, operate[4:0]};
            temp_reg1_value <= temp_reg2_value & immediate_num;
        end

        // write the result to DR
        case(temp_reg1)
        3'b000: begin
            mem[0] <= temp_reg1_value;
            end
        3'b001: begin
            mem[1] <= temp_reg1_value;
            end
        3'b010: begin
            mem[2] <= temp_reg1_value;
            end
        3'b011: begin
            mem[3] <= temp_reg1_value;
            end
        3'b100: begin
            mem[4] <= temp_reg1_value;
            end
        3'b101: begin
            mem[5] <= temp_reg1_value;
            end
        3'b110: begin
            mem[6] <= temp_reg1_value;
            end
        3'b111: begin
            mem[7] <= temp_reg1_value;
            end
        endcase

    end

    4'b0011: begin
        /* operate for OR */
        // get the first two register used for OR
        temp_reg1 <= operate[11:9];
        temp_reg2 <= operate[8:6];

        // get the contains of temp_reg2
        case(temp_reg2)
        3'b000: begin
            temp_reg2_value <= mem[0];
            end
        3'b001: begin
            temp_reg2_value <= mem[1];
            end
        3'b010: begin
            temp_reg2_value <= mem[2];
            end
        3'b011: begin
            temp_reg2_value <= mem[3];
            end
        3'b100: begin
            temp_reg2_value <= mem[4];
            end
        3'b101: begin
            temp_reg2_value <= mem[5];
            end
        3'b110: begin
            temp_reg2_value <= mem[6];
            end
        3'b111: begin
            temp_reg2_value <= mem[7];
            end
        endcase

        // check operate[5] to determine which OR mode is chosen
        flag <= operate[5];
        if(flag == 1'b0) begin
            /* R1 = R2 | R3*/
            temp_reg3 <= operate[2:0];
            // get the contains of temp_reg3
            case(temp_reg3)
            3'b000: begin
                temp_reg3_value <= mem[0];
                end
            3'b001: begin
                temp_reg3_value <= mem[1];
                end
            3'b010: begin
                temp_reg3_value <= mem[2];
                end
            3'b011: begin
                temp_reg3_value <= mem[3];
                end
            3'b100: begin
                temp_reg3_value <= mem[4];
                end
            3'b101: begin
                temp_reg3_value <= mem[5];
                end
            3'b110: begin
                temp_reg3_value <= mem[6];
                end
            3'b111: begin
                temp_reg3_value <= mem[7];
                end
            endcase
            temp_reg1_value <= temp_reg2_value | temp_reg3_value;
        end
        else begin
            /* R1 = R2 | imm5*/
            immediate_num <= {11'b0, operate[4:0]};
            temp_reg1_value <= temp_reg2_value | immediate_num;
        end

        // write the result to DR
        case(temp_reg1)
        3'b000: begin
            mem[0] <= temp_reg1_value;
            end
        3'b001: begin
            mem[1] <= temp_reg1_value;
            end
        3'b010: begin
            mem[2] <= temp_reg1_value;
            end
        3'b011: begin
            mem[3] <= temp_reg1_value;
            end
        3'b100: begin
            mem[4] <= temp_reg1_value;
            end
        3'b101: begin
            mem[5] <= temp_reg1_value;
            end
        3'b110: begin
            mem[6] <= temp_reg1_value;
            end
        3'b111: begin
            mem[7] <= temp_reg1_value;
            end
        endcase

    end

    4'b0011: begin
        /* operate for XOR */
        // get the first two register used for XOR
        temp_reg1 <= operate[11:9];
        temp_reg2 <= operate[8:6];

        // get the contains of temp_reg2
        case(temp_reg2)
        3'b000: begin
            temp_reg2_value <= mem[0];
            end
        3'b001: begin
            temp_reg2_value <= mem[1];
            end
        3'b010: begin
            temp_reg2_value <= mem[2];
            end
        3'b011: begin
            temp_reg2_value <= mem[3];
            end
        3'b100: begin
            temp_reg2_value <= mem[4];
            end
        3'b101: begin
            temp_reg2_value <= mem[5];
            end
        3'b110: begin
            temp_reg2_value <= mem[6];
            end
        3'b111: begin
            temp_reg2_value <= mem[7];
            end
        endcase

        // check operate[5] to determine which OR mode is chosen
        flag <= operate[5];
        if(flag == 1'b0) begin
            /* R1 = R2 ^ R3*/
            temp_reg3 <= operate[2:0];
            // get the contains of temp_reg3
            case(temp_reg3)
            3'b000: begin
                temp_reg3_value <= mem[0];
                end
            3'b001: begin
                temp_reg3_value <= mem[1];
                end
            3'b010: begin
                temp_reg3_value <= mem[2];
                end
            3'b011: begin
                temp_reg3_value <= mem[3];
                end
            3'b100: begin
                temp_reg3_value <= mem[4];
                end
            3'b101: begin
                temp_reg3_value <= mem[5];
                end
            3'b110: begin
                temp_reg3_value <= mem[6];
                end
            3'b111: begin
                temp_reg3_value <= mem[7];
                end
            endcase
            temp_reg1_value <= temp_reg2_value ^ temp_reg3_value;
        end
        else begin
            /* R1 = R2 ^ imm5*/
            immediate_num <= {11'b0, operate[4:0]};
            temp_reg1_value <= temp_reg2_value ^ immediate_num;
        end

        // write the result to DR
        case(temp_reg1)
        3'b000: begin
            mem[0] <= temp_reg1_value;
            end
        3'b001: begin
            mem[1] <= temp_reg1_value;
            end
        3'b010: begin
            mem[2] <= temp_reg1_value;
            end
        3'b011: begin
            mem[3] <= temp_reg1_value;
            end
        3'b100: begin
            mem[4] <= temp_reg1_value;
            end
        3'b101: begin
            mem[5] <= temp_reg1_value;
            end
        3'b110: begin
            mem[6] <= temp_reg1_value;
            end
        3'b111: begin
            mem[7] <= temp_reg1_value;
            end
        endcase

    end

    4'b0110: begin
        /*  operate for  MUL   */
        /*  It's a difficult job done by Zhu Guangcheng*/

        // get the first two registers used for MUL
        temp_reg1 <= operate[11:9];
        temp_reg2 <= operate[8:6];

        // get the contains of temp_reg2
        case(temp_reg2)
        3'b000: begin
            temp_reg2_value <= mem[0];
            end
        3'b001: begin
            temp_reg2_value <= mem[1];
            end
        3'b010: begin
            temp_reg2_value <= mem[2];
            end
        3'b011: begin
            temp_reg2_value <= mem[3];
            end
        3'b100: begin
            temp_reg2_value <= mem[4];
            end
        3'b101: begin
            temp_reg2_value <= mem[5];
            end
        3'b110: begin
            temp_reg2_value <= mem[6];
            end
        3'b111: begin
            temp_reg2_value <= mem[7];
            end
        endcase

        // check operate[5] to determine which MUL mode is chosen
        flag <= operate[5];
        if(flag == 1'b0) begin
            /* R1 = R2 * R3 */
            temp_reg3 <= operate[2:0];
            // get the contains of temp_reg3
            case(temp_reg3)
            3'b000: begin
                temp_reg3_value <= mem[0];
                end
            3'b001: begin
                temp_reg3_value <= mem[1];
                end
            3'b010: begin
                temp_reg3_value <= mem[2];
                end
            3'b011: begin
                temp_reg3_value <= mem[3];
                end
            3'b100: begin
                temp_reg3_value <= mem[4];
                end
            3'b101: begin
                temp_reg3_value <= mem[5];
                end
            3'b110: begin
                temp_reg3_value <= mem[6];
                end
            3'b111: begin
                temp_reg3_value <= mem[7];
                end
            endcase
            // involk MUL module to get the result of multiplication
            MUL mul(.num1(temp_reg2_value), .num2(temp_reg3_value), .res(temp_reg1_value));
        end
        else begin
            /* R1 = R2 * imm5*/
            immediate_num <= {11'b0, operate[4:0]};
            // involk MUL module to get the result of multiplication
            MUL mul(.num1(temp_reg2_value), .num2(immediate_num), .res(temp_reg1_value));
        end

        // write the result to DR
        case(temp_reg1)
        3'b000: begin
            mem[0] <= temp_reg1_value;
            end
        3'b001: begin
            mem[1] <= temp_reg1_value;
            end
        3'b010: begin
            mem[2] <= temp_reg1_value;
            end
        3'b011: begin
            mem[3] <= temp_reg1_value;
            end
        3'b100: begin
            mem[4] <= temp_reg1_value;
            end
        3'b101: begin
            mem[5] <= temp_reg1_value;
            end
        3'b110: begin
            mem[6] <= temp_reg1_value;
            end
        3'b111: begin
            mem[7] <= temp_reg1_value;
            end
        endcase

    end

    4'b0111: begin
        /* operate fot DIV*/
        /* It's a difficult job done by Lei Yuanhang */
    end

    4'b1001: begin
        /* operator for SHL */
        // get the register used for SHL
        temp_reg1 <= operate[11:9];

        // get the contains of temp_reg1
        case(temp_reg1)
        3'b000: begin
            temp_reg1_value <= mem[0];
            end
        3'b001: begin
            temp_reg1_value <= mem[1];
            end
        3'b010: begin
            temp_reg1_value <= mem[2];
            end
        3'b011: begin
            temp_reg1_value <= mem[3];
            end
        3'b100: begin
            temp_reg1_value <= mem[4];
            end
        3'b101: begin
            temp_reg1_value <= mem[5];
            end
        3'b110: begin
            temp_reg1_value <= mem[6];
            end
        3'b111: begin
            temp_reg1_value <= mem[7];
            end
        endcase

        // check operate[8] to determine which SHL mode is chosen
        flag <= operate[8];
        if(flag == 1'b0) begin
            /* shift arithmetic left*/
            temp_reg1_value <= temp_reg1_value <<< 1;
        end
        else begin
            /* shift logical left*/
            temp_reg1_value <= temp_reg1_value << 1;
        end

        // write the result to DR
        case(temp_reg1)
        3'b000: begin
            mem[0] <= temp_reg1_value;
            end
        3'b001: begin
            mem[1] <= temp_reg1_value;
            end
        3'b010: begin
            mem[2] <= temp_reg1_value;
            end
        3'b011: begin
            mem[3] <= temp_reg1_value;
            end
        3'b100: begin
            mem[4] <= temp_reg1_value;
            end
        3'b101: begin
            mem[5] <= temp_reg1_value;
            end
        3'b110: begin
            mem[6] <= temp_reg1_value;
            end
        3'b111: begin
            mem[7] <= temp_reg1_value;
            end
        endcase

    end

    4'b1001: begin
        /* operator for SHR */
        // get the register used for SHR
        temp_reg1 <= operate[11:9];

        // get the contains of temp_reg1
        case(temp_reg1)
        3'b000: begin
            temp_reg1_value <= mem[0];
            end
        3'b001: begin
            temp_reg1_value <= mem[1];
            end
        3'b010: begin
            temp_reg1_value <= mem[2];
            end
        3'b011: begin
            temp_reg1_value <= mem[3];
            end
        3'b100: begin
            temp_reg1_value <= mem[4];
            end
        3'b101: begin
            temp_reg1_value <= mem[5];
            end
        3'b110: begin
            temp_reg1_value <= mem[6];
            end
        3'b111: begin
            temp_reg1_value <= mem[7];
            end
        endcase

        // check operate[8] to determine which SHR mode is chosen
        flag <= operate[8];
        if(flag == 1'b0) begin
            /* shift arithmetic right*/
            temp_reg1_value <= temp_reg1_value >>> 1;
        end
        else begin
            /* shift logical right*/
            temp_reg1_value <= temp_reg1_value >> 1;
        end

        // write the result to DR
        case(temp_reg1)
        3'b000: begin
            mem[0] <= temp_reg1_value;
            end
        3'b001: begin
            mem[1] <= temp_reg1_value;
            end
        3'b010: begin
            mem[2] <= temp_reg1_value;
            end
        3'b011: begin
            mem[3] <= temp_reg1_value;
            end
        3'b100: begin
            mem[4] <= temp_reg1_value;
            end
        3'b101: begin
            mem[5] <= temp_reg1_value;
            end
        3'b110: begin
            mem[6] <= temp_reg1_value;
            end
        3'b111: begin
            mem[7] <= temp_reg1_value;
            end
        endcase

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
