// Carlos Lazo
// ECE574
// Test 2

// FIR Filter - Program Counter Implementation
// * No modifications made from original code *

`timescale 1ns/100ps

module ProgramCounter (in, enable, clk, out);
input [15:0] in;
input enable, clk;
output [15:0] out;
reg [15:0] out;

	always @(negedge clk)
		if (enable) out = in;

endmodule