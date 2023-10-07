`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:43:29 07/02/2023 
// Design Name: 
// Module Name:    debounce 
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
module Debounce(
  input clk,
  input button,
  output debounced
);

  parameter DEBOUNCE_CYCLES = 5; // defines the number of debounce cycles
  reg [DEBOUNCE_CYCLES-1:0] shift_register=5'b00000;
 
  reg sampled_button_state=0;

 

  always @(posedge clk) begin
    // Shifting the button state into the shift register
    shift_register <= {shift_register[DEBOUNCE_CYCLES-2:0], button};
	 sampled_button_state <= (shift_register == {(DEBOUNCE_CYCLES){1'b1}}) ? 1'b1 :
                           (shift_register == {(DEBOUNCE_CYCLES){1'b0}}) ? 1'b0 :
                           sampled_button_state;
  end

	assign debounced=sampled_button_state;
endmodule


//testbench
module debounce_tb;
	// Inputs
 reg button;
 reg clk;
 // Outputs
 wire debounced;

 // Instantiate the debouncing Verilog code
 Debounce uut (
  .button(button), 
  .clk(clk), 
  .debounced(debounced)
 );
 initial begin
  clk = 0;
  forever #10 clk = ~clk;
 end
 initial begin
  button = 0;
  #10;
  button=1;
  #20;
  button = 0;
  #10;
  button=1;
  #30; 
  button = 0;
  #10;
  button=1;
  #40;
  button = 0;
  #20;
  button=1;
  #30; 
  button = 0;
  #10;
  button=1; 
  #1000; 
  button = 0;
  #10;
  button=1;
  #20;
  button = 0;
  #10;
  button=1;
  #30; 
  button = 0;
  #10;
  button=1;
  #40;
  button = 0; 
 end 
endmodule 
