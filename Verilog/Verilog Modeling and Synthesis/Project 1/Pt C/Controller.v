// Carlos Lazo
// ECE574
// Project Part 1

// Part B: Controller Design
// Controller Definition

`timescale 1ns/100ps

`define Idle    2'b00
`define Execute 2'b01
`define Mult    2'b10


module Controller (input [2:0] instruction,
                   input clk, new_instruction, rst,
                   output reg ready, Reset_AC, ShiftRight_AC, Add_Input_AC,
                              Increment_AC, Swaprightleft_AC, Complement_AC,
                              Multiply_AC, alu_on_bus, ld_AC);

  reg [2:0] op_code;
  reg [1:0] present_state, next_state;
  
  // Utilize the clock for all state transitions:
  
  always @(posedge clk) begin
    
    if (rst) present_state <= `Idle;
    
    else present_state <= next_state;
      
  end
  
  // Whenever the present_state of the op_code changes, set the following signals:
  
  always @ (new_instruction or present_state) begin
    
    // Start by setting all outputs to zero to prevent memory (latches):
    
    Reset_AC = 0; ShiftRight_AC = 0; Add_Input_AC = 0; Increment_AC = 0;
    Swaprightleft_AC = 0; Complement_AC = 0; Multiply_AC = 0;
    alu_on_bus = 0; ld_AC = 0;
    
    case (present_state)
      
      `Idle     : begin 
        ready = 1;
        next_state = new_instruction ? `Execute : `Idle;
      end
      
      `Execute  : begin
        
        ready      = 0;
        op_code    = instruction;    
        case (op_code)
          
          // Reset accumulator operation:
          3'b000: begin
            Reset_AC    = 1;
            alu_on_bus  = 1;
            ld_AC       = 1;
            next_state  = `Idle;
          end
          
          // Shift right operation:
          3'b001: begin
            ShiftRight_AC = 1;
            alu_on_bus  = 1;
            ld_AC       = 1;
            next_state  = `Idle;
          end
          
          // Add input operation:
          3'b010: begin
            Add_Input_AC = 1;
            alu_on_bus   = 1;
            ld_AC        = 1;
            next_state   = `Idle;
          end
          
          // Increment accumulator operation:
          3'b011: begin
            Increment_AC = 1;
            alu_on_bus   = 1;
            ld_AC        = 1;
            next_state   = `Idle;
          end
          
          // Swap accumulator MSB's and LSB's operation:
          3'b100: begin
            Swaprightleft_AC = 1;
            alu_on_bus       = 1;
            ld_AC            = 1;
            next_state       = `Idle;
          end
          
          // Complement accumulator operation:
          3'b101: begin
            Complement_AC = 1;
            alu_on_bus    = 1;
            ld_AC         = 1;
            next_state    = `Idle;
          end
          
          // Multiply accumulator operation:
          3'b110: begin
            Multiply_AC   = 1;
            next_state    = `Mult;
          end
          
        endcase
        
      end
        
        // Extra state needed for 1 clock of resolution for multiplication operation.
        
      `Mult: begin
          ld_AC      = 1;
          next_state = `Idle; 
      end
      
      default: next_state = `Idle;       
    endcase  
  end
endmodule