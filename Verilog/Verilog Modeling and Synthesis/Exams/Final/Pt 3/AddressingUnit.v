// Carlos Lazo
// ECE574
// Test 2

// FIR Filter - AdressingUnit Implementation

`timescale 1ns/100ps

module AddressingUnit (
	Rside, Iside, Address, clk, ResetPC, PCplusI, PCplus1, RplusI, Rplus0, PCenable
);
input [15:0] Rside;
input [7:0] Iside;
input ResetPC, PCplusI, PCplus1, RplusI, Rplus0, PCenable;
input clk;
output [15:0] Address;
wire [15:0] PCout;

// Eliminate unecessary wires and signals.

	ProgramCounter PC (Address, PCenable, clk, PCout);
	AddressLogic AL (PCout, Address, ResetPC, PCplusI, PCplus1, RplusI, Rplus0);

endmodule