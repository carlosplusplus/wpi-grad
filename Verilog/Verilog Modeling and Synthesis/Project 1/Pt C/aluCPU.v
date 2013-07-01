// Carlos Lazo
// ECE574
// Project Part 1

// Part C: CPU Design
// CPU Definition

`timescale 1ns/100ps

module aluCPU (input  [15:0] DataInput,
               input   [2:0] instruction,
               input clk, new_instruction, rst,
               output [15:0] DataOutput,
               output ready);
               
  // Declare all wires needed to monitor signals.
  
  wire Reset_AC, ShiftRight_AC, Add_Input_AC, Increment_AC,
       Swaprightleft_AC, Complement_AC, Multiply_AC, alu_on_bus,ld_AC;
       
  // Instatiate the DataPath.
            
  DataPath dp (DataInput, Reset_AC, ShiftRight_AC, Add_Input_AC, Increment_AC,
               Swaprightleft_AC, Complement_AC, Multiply_AC, alu_on_bus, clk, ld_AC,
               DataOutput);
               
  // Instantiate the Controller.
                 
  Controller cu (instruction, clk, new_instruction, rst, ready, Reset_AC, ShiftRight_AC,
                 Add_Input_AC, Increment_AC, Swaprightleft_AC, Complement_AC,
                 Multiply_AC, alu_on_bus, ld_AC);
                 
endmodule