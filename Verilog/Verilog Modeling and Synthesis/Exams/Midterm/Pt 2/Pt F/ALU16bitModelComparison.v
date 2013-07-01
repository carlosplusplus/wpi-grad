// Carlos Lazo
// ECE574
// Test 1

// Part 2: Arithmtic Logic Unit (ALU)
// Part F: 16-bit Cascadable ALU Comparison

`timescale 1ns/100ps

module ALU16bitModelComparison;
  
  // Declare all inputs as reg and outputs as wire:
  
  reg [15:0] A, B;
  reg  [1:0] S;
  reg Ci;
  
  wire [15:0] R_P, R_A;
  wire Co_P, Co_A, V_P, V_A, Z_P, Z_A;
  
  // Instantiate the two different versions of the 16bit ALU:
  
  ALU16bit       UUT_Primitive (A, B, S, Ci, R_P, Co_P, V_P, Z_P);
  ALU16bitAlways UUT_Always    (A, B, S, Ci, R_A, Co_A, V_A, Z_A);
  
  // Define initial values for all given inputs.
  
  initial begin
    
    A = 16'b0000000000000000;
    B = 16'b0000000000000000;
    S = 2'b00; Ci = 0;
    
  end
  
  // Define a parameter to choose the appropriate simulation:
  
  parameter SIM_CHOICE = 5;
  
  // Create the testbench sequence, showing expected results.
  
  initial begin

    #0;
    
    // Simulation #1:
    
    // Worst case timing scenario -

    // Set  A = 0000000011111111
    // Set  B = 1111111100000000
    // Set Ci = 1
    
    // R = 0000000000000000, Co = 1, V = 0, Z = 1.
    
    
    if (SIM_CHOICE == 1) begin

      A  <= 16'b0000000011111111;
      B  <= 16'b1111111100000000;
      S  <= 2'b00;
      Ci <= 1;
    
      #200;
    
    end
    
    // Simulation #2:
    
    // Testing the generic ADD function -

    // Set  A = 1100011010111000
    // Set  B = 0001010110100100
    // Set Ci = 0
    
    if (SIM_CHOICE == 2) begin

      A  <= 16'b1100011010111000;
      B  <= 16'b0001010110100100;
      S  <= 2'b00;
      Ci <= 0;
    
      #200;
    
    end
    
    // Simulation #3:
    
    // Testing the generic XOR function -

    // Set  A = 1100011010111000
    // Set  B = 0001010110100100
    
    if (SIM_CHOICE == 3) begin

      A  <= 16'b1100011010111000;
      B  <= 16'b0001010110100100;
      S  <= 2'b01;
      Ci <= 0;
    
      #200;
    
    end
    
    // Simulation #4:
    
    // Testing the generic AND function -

    // Set  A = 1100011010111000
    // Set  B = 0001010110100100
    
    if (SIM_CHOICE == 4) begin

      A  <= 16'b1100011010111000;
      B  <= 16'b0001010110100100;
      S  <= 2'b10;
      Ci <= 0;
    
      #200;
    
    end
    
    // Simulation #5:
    
    // Testing the generic Transparency function -

    // Set  A = 1100011010111000
    // Set  B = 0001010110100100
    
    if (SIM_CHOICE == 5) begin

      A  <= 16'b1100011010111000;
      B  <= 16'b0001010110100100;
      S  <= 2'b11;
      Ci <= 0;
    
      #200;
    
    end
    
  end
  
endmodule