// Carlos Lazo
// ECE574
// Homework #3

// Part 2: Full Adder, 4 bit implementation.

`timescale 1ns/100ps

module FullAdder4bit (a, b, cin, s, cout);
  
  // Define a parameter so that the adder can be any size:
  
  parameter SIZE = 4;
  
  // Define inputs and outputs:
  
  input  [SIZE-1:0] a, b;
  input  cin;
  
  output [SIZE-1:0] s;
  output cout;
  
  // Variable for moving current cout to the cin of the next adder.
  
  wire   [SIZE-1:0] carry;
  
  genvar i; // Loop variable.
  
  // Generate all instances of full adders, and link them together.
  
  generate
    
    for (i=0; i < SIZE; i=i+1) begin : full_adders
      
      // If this is the first run, take in the first
      // cin value, and begin processing accordingly.
      
      if (i == 0)
        FullAdder fa (a[0], b[0], cin, s[0], carry[0]);
        
      // If we are at the last index, do the final calculation
      // and set the final carry out value to co.
      
      else if (i == SIZE-1)
        FullAdder fa (a[i], b[i], carry[i-1], s[i], cout);
      
      // Otherwise, the current cin is the previous cout,
      // and the current cout is the newly generated cout.
      
      else
        FullAdder fa (a[i], b[i], carry[i-1], s[i], carry[i]);
                
    end
 
  endgenerate
  
endmodule 