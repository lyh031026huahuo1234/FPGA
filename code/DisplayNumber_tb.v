`timescale 1ps/1ps
`include "DisplayNumber.v"

module DisplayNumber_tb();
  
 reg[7:0] SW;
 reg [1:0] BTN;
 wire [7:0] SEGMENT;
 wire [3:0] AN;
 DisplayNumber u0 (.SW(SW),.BTN(BTN),.SEGMENT(SEGMENT),.AN(AN));
  initial begin
    $dumpfile("DisplayNumber.vcd");
    $dumpvars(1, DisplayNumber_tb);
    
    SW = 8'b0000_0101;
    BTN = 2'b11;
    #20
    SW = 8'b0000_0101;
    BTN = 2'b11;
  end

endmodule 