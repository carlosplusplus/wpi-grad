// Carlos Lazo
// ECE574
// Homework #3

// Part 5: Arithmetic Logic Unit (ALU), 8 bit implementation.

`timescale 1ns/100ps

module ALU8bit (input [7:0] Ain, Bin, input [1:0] Fn, input CI,
                output reg [7:0] Result, output reg CO, OV);
  
  // Declare an intermediate variable for overflow detection:
  
  reg [8:0] im_Result;
  
  // After post-synthesis analysis, back annotate timing results
  // into the pre-synthesis module.
  
  specify
  
    (Ain, Bin, Fn, CI *> Result) = 13;
    (Ain, Bin, Fn, CI *> CO) = 12;
    (Ain, Bin, Fn, CI *> OV) = 12;
    
  endspecify
  
  // Use an always statement to detect changes in either:
  // Ain or Bin (inputs) or in Fn (mode of the ALU)
  
  always @(Ain, Bin, Fn) begin
    
    // In order to prevent values from being saved,
    // reset all internal and output variables:
    
    Result = 0; im_Result = 0; CO = 0; OV = 0;
    
    case (Fn)
      
      // When Fn = 00, add Ain + Bin, taking the CI into account.
      
      0: begin 
        
        im_Result    = Ain + Bin + CI;
        {CO, Result} = Ain + Bin + CI;
          
        // Check for overflow:
          
        if (im_Result > 9'b011111111)
          OV = 1'b1;
          
      end
      
      // When Fn = 01, add Ain + 0.5Bin, taking the CI into account.
      
      // Note: Assuming 1's complemnt, 0.5Bin is the same as doing
      // a Right-Shift operation on Bin by one place.
      
      1: begin
        
        im_Result    = Ain + (Bin >> 1) + CI;
        {CO, Result} = Ain + (Bin >> 1) + CI;
        
        if (im_Result > 9'b011111111)
          OV = 1'b1;
          
      end
      
      // When Fn = 10, take the logical AND of Ain and Bin.
      
      2: Result = Ain & Bin;
      
      // When Fn = 11, find the complement of Ain.
      
      3: Result = ~Ain;
      
      default: Result = 8'bX;
      
    endcase    
    
  end
  
endmodule