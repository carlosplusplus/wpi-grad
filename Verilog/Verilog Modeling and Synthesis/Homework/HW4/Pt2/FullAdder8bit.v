// Carlos Lazo
// ECE574
// Homework #4

// Part 2: Full Adder, 8 bit implementation.

`timescale 1ns/100ps

module FullAdder8bit (a, b, cin, s, cout);
  
  // Define a parameter so that the adder can be any size:
  
  parameter SIZE = 8;
  
  // Define inputs and outputs:
  
  input  [SIZE-1:0] a, b;
  input  cin;
  
  output [SIZE-1:0] s;
  output cout;
  
  // Use one assign statement, using concatenation, 
  // in order to define the Full Adder:
  
  assign {cout, s} = a + b + cin;
  
endmodule