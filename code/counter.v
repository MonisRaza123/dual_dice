`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:52:32 06/30/2023 
// Design Name: 
// Module Name:    counter 
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
module counter(input clk,  input enable,
					output [3:0]count
					);
	reg [3:0] q=4'b0010;
	always@(posedge clk)begin
		if(q>=4'b1100)q<=4'b0010;
		else if(enable)q<=q+4'b0001;
	end
	assign count=q;
endmodule

//testbench........
module counter_tb;
	reg clk;
	//reg reset;
	reg enable;
	wire[3:0]count;
	counter uut(clk,/*reset,*/enable,count);
	always begin
		#10;
		clk=~clk;
	end
	initial begin
		clk=0;
		//reset=0;
		enable=0;
		//reset=1;
		#5;
		enable=1;
		#25;
		enable=0;
		#44;
		enable=1;
		#66;
		enable=0;
		#30;
		enable=1;
		#700;
		enable=0;
	end
endmodule

