// Carlos Lazo
// ECE505
// Homework 02 - Pt2

// Moore Detector for Sequence 1011

`timescale 1ns/100ps

module MooreDetector1011 (input A, clk, R, output W);
  
  parameter [2:0] sA = 3'b000, sB = 3'b001, sC = 3'b010, sD = 3'b011, sE = 3'b100;
  reg [2:0] current;
  
  // In order to provide an asynchronous reset variable R,
  // add R to the sensitivity list and check it's state first,
  // before going into the state-transition logic.
  
  always @(posedge clk or R) begin
    
    // If R = 1, reset the state machine back to the initial state of A.
    if (R)
      current <= sA;
      
    else begin
      
      // Implement all state transitions based on sequential logic.
      
      case (current) 
        sA: if (A) current <= sB; else current <= sA;
        sB: if (A) current <= sB; else current <= sC;
        sC: if (A) current <= sD; else current <= sA;
        sD: if (A) current <= sE; else current <= sC;
        sE: if (A) current <= sB; else current <= sC;
      endcase
    end 
  end
  
  // Assign the output W = 1 if we are at the last state of E.
 
  assign W = (current == sE) ? 1 : 0;
  
endmodule