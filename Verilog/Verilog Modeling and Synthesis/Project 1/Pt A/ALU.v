// Carlos Lazo
// ECE574
// Project Part 1

// Part A: DataPath Design
// ALU Definition

`timescale 1ns/100ps

module ALU (input [15:0] DataInput, AC_Input,
            input Reset_AC, ShiftRight_AC, Add_Input_AC, Increment_AC,
            input Swaprightleft_AC, Complement_AC, Multiply_AC,
            output reg [15:0] alu_out,
            output reg  [7:0] MultiplicationOp1, MultiplicationOp2,
            output reg Multiply);
            
  // Place all inputs and controller variables on the sensitivity list.
            
  always @(DataInput or AC_Input or Reset_AC or ShiftRight_AC or Add_Input_AC 
           or Increment_AC or Swaprightleft_AC or Complement_AC or Multiply_AC) begin
             
    // Reset all outputs so that no values are kept and to prevent latches:
    
    Multiply          =  0;
    
    // ******************************************************
    // ** Use Controller signals to perform ALU functions. **
    // ******************************************************
    
    // Opcode = 000 --> Reset the accumulator.             
           
    if (Reset_AC) begin
      alu_out = 16'b0000_0000_0000_0000;
    end
    
    // Opcode = 001 --> Perform a logical right-shift on the accumulator.
    
    else if (ShiftRight_AC) begin
      alu_out = AC_Input >> 1;
    end
    
    // Opcode = 010 --> Add Data_Input to the accumulator.
    
    else if (Add_Input_AC) begin
      alu_out = DataInput + AC_Input;
    end
    
    // Opcode = 011 --> Increment the accumulator by 1.
    
    else if (Increment_AC) begin
      alu_out = AC_Input + 1;
    end
    
    // Opcode = 100 --> Swap the 8 MSB's with the 8 LSB's in the accumulator.
      
    else if (Swaprightleft_AC) begin
      alu_out[15:8] =  AC_Input[7:0];
      alu_out[7:0 ] = AC_Input[15:8];
    end
    
    // Opcode = 101 --> Complement the current accumulator.
    
    else if (Complement_AC) begin
      alu_out = ~AC_Input;
    end
    
    // Opcode = 110 --> Peform the multiplication operation by setting all
    //                  appropriate signals for the Multiplier module.
    
    else if (Multiply_AC) begin
      MultiplicationOp1 =  DataInput[15:8];
      MultiplicationOp2 =   AC_Input[15:8];
      Multiply          =                1;
    end
    
    // In case anything else but a valid Opcode is received,
    // simply set alu_out = 0 (reset operation).
    
    else
      alu_out = 0;
      
  end
  
endmodule