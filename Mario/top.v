`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:11:30 11/14/2022 
// Design Name: 
// Module Name:    top 
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
module Top(
    input                   I_clk   , // 系统50MHz时钟
    input                   I_rst_n , // 系统复位
    output         [3:0]    O_red   , // VGA红色分量
    output         [3:0]    O_green , // VGA绿色分量
    output         [3:0]    O_blue  , // VGA蓝色分量
    output                  O_hs    , // VGA行同步信号
    output                  O_vs      // VGA场同步信号
    );
	
    //分频系统时钟，生成25MHZ的时钟
	reg R_clk_25M;
	always @(posedge I_clk or negedge I_rst_n)
	begin
		 if(!I_rst_n)
			  R_clk_25M   <=  1'b0;
		 else
			  R_clk_25M   <=  ~R_clk_25M;     
	end
		
	reg [11:0] vga_data;//vga颜色显示
	wire [9:0] col_addr;//x的值
	wire [8:0] row_addr;//y的值
	

	reg  [18:0] R_rom_addr; // ROM的地址，必须要比总像素点个数大，否则会出现out of range
	wire [11:0] W_rom_data; // ROM中存储的数据，总共存储12位
	
    //调用vga模块输出r、g、b和行同步信号、场同步信号
    vga vga_test(.vga_clk(R_clk_25M),.clrn(I_rst_n),.d_in(vga_data),.row_addr(row_addr),.col_addr(col_addr),.r(O_red),.g(O_green),.b(O_blue),.hs(O_hs),.vs(O_vs));
	
    //在要显示的区域显示图片，需要先获取图片地址R_rom_addr
	always @(posedge R_clk_25M or negedge I_rst_n)
	begin
		if(!I_rst_n)
			R_rom_addr <= 19'd0;
		else if(col_addr>=0&&col_addr<=639&&row_addr>=0&&row_addr<=479)
			begin //这里的作用是背景图全屏显示
                if(R_rom_addr == 307199)
					R_rom_addr <= 19'd0;
				else
					R_rom_addr <= row_addr*40+col_addr;
			end
//			这里以(x,y)为图片左上角的坐标为例来显示图片，注意这里(x,y)的范围是x:0~639; y:0~479
//			begin
//				if(R_rom_addr == imgSize) //imgSize是图像大小-1，即height*width-1
//					R_rom_addr <= 19'd0;
//				else if(col_addr>=x && col_addr<=x+img_width-1 && row_addr>=y && row_addr <= y+img_height-1)
//					R_rom_addr <= R_rom_addr+1'd1;
//			end

	end
	
	//根据已经拿到的图片像素点地址R_rom_addr取对应的数据R_rom_data
	stone myStone (
  .clka(R_clk_25M), // input clka
  .wea(wea), // input [0 : 0] wea
  .addra(R_rom_addr), // input [11 : 0] addra
  .dina(dina), // input [15 : 0] dina
  .douta(W_rom_data) // output [15 : 0] douta
);
	
    //将整个显示区数据给vga_data,既包括图片显示区，也包括其他区域
	always @(posedge R_clk_25M or negedge I_rst_n)
	begin
	if(!I_rst_n)
		vga_data<=12'b0;
	else if(col_addr>=0&&col_addr<=639&&row_addr>=0&&row_addr<=479)
		vga_data<=W_rom_data[11:0];
	else
		vga_data<=12'b1;
	end
	
endmodule
