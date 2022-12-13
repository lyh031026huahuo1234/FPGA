module IP(
    input clk,
    input [15:0] next_IP,
    output reg[15:0] IP

);

always @(posedge clk) begin
    IP <= next_IP;
end

endmodule