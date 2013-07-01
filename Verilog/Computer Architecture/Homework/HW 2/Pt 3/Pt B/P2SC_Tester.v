// Carlos Lazo
// ECE505
// Homework 02 - Pt3

// P2SC TestBench

`timescale 1ns/100ps

module P2SC_Tester;
  
  // Initialize inputs and outputs:
  
  reg [7:0] p_in;
  reg clk, start;
  
  wire ready, sout;
  
  // Instantiate a S2PC module:
  
  P2SC UUT (p_in, clk, start, sout, ready);
  
  // Initialize all registers to initial values:
  
  initial begin
    
    clk   = 0;
    start = 0;
    p_in  = 0;
    
  end
  
  // Initialize the clock:
  
  initial repeat (25) #10 clk = ~clk;
  
  // Assign the parallel input to a random value every 7ns
  
  initial repeat (35) #7 p_in = $random;
  
  // Begin the sequence of serial input:
  
  initial begin
    
    start <= #25 1;
    start <= #35 0;
    
  end
  
endmodule