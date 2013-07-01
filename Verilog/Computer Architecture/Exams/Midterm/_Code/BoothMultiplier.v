// Carlos Lazo
// ECE505
// Homework 04

// Complete Design of 16-bit Booth Multiplier

`timescale 1ns/100ps

module BoothMultiplier (
    input [15:0] mc, mp,
    input clk, start,
    output [31:0] prod, output busy);

  // Define all wires, which will be output signals from the Controller and Datapath.
  
  wire done, en_CNT, ld_M, ld_Q, rst_A, rst_Count, rst_Qr;
  
  // Instantiate the Controller.
  
  BM_Controller cu (busy, clk, start,
    done, en_CNT, ld_M, ld_Q, rst_A, rst_Count, rst_Qr);
    
  // Instantiate the Datapath.
  
  BM_Datapath dp (mc, mp,
    clk, done, en_CNT, ld_M, ld_Q, rst_A, rst_Count, rst_Qr,
    prod, busy);
    
endmodule