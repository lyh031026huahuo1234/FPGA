`timescale 1ns/1ps

module MyMC14495(
  input D0, D1, D2, D3,
  input LE,
  input point,
  output reg p,
  output reg a, b, c, d, e, f, g
);

  `define MC14495_OUT {a, b, c, d, e, f, g}

  wire D3_bar;
  wire D2_bar;
  wire D1_bar;
  wire D0_bar;
  assign {D3_bar,D2_bar,D1_bar,D0_bar} = {!D3,!D2,!D1,!D0};
  always@(*) begin
    if(1'b0 == LE) begin
      /* Able to print */
      // Point
      p = !point;                            
      a = D3_bar&D2_bar&D1_bar&D0 | D3_bar&D2&D1_bar&D0_bar | D3&D2_bar&D1&D0 | D3&D2&D1_bar&D0;
      b = D3_bar&D2&D1_bar&D0 | D2&D1&D0_bar | D3&D2&D0_bar | D3&D1&D0;
      c = D3_bar&D2_bar&D1&D0_bar | D3&D2&D0_bar | D3&D2&D1;
      d = D3_bar&D2_bar&D1_bar&D0 | D3_bar&D2&D1_bar&D0_bar | D2&D1&D0 | D3&D2_bar&D1&D0_bar;
      e = D3_bar&D0 | D3_bar&D2&D1_bar | D2_bar&D1_bar&D0;
      f = D3_bar&D2_bar&D0 | D3_bar&D2_bar&D1 | D3_bar&D1&D0 | D3&D2&D1_bar&D0;
      g = D3_bar&D2_bar&D1_bar | D3_bar&D2&D1&D0 | D3&D2&D1_bar&D0_bar;

    end else begin
      // Print nothing (LE == 1)
      `MC14495_OUT = 7'b111_1111;                
      p = !point;                            
    end

  end

endmodule




module DisplayNumber(
    input wire[7:0] SW,
    input wire[1:0] BTN,
    output [7:0] SEGMENT,
    output [3:0] AN
);
assign AN[3] = !SW[7];
assign AN[2] = !SW[6];
assign AN[1] = !SW[5];
assign AN[0] = !SW[4];

MyMC14495 u0 (.D0(SW[0]),.D1(SW[1]),.D2(SW[2]),.D3(SW[3]),.point(BTN[1]),.LE(BTN[0]),
.a(SEGMENT[0]),.b(SEGMENT[1]),.c(SEGMENT[2]),.d(SEGMENT[3]),.e(SEGMENT[4]),.f(SEGMENT[5]),.g(SEGMENT[6]),.p(SEGMENT[7]));



endmodule