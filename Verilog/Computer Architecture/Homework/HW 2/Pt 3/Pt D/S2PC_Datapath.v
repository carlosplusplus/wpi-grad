// Carlos Lazo
// ECE505
// Homework 02 - Pt3

// Datapath for S2PC

`timescale 1ns/100ps

module S2PC_Datapath (input clk, s_in, done, shift_en,
                      output [8:0] parout);
  
  // Define registers and state variables:
  
  reg [7:0] Shift_Reg ;
  
  wire par;           // Used to compute the parity bit
  wire [8:0] im_par;  // Holds parity data
  
  // Perform the shift operation iF shifting is enabled (for 8 clk pulses).

  always @ (posedge clk)
    if (shift_en)
      Shift_Reg <= {s_in, Shift_Reg[7:1]};
  
  // When we are done, set the parity bit = XOR of the input.
  // Also set parout to be the parity bit concatenated with the shift-register.
  
  assign par    = done ? (^Shift_Reg)     : 1'bz;
  assign parout = done ? {par, Shift_Reg} : 9'bz;
      
endmodule  