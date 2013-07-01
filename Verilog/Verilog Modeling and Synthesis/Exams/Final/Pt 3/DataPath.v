// Carlos Lazo
// ECE574
// Test 2

// FIR Filter - DataPath Implementation

`timescale 1ns/100ps

// Simplify based on diagram.

module DataPath (
	clk, Databus, Addressbus, 
    ResetPC, PCplusI, PCplus1, RplusI, Rplus0,
    AaddB, AmulB, IRload, Address_on_Databus, ALU_on_Databus,
    Cset, Creset, Zset, Zreset, Shadow, 
    Instruction, Cout, Zout
);
input clk;
inout [15:0] Databus;
output [15:0] Addressbus;
input 
	ResetPC, PCplusI, PCplus1, RplusI, Rplus0,
	AaddB, AmulB, IRload, Address_on_Databus, ALU_on_Databus,
	Cset, Creset, Zset, Zreset, Shadow;
output [15:0] Instruction;
output Cout, Zout;

wire [15:0] Right, Left, ALUout, IRout, Address;
wire SRCin, SRZin, SRZout, SRCout;  
wire 
	ResetPC, PCplusI, PCplus1, RplusI, Rplus0,
	AaddB, AmulB, IRload, 
	Address_on_Databus, ALU_on_Databus,
	Cset, Creset, Zset, Zreset, Shadow;
wire [1:0] Laddr, Raddr;

	AddressingUnit AU (IRout[7:0], Address, clk, ResetPC, PCplusI, PCplus1, RplusI, Rplus0);
	
	ArithmeticUnit AL (
		Left, AaddB, AmulB,
		ALUout, SRCout, SRZin, SRCin
	);

	RegisterFile RF (
		Databus, clk, Left, Right
	);

	InstrunctionRegister IR (Databus, IRload, clk, IRout);

	StatusRegister SR (SRCin, SRZin, SRload, clk, Cset, Creset, Zset, Zreset, SRCout, SRZout);

	assign Addressbus = Address;
	
	assign Databus = 
		(Address_on_Databus) ? Address : (ALU_on_Databus) ? ALUout : 16'bZZZZZZZZZZZZZZZZ;

	assign Zout = SRZout;

	assign Cout = SRCout;

	assign Instruction = IRout[15:0];

endmodule