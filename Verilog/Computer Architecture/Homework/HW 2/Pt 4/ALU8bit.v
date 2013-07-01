// Carlos Lazo
// ECE505
// Homework 02 - Pt4

// 8bit Arithmetic Logic Unit (ALU)

`timescale 1ns/100ps

module ALU8bit (A, B, S, R, Co);
  
  // Define inputs and outputs:
  
  input  [7:0] A, B;
  input  [2:0]    S;
  
  output reg [7:0] R;
  output reg      Co;
  
  // Use an always statement to detect changes in either:
  // A or B (data inputs), or S (mode of ALU)
  
  always @(A, B, S) begin
    
    // In order to prevent values from being saved,
    // reset all internal and output variables:
    
    R = 0; Co = 0;
    
    case (S)
    
      // When S = 000, R = A + B, and account for a carryout.
    
      0:  {Co, R} = A + B;
    
      // When S = 001, R = A - B.
      
      1:        R = A - B;
    
      // When S = 010, R = A + 2*B:
    
      2:        R = A + (B + B);
    
      // When S = 011, R = A - 2*B:
    
      3:        R = A - (B + B);
      
      // When S = 100, R = A ^ B:
    
      4:        R = A ^ B;

      // When S = 101, R = min(A,B):
    
      5:  if (A <= B)
                R = B;
          else
                R = A;
  
      // When S = 110, R = abs(A):
    
      6:  if (A[7] == 1)
                R = ~A + 1;
          else
                R = A;
      
      // When S = 111, R = B:
    
      7:        R = B;         
      
      // Set default values, just in-case:
    
      default:  R  = 8'bX;      
    
    endcase
  end
endmodule 