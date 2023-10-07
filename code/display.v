`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:23:25 06/30/2023 
// Design Name: 
// Module Name:    Display 
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
module Display(input clk, input disp_en, input  [3:0] C1, input  [3:0] C2,
					output reg [6:0] seg, output reg [3:0] digit
					);
	reg [1:0] state, next_state;
	parameter D1=2'b00, D2=2'b01, D3=2'b10, D4=2'b11;
	reg [3:0]a;
	reg [3:0]b;
	reg [3:0]c;
	reg [3:0]d;
	reg [3:0] count;

	//digit allocation to temp variables |a|b|c|d|
	always@(C1,C2)begin
			
		  a = (C1 < 4'b1010) ? 4'b0000 : 4'b0001;
        b = (C1 < 4'b1010) ? C1 : (C1 - 4'b1010);
        c = (C2 < 4'b1010) ? 4'b0000 : 4'b0001;
        d = (C2 < 4'b1010) ? C2 : (C2 - 4'b1010);
			
	end
	
	
	//state transition logic
	always@(state,disp_en)begin
		if(~disp_en)digit=4'b0000;
		else begin
			case(state)
				D1:begin
					digit=4'b1000;
					count=a;
					next_state=D2;
				end
				D2:begin
					digit=4'b0100;
					count=b;
					next_state=D3;
				end
				D3:begin
					digit=4'b0010;
					count=c;
					next_state=D4;
				end
				D4:begin
					digit=4'b0001;
					count=d;
					next_state=D1;
				end
			endcase
		end
	end
	
	//state flip flops
	always@(posedge clk)begin
		state<=next_state;
	end

	//segment assignment
	always@(count)begin
		case (count)
			4'b0000 : begin seg = 7'b1111110; end
			4'b0001 : begin seg = 7'b0110000; end
			4'b0010 : begin seg = 7'b1101101; end
			4'b0011 : begin seg = 7'b1111001; end
			4'b0100 : begin seg = 7'b0110011; end
			4'b0101 : begin seg = 7'b1011011; end
			4'b0110 : begin seg = 7'b1011111; end
			4'b0111 : begin seg = 7'b1110000; end
			4'b1000 : begin seg = 7'b1111111; end
			4'b1001 : begin seg = 7'b1110011; end
			default : begin seg = 7'b0000000; end
		endcase
	end
	
	
endmodule
