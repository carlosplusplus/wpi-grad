// Carlos Lazo
// ECE574
// Homework #2

// This is the module for the memory modeling exercise
// for Homework #2 Part 2. 

`timescale 1ns/100ps
  
module MemoryModel (input clk, read, write,
                    input [7:0] inbus,
                    input [9:0] addrbus,
                    output reg [7:0] outbus);

  // Define the memory, words = 8 bits and an address space = 1024.	            
  
  reg [7:0] myMem [0:1023];
                      
  // The read input must be asserted asynchronously, so always
  // check to see when it changes state.
                        
  always @(read) begin
  
    // If read was just set to 1, then perform the read operation.

    if (read)
      outbus <= myMem[addrbus][7:0];
      
  end
  
  // The write input must be asserted synchronously with the clock,
  // so first check to see if we're at the rising edge.
  
  always @(posedge clk) begin
  
    // If write is currently asserted as 1, then perform write
    // into the memory block.
    
    if (write)
      myMem[addrbus][7:0] <= inbus;
      
  end
  
endmodule