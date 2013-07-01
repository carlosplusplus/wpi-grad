// Carlos Lazo
// ECE505
// Homework 03

// Complete Design of 16-bit CPU

`timescale 1ns/100ps

module CompArch_CPU (
    input clk, reset,
    output [15:0] addr_bus, output rd_mem, wr_mem,
    inout  [15:0] data_bus);
    
  // Define all wires, which will be output signals from the Controller.
    
  wire [2:0] op_code;
  wire [1:0] ALU_op;
  wire ACC_ON_DBUS, enACC, enIR, enMC, enMP, enPC, MuxAsel, MuxBsel, zero, multbusy, multstart,
       st_LSB, st_MSB;
                
  // Instantiate the Controller.
  
  Controller cu (op_code, clk, reset, zero, multbusy, ALU_op,
                 ACC_ON_DBUS, enACC, enIR, enMC, enMP, enPC,
                 MuxAsel, MuxBsel, multstart, rd_mem, wr_mem, st_LSB, st_MSB);
                 
  // Instantiate the Datapath.
  
  Datapath dp (ALU_op, ACC_ON_DBUS, enACC, enIR, enMC, enMP, enPC, MuxAsel, MuxBsel,
                multstart, st_LSB, st_MSB, clk, addr_bus, op_code, zero, multbusy, data_bus);
    
endmodule