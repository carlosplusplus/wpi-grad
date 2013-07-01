// Carlos Lazo
// ECE579D
// Midterm Exam - Part B

#include "updownCounter.h"

// Create main testbench for the updownCounter:

int main ()
{
  string inVec;
  
  updownCounter UUT;

  ifstream finp ("indata.tst");
  ofstream fout ("outdata.tst");

  char stop_in ('0');

  finp >> inVec;              // Read in first line of testbench data

  while (stop_in != '.')
  {
    UUT.load_input(inVec);    // Load inputs into ShiftRegister
    UUT.update_reg();         // Compute operation based on mode
    UUT.set_output();         // Set DFFs based on computed values

    fout << UUT.output_reg(); // Output data to external file

    // Gather next data input:

    finp >> inVec;
    stop_in = inVec[0];
  }

  fout << "END FILESTREAM";
  return 0;
}