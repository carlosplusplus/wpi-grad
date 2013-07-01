// Carlos Lazo
// ECE574
// Homework #4

// Part 1: Counter Cell module,
//         used for implementing an N-bit counter.

`timescale 1ns/100ps

// Define a module for a D FlipFlop.

module DFlipFlop (clk, rst, D, Q);
  
  // Define inputs and outputs:
  
  input clk, rst, D;
  output reg Q;
  
  // Define logic for the D Flip Flop:
  
  always @ (posedge clk)
    if (~rst)
      Q <= 1'b0;
    else
      Q <= D;
    
endmodule

// Define the CounterCell module.

module CounterCell (clk, rst, init, cin, cout);
  
  
  // Define inputs and outputs:
  
  input  clk, rst, init, cin;
  output cout;
  
  wire XOR_out;
  wire AND_Din;
  
  wire D,Q;
  
  DFlipFlop FF(clk,rst,D,Q);
  
  // Define the logic for the circuit:
  
  and(D, _init, XOR_out);
  and(cout, cin, Q);
  
  not(_init, init);
  
  xor(XOR_out, cin, Q);

endmodule