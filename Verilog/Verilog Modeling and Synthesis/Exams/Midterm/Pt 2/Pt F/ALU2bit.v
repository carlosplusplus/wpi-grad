// Carlos Lazo
// ECE574
// Test 1

// Part 2: Arithmtic Logic Unit (ALU)
// Part A: 2-bit Cascadable ALU slice

`timescale 1ns/100ps

module ALU2bit (input  [1:0] A, B, S, input Ci,
                output [1:0] R, output Co, V, Z);
  
    /* 
     The boolean representations of s and cout are as follows:
  
     s    = (a XOR b) XOR cin
     cout = ((a XOR b) AND cin) OR (a AND b)
     
  */
  
  // Setup primitives for S = 00, ADD:
  
    // For the 1st bit (LSB) in A and B -
  
  wire o_xor_1, o_nand1_1, o_nand2_1;  // Intermediate gates
  wire R0_S00;
  wire o_cin;
  
  xor #(3,5)
    (o_xor_1, A[0], B[0]),
    (R0_S00, o_xor_1, Ci);
  
  nand #(3,5)
    (o_nand1_1, o_xor_1, Ci),
    (o_nand2_1, A[0], B[0]),
    (o_cin, o_nand1_1, o_nand2_1);
    
    // For the 2nd bit (MSB) in A and B -
    
  wire o_xor_2, o_nand1_2, o_nand2_2;
  wire R1_S00;
  wire Co_S00;
  
  xor #(3,5)
    (o_xor_2, A[1], B[1]),
    (R1_S00, o_xor_2, o_cin);
  
  nand #(3,5)
    (o_nand1_2, o_xor_2, o_cin),
    (o_nand2_2, A[1], B[1]),
    (Co_S00, o_nand1_2, o_nand2_2); // Co will always be defined here.
    
  // Setup primitives for S = 01, XOR:
  
  wire R0_S01, R1_S01;
  
  xor #(3,5)
    (R0_S01, A[0], B[0]),
    (R1_S01, A[1], B[1]);
    
  // Setup primitives for S = 10, AND:
  
  wire R0_S10, R1_S10;
  
  and #(3,5)
    (R0_S10, A[0], B[0]),
    (R1_S10, A[1], B[1]);
    
  // Setup primitives for S = 11, Transparent:
  
  wire R0_S11, R1_S11;
  
  buf #(2,4)
    (R0_S11, A[0]),
    (R1_S11, A[1]);
  
  // Setup 4-to-1 multiplexer based on circuit signals:
  
  wire S0, S1, _S0, _S1;
  
  buf #(2,4)
    (S0, S[0]),
    (S1, S[1]);
  
  not #(2,4)
    (_S0, S0),
    (_S1, S1);
    
    // Compute R[0] based on choice of signals:
    
  wire R0_out00, R0_out01, R0_out10, R0_out11;
  
  and #(4,6)
    (R0_out00, R0_S00, _S1, _S0),
    (R0_out01, R0_S01, _S1,  S0),
    (R0_out10, R0_S10,  S1, _S0),
    (R0_out11, R0_S11,  S0,  S1);
    
  wire R0;
    
  or #(4,7)
    (R[0], R0_out00, R0_out01, R0_out10, R0_out11);
    
    // Compute R[1] based on choice of signals:
    
  wire R1_out00, R1_out01, R1_out10, R1_out11;
  
  and #(4,6)
    (R1_out00, R1_S00, _S1, _S0),
    (R1_out01, R1_S01, _S1,  S0),
    (R1_out10, R1_S10,  S1, _S0),
    (R1_out11, R1_S11,  S0,  S1);
  
  or #(4,7)
    (R[1], R1_out00, R1_out01, R1_out10, R1_out11);
  
  // Define the carry out, Co:
  
  and #(4,6)
    (Co, Co_S00, _S1, _S0);
    
  // Define the overflow variable, V:
  
    // OV = (A[1] == B[1]) && (A[1] != R[1])
  
  wire xnor1_v, xnor2_v;
  
  xnor #(3,5) (xnor1_v, A[1], B[1]);
  xor  #(3,5) (xnor2_v, A[1], R[1]);
  
  and  #(4,7) (V, xnor1_v, xnor2_v, _S1, _S0);  // Affected only when S = 00.
  
  // Define the zero flag, Z:
  
  nor #(3,5)
    (Z, R[0], R[1]);  // Affected for all definitions of S.
  
endmodule