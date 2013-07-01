// Carlos Lazo
// ECE505
// Homework 03

// Datapath of 16-bit CPU

`timescale 1ns/100ps

module Datapath (
    input [1:0] ALU_op,
    input ACC_ON_DBUS, enACC, enIR, enPC, MuxAsel, MuxBsel, clk,
    output [15:0] addr_bus, output [2:0] IR15_13, output zero,
    inout [15:0] data_bus);
     
  // Initialize all registers and wires needed for the Datapath:
     
  reg  [15:0] ACCout, ALUout, IRout, PCout;
  wire [15:0] MuxBout;
  
  initial begin
    ACCout = 0;
    ALUout = 0;
    IRout  = 0;
    PCout  = 0;
  end
     
  // If the Accumulator is enabled, load ACCout with data from ALU.
  always @ (posedge enACC) ACCout = ALUout;
     
  // If the Instruction Register is enabled, load IRout with new data.
  always @ (posedge enIR)  IRout  = data_bus;
     
  // If the Program Counter is enabled, load the PCout with data from the ALU.
  always @ (posedge enPC)  PCout  = ALUout;
     
  // Perform ALU operations when ACC, IR, or ALU_op change:
     
  always @ (posedge enACC or ALU_op) begin
    case (ALU_op)
      2'b00: ALUout = MuxBout;
      2'b01: ALUout = ACCout  - MuxBout;
      2'b10: ALUout = ACCout  + MuxBout;
      2'b11: ALUout = MuxBout + 1;
    endcase
  end
    
  // If MuxBsel = 1, set Mux output with addr_bus. Else, set with data_bus.
  assign MuxBout  = MuxBsel ? addr_bus : data_bus;     
    
  // If MuxAsel = 1, place IR on addr_bus, else, place PC on addr_bus.
  assign addr_bus = MuxAsel ? {3'b000, IRout[12:0]} : PCout;
    
  // If ACC data is to be on the data_bus, set it to contain that data.
  assign data_bus = ACC_ON_DBUS ? ACCout : 16'bz;
    
  // Assign the opcode, which are the 3 MSB's from the IR.
  assign IR15_13 = IRout [15:13];
    
  // Assign the zero variable to 1 if ACC = 0.
  assign zero = (ACCout == 0) ? 1 : 0;
    
endmodule