// Carlos Lazo
// ECE574
// Homework #3

// Part 1: Full Adder implementation.

`timescale 1ns/100ps

module FullAdder (input a, b, cin, output s, cout);
  
  // Define all intermediate signals in the circuit:
  
  wire out_xor1;  // Output for a ^ b
  wire out_nand1; // Output for nand ((a ^ b) & cin)
  wire out_nand2; // Output for nand( a & b)
  
  /* 
     The boolean representations of s and cout are as follows:
  
     s    = (a XOR b) XOR cin
     cout = ((a XOR b) AND cin) OR (a AND b)
     
  */
  
  // Define the 2 XOR gates in the circuit with specified delays:
  
  xor #(4,5)
    (out_xor1, a, b),
    (s, out_xor1, cin);

  // Define the 3 NAND gates in the circuit with specified delays:
  
  nand #(4,5)
    (out_nand1, out_xor1, cin),
    (out_nand2, a, b),
    (cout, out_nand1, out_nand2);
    
endmodule