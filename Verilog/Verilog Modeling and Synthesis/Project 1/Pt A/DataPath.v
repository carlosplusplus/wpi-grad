// Carlos Lazo
// ECE574
// Project Part 1

// Part A: DataPath Design
// DataPath Definition

`timescale 1ns/100ps

module DataPath (input [15:0] DataInput,
                 input Reset_AC, ShiftRight_AC, Add_Input_AC, Increment_AC,
                 input Swaprightleft_AC, Complement_AC, Multiply_AC,
                 input alu_on_bus, clk, ld_AC,
                 output [15:0] DataOutput);
                 
  wire [15:0] ac_bus;                // Used to send values into accumulator.
  wire [15:0] ac_out;                // Output value from the accumulator.
  wire [15:0] alu_out;               // Output from the ALU when not performing multiplication.
  wire  [7:0] MultiplicationOp1;     // Used to store 1st multiplication operand.
  wire  [7:0] MultiplicationOp2;     // Used to store 1st multiplication operand.
  wire        Multiply;              // Used to begin the multiplication operation.
  wire [15:0] Multiplication_Output; // Used to store the output of the multiplication operation;
  wire        Multiplication_Done;   // Signifies whether a multiplication operation is complete.
  
  // Instantiate an Accumulator:
  
  AC ac (ac_bus, ld_AC, clk, ac_out);
  
  // Instantiate an ALU:
  
  ALU alu (DataInput, ac_out, Reset_AC, ShiftRight_AC, Add_Input_AC, Increment_AC,
       Swaprightleft_AC, Complement_AC, Multiply_AC,
       alu_out, MultiplicationOp1, MultiplicationOp2, Multiply);
  
  // Instantiate a Multiplier:
  
  Multiplier mult (MultiplicationOp1, MultiplicationOp2, clk, Multiply,
                   Multiplication_Output, Multiplication_Done);
                   
  
  // Assign the accumulator bus a value based on the requested operation -
  // note that the alu_on_bus will always take precedence over the multiplier.
  
  assign ac_bus     = alu_on_bus ? alu_out : 
                      (Multiplication_Done ? Multiplication_Output : 16'bzzzz_zzzz_zzzz_zzzz);
                      
  // Assign the DataOutput to always equal the value of the accumulator.
  
  assign DataOutput = ac_out;

endmodule;