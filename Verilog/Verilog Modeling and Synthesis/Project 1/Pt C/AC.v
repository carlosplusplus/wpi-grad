// Carlos Lazo
// ECE574
// Project Part 1

// Part A: DataPath Design
// Acculmulator Definition

`timescale 1ns/100ps

module AC (input [15:0] data_in,
           input load, clk, 
	  		     output reg [15:0] data_out );
   
   always @( posedge clk )
      if ( load ) data_out <= data_in;
   
endmodule