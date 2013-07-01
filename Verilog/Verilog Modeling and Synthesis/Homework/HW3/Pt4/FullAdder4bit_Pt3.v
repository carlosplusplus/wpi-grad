// Carlos Lazo
// ECE574
// Homework #3

// Part 3: Full Adder, 4 bit implementation,
//         using assign statements and pin-to-pin delays.

`timescale 1ns/100ps

module FullAdder4bit_Pt3 (a, b, cin, s, cout);
  
  // Define a parameter so that the adder can be any size:
  
  parameter SIZE = 4;
  
  // Define inputs and outputs:
  
  input  [SIZE-1:0] a, b;
  input  cin;
  
  output [SIZE-1:0] s;
  output cout;
  
  // Specify pin to pin delay values for the two outputs:
  
  specify
  
    (a, b, cin *> cout) = 20;
    (a, b, cin *> s   ) = 34;
    
  endspecify
  
  // Use one assign statement, using concatenation, 
  // in order to define the Full Adder:
  
  assign {cout, s} = a + b + cin;
  
endmodule