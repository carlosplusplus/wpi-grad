// Carlos Lazo
// ECE574
// Homework #5

// Part 2: Finding smallest value in Memory

`timescale 1ns/100ps

module minMemValue (clk, data, start, rd_addr, ready, out);
  
  // Initialize inputs and outputs:
  
  input [7:0] data;
  input       clk, start;
   
  output reg [9:0]  rd_addr;
  output reg [7:0]      out;
  output reg          ready;
  
  // Initialize temporary storage and counters/loop variables:
  
  reg [7:0] minVal;
  
  integer   EN;
  
  // Initialize all variables appropriately:
  
  initial begin
    
    EN      =  0;
    ready   =  1;
    rd_addr = 10'b0;
    out     =  8'bX;
    
    minVal  = 8'b1;
    
  end
  
  // Perform calculations when start is asserted:
  
  always @(posedge clk) begin
  
    // If start is asserted as 1, enable the logic in the circuit
    // and set the ready indicator to 0. Clear variables to ensure
    // no memory elements are present.
  
    if (start == 1 & EN == 0) begin
      
      EN = 1;
      
      ready = 0;
      
      rd_addr = 10'b0;
      out     = 8'bX;
      minVal  = 8'b11111111;
      
    end
    
    // If at the last memory address,
    // Find last value; output = minValue, EN = 1, Ready = 0
    
    if (rd_addr == 10'b1111111111) begin
      
      if (data < minVal)
        minVal = data;
        
      // Output the minimum value of the circuit:
      
      out <= minVal;
      
      // Reset the state of the logic.
      
      EN    = 0;
      ready = 1;
      
    end
    
    // If the circuit is enabled, search for the smallest value in the memory:
    
    if (EN == 1) begin
      
      if (data < minVal) 
        minVal <= data;
        
      rd_addr = rd_addr + 10'b0000000001;
      
    end
    
  end
  
endmodule