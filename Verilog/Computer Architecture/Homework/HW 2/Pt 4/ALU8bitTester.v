// Carlos Lazo
// ECE505
// Homework 02 - Pt4

// 8bit Arithmetic Logic Unit (ALU) Testbench

`timescale 1ns/100ps

module ALU8bitTester;
  
  // Define inputs and outputs:
  
  reg [7:0] A, B;
  reg [2:0]    S;
  
  wire [7:0]   R;
  wire        Co;
  
  // Instantiate the ALU.
  
  ALU8bit UUT (A,B,S,R,Co);
    
  // Initialize all registers to = 0.
  
  initial begin
    A = 0; B = 0; S = 0;
  end
  
  // Create an asynchronous simulation which will depend on hardcoded
  // timings, to ensure ALU functionality:
  
  initial begin
    
    // Perform the ALU functions each 1 time, on random input.
    
    repeat (8) begin
    
      A = $random;
      B = $random / 2;
      
      // Wait 25 ns before changing the ALU state and input variables:
      
      #25;
      
      S = S + 1;
    
    end
  end 
   
endmodule