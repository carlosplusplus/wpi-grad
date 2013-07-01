// Carlos Lazo
// ECE574
// Project Part 1

// Part A: DataPath Design
// Multiplier Definition

`timescale 1ns/100ps

module Multiplier (input [7:0] a, b,
                   input clk, Multiply,
                   output [15:0] Multiplication_Output,
                   output Multiplication_Done);
 
  reg [15:0] im_r;
  reg [ 7:0] im_a, im_b;
  
  reg isNegA, isNegB, isNegR, im_done;
  
  initial begin
    
    im_a = 0;
    im_b = 0;
    
    isNegA = 0;
    isNegB = 0;
    isNegR = 0;
    
  end
  
  always @ (posedge clk) begin
    
    if (Multiply) begin
      
      im_done = 0;
      
      isNegA = 0;
      isNegB = 0;
      isNegR = 0;
      
      // Check to see if a and b are negative values.
      // If we get a negative value, find it's absolute value
      // in order to use the multiplication operation correctly.
      
      if (a[7] == 1) begin
        isNegA = 1;
        im_a   = ~(a - 1);
      end
      else
        im_a   = a;
        
      if (b[7] == 1) begin
        isNegB = 1;
        im_b   = ~(b - 1);
      end
      else
        im_b   = b;
      
      // If only 1 of the values is negative,
      // then result will be a negative number.
      
      if ((isNegA && ~isNegB) || (~isNegA && isNegB)) isNegR = 1;
        
      // If we expect a negative result, perform multiplication
      // of the magnitudes of the inputs, and translate result into
      // 2's complement. If not, perform mutliplication regulary.
      
      if (isNegR)
        im_r = ~(im_a * im_b) + 1;
      else
        im_r = im_a * im_b;

      
      im_done = 1;    
     
    end
  end
  
  assign Multiplication_Done   = im_done;
  assign Multiplication_Output = im_r; 
  
endmodule