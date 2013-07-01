// Carlos Lazo
// ECE505
// Homework 02 - Pt3

// S2PC to P2SC TestBench

`timescale 1ns/100ps

module S2PC_To_P2SC_Tester;
  
  // Initialize shared inputs and outputs:
  
  reg clk;

  // Initialize inputs and outputs for S2PC:
  
  reg  s_in, s_start;
  
  wire [8:0] parout;
  wire s_ready;
  
  // Instantiate a S2PC module:
  
  S2PC s_UUT (clk, s_start, s_in, parout, s_ready);
  
  // Initialize inputs and outputs for P2SC:
  
  reg p_start;
  
  wire p_ready, sout;
  
  // Instantiate a P2CS module, using the last 8 bits of parout as p_in:
  
  P2SC p_UUT (parout[7:0], clk, p_start, sout, p_ready);
  
  // Initialize all registers to initial values:
  
  initial begin
    
    clk   = 0;
    p_start = 0; s_start = 0;
    s_in = 0;
    
  end
  
  // Initialize the clock:
  
  initial repeat (50) #10 clk = ~clk;
  
  // Assign the parallel input to a random value every 7ns
  
  initial repeat (70) #7 s_in = $random;
  
  // Generate the testbench timeline:
  
  initial begin
    
    s_start <= #25 1;
    s_start <= #35 0;
    
    p_start <= #245 1;
    p_start <= #255 0;
    
  end
      
endmodule