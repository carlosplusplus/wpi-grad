// Carlos Lazo
// ECE579D
// Homework 04

// Now including both testbenches

#include "ShiftRegister.h"
#include "ShiftRegHuff.h"

// Create main testbench for the ShiftRegister:

int main ()
{
  string inVec1, inVec2;
  
  ShiftRegister UUT1;
  ShiftRegHuff  UUT2;

  ifstream finp1 ("indata1.tst");
  ofstream fout1 ("outdata1.tst");

  ifstream finp2 ("indata2.tst");
  ofstream fout2 ("outdata2.tst");

  char stop_in1 ('0');
  char stop_in2 ('0');

  finp1 >> inVec1;              // Read in first line of testbench data

  while (stop_in1 != '.')
  {
    UUT1.load_input(inVec1);    // Load inputs into ShiftRegister
    UUT1.update_reg();         // Compute operation based on mode
    UUT1.set_output();         // Set DFFs based on computed values

    fout1 << UUT1.output_reg(); // Output data to external file

    // Gather next data input:

    finp1 >> inVec1;
    stop_in1 = inVec1[0];
  }

  fout1 << "END FILESTREAM";

  /// Now for the Huffman Model (with templated delays):

  finp2 >> inVec2;              // Read in first line of testbench data

  CombLogic<int> CL (13,37);    // Define TEMPLATED combinational logic class

  while (stop_in2 != '.')
  {
    UUT2.load_input(inVec2);     // Load inputs into ShiftRegister

    CL.update_reg(UUT2);

    UUT2.set_output();           // Set DFFs based on computed values

    fout2 << UUT2.output_reg(); // Output data to external file

    // Gather next data input:

    finp2 >> inVec2;
    stop_in2 = inVec2[0];
  }

  return 0;
}