// Carlos Lazo
// ECE574
// Test 2

// FIR Filter - RegisterFile Implementation

`timescale 1ns/100ps

module RegisterFile (in, clk, Addr, Lout, Rout);

input [15:0] in, Addr;      // 16-bit address and instruction

output [15:0] Lout, Rout;

// Set the register value to be dynamic, based on
// the number of filter coefficients we're expecting.

parameter Filt_Length = 8;
reg [15:0] MemoryFile [0:Filt_Length - 1];


assign Lout = MemoryFile [Laddress];
assign Rout = MemoryFile [Raddress];

reg [15:0] TempReg;

	always @(negedge clk) begin
	    TempReg = MemoryFile [Laddress];
		if (RFLwrite) TempReg [7:0] = in [7:0];
		if (RFHwrite) TempReg [15:8] = in [15:8];
		MemoryFile [Laddress] = TempReg;
	end

endmodule