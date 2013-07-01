// Carlos Lazo
// ECE505
// Homework 04

// Datapath of 16-bit Booth Multiplier

`timescale 1ns/100ps

module BM_Datapath (
    input [15:0] mc, mp,
    input clk, done, en_CNT, ld_M, ld_Q, rst_A, rst_Count, rst_Qr,
    output [31:0] prod, output busy);
  
  // Initialize all registers and wires needed for the Datapath:
  
  // A  = Resultant, M = Multiplicand, Q = Multiplier
  // Qr = 2nd bit of moving 'Q window'
  
  reg [15:0] A, Q, M, res;
  reg  [4:0] count;
  reg Qr;
  
  initial begin
    A   = 0;
    Q   = 0;
    M   = 0;
    Qr  = 0;
    count = 0;
  end
  
  // Create load and reset logic to be used for each new multiplication.
  
  always @ (posedge ld_M)   M <= mc;
  always @ (posedge ld_Q)   Q <= mp;
  always @ (posedge rst_A)  A  <= 0;
  always @ (posedge rst_Qr) Qr <= 0;
  always @ (posedge rst_Count) count <= -1;
  
  // Create counter logic:
  
  always @ (posedge en_CNT) count <= count + 1'b1;
  
  assign busy = (en_CNT) && (count < 16);
  
  // Create ALU logic:
  
  always @ (posedge clk) begin
    
    // If we are in the process of multiplying:
    if (busy) begin
      
      // Perform a case statement on the current Q 2'b window:
      
      case ({Q[0], Qr})
        
        // If a 01 is seen, add M to A and perform and shift.
        
        2'b0_1: begin
            res = A + M;
            {A, Q, Qr} <= {res[15], res, Q};
        end
        
        // If a 10 is seen, add -M to A and perform and shift.
        
        2'b1_0: begin
            res = A + (~M) + 1;
            {A, Q, Qr} <= {res[15], res, Q};
        end
        
        // Otherwise, perform no arithmetic and shift.
        
        default: {A, Q, Qr} <= {A[15], A, Q};
      endcase
    end
  end
  
// If done multiplying or idle, output the correct product.
        
assign prod = done ? { A,Q } : 32'bX;
  
endmodule