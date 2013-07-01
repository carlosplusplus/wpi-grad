// Carlos Lazo
// ECE505
// Final Exam

// Controller of 16-bit CPU

`timescale 1ns/100ps

module Controller (
    input [2:0] opcode,
    input zero,
    output reg add, enPC, ld_r0, rd_mem, pc_src, r0_src, swap_reg, sub, wr_mem);
    
  always @(opcode) begin
    
    // Initialize all outputs to 0 to prevent latches:
    
    add = 0; enPC = 0; ld_r0 = 0; rd_mem = 0; pc_src = 0;
    r0_src = 0; swap_reg = 0; sub = 0; wr_mem = 0;
    
    case (opcode)
      
      3'b000: begin   // LDR
        enPC = 1; rd_mem = 1; r0_src = 1;
      end
        
      3'b001: begin   // STR
        enPC = 1; wr_mem = 1;
      end
        
      3'b010: begin   // ADD
        enPC = 1; add = 1; ld_r0 = 1;
      end
        
      3'b011: begin   // SUB
        enPC = 1; sub = 1; ld_r0 = 1;
      end
        
      3'b100: begin   // JMP
        pc_src = 1; enPC = 1;
      end
      
      3'b101: begin   // JEZ
        if (zero)
          pc_src = 1;
        
        enPC = 1;
      end
      
      3'b110: begin   // SWP
        enPC = 1; swap_reg = 1;
      end 
      
      3'b111: begin   // HLT
        enPC = 0;
      end
      
      default: enPC = 0;   
    endcase
  end
endmodule