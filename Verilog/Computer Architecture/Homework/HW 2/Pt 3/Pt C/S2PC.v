// Carlos Lazo
// ECE505
// Homework 02 - Pt3

// S2PC Module

`timescale 1ns/100ps

module S2PC (input clk, start, s_in,
             output [8:0] parout, output ready);
             

  // Use wires to store all outputs from the Controller:
  
  wire done, shift_en;
  
  // Instantiate the Datapath:
  
  S2PC_Datapath   dp (clk, s_in, done, shift_en, parout);
  
  S2PC_Controller cu (clk, start, done, ready, shift_en);
  
endmodule