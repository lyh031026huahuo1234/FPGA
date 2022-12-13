`timescale  1ns/1ps

module DIV #(
    parameter dividend_size = 16,
    parameter divisor_size = 16
) (
    input clk,
    input [15:0] dividend,
    input [15:0] divisor,
    output reg [31:0] extend_dividend,
    output reg [31:0] extend_divisor,
    output reg done
);
initial begin
    done = 0;
    extend_dividend[31:0]  <= {{16{1'b0}}, 16'b1110_0111_1011_0011};
    extend_divisor[31:0] <=  {16'b0000_0000_1011_0010,{16{1'b0}}};
end

reg[4:0] cnt;

initial begin
    cnt = 0;
end


// reg [31:0] extend_dividend;

// reg [31:0] extend_divisor;

// initial begin
//     cnt[4:0] <= 5'b0;
//     extend_dividend[31:0]  <= {16'b0, dividend[15:0]};
//     extend_divisor[31:0] <=  {divisor[15:0], 16'b0};
// end
 

always @(posedge clk ) begin
   // integer i;
   
   // for (i=0; i<16; i=i+1) begin
        extend_dividend = {extend_dividend[31:0], 1'b0};
        if(extend_dividend >= extend_divisor) begin
            extend_dividend = (extend_dividend - extend_divisor + 1'b1);
            cnt <= cnt+1'b1;
        end
        else begin
            extend_dividend = extend_dividend;
             cnt <= cnt+1'b1;
        end

        if(cnt == 5'b10000) begin
            done <= 1;
         end
  //  end

    // remainder <= extend_dividend[31:16];
    // quotient <= extend_dividend[15:0];
end
//assign dividend = extend_dividend[15:0];
endmodule