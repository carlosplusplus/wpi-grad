// Carlos Lazo
// ECE574
// Test 2

// FIR Filter - ArithmeticUnit Implementation

`timescale 1ns/100ps

// Only need 2 ALU functions.

`define AaddBH  2'b01
`define AmulBH  2'b10

module ArithmeticUnit (
	A, B, AaddB, AmulB,
);
input [15:0] A, B;
input AaddB, AmulB;
input cin;
output [15:0] aluout;
output zout, cout;
reg [15:0] aluout;
reg zout, cout;

// Modify the procedural statement so that it only uses Add & Multiply.

	always @(
		A or B or AaddB or AmulB or cin
	) 
	begin
		zout = 0; cout = 0; aluout = 0;
		case ({AaddB, AmulB})
			`AaddBH: {cout, aluout} = A + B + cin;
			`AmulBH:  aluout = A[7:0] * B[7:0];
			default: aluout = 0;
		endcase
		if (aluout == 0) zout = 1'b1;
    end
endmodule