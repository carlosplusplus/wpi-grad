// Carlos Lazo
// ECE579D
// Homework 03

#include "ShiftRegister.h"

// Define the D-Flip Flop constructor

DFF::DFF() {Q = 'X';}

// Define the D-FLIP Flop set function

void DFF::set(char D, char clk, char rst)
{
  if (rst == '1')
    Q = '0';
  else if (clk == 'P')
    Q = D;
}

// Define the ShiftRegister constructor

ShiftRegister::ShiftRegister()
{
  for (int i = 0; i < 8; i++)
  { din[i] = 'X'; pout[i] = 'X'; dTemp[i] = 'X'; }
  
  // Note that DFF's have Q = 'X' by default, as per that specific constructor
  din[8] = '\0'; pout[8] = '\0'; dTemp [8] = '\0';
  clk = 'X'; rst = 'X'; m1 = 'X'; sri = 'X'; sli = 'X';
}

// Define the ShiftRegister load_input function

void ShiftRegister::load_input(string indata)
{
  in_str = indata;

  // The input stream from the text file is as follows:
  // m1 m0 | sri | srl | din | rst | clk ==> Information
  //  0 1     2     3    4-11   12    13 ==> String Location

  m1  = indata[0];  m0 = indata[1];
  sri = indata[2]; sli = indata[3];

  for (int i = 4; i < 12; i++)
    din[i-4] = indata[i];       // din[0] = MSB, din[7] = LSB

  rst = indata[12]; clk = indata[13];

  // Store current flip-flop values:

  pr_dff = "";

  for (int i = 0; i < 8; i++)
    pr_dff += pout[i];
}

void ShiftRegister::update_reg()
{
  // Begin analyzing mode logic -

  if ( (m1 == '0') && (m0 == '0') )
  {
    // Mode 0 - Do nothing. Set dTemp values to current DFF values

    for (int i = 0; i < 8; i++)
      dTemp[i] = reg[i].get_Q();
  }

  if ( (m1 == '0') && (m0 == '1') )
  {
    // Mode 1 - Right Shift

    for (int i = 0; i < 7; i++)
      dTemp[i+1] = reg[i].get_Q();  // Shift all elements to the right

    dTemp[0] = sri;                 // Set MSB to the sri input
  }

  if ( (m1 == '1') && (m0 == '0') )
  {
    // Mode 2 - Left Shift

    for (int i = 0; i < 7; i++)
      dTemp[i] = reg[i+1].get_Q();  // Shift all elements to the left

    dTemp[7] = sli;                 // Set LSB to the sli input
  }

  if ( (m1 == '1') && (m0 == '1') )
  {
    // Mode 3 - Parallel Load

    for (int i = 0; i < 8; i++)
      dTemp[i] = din[i];            // Set elements to load input
  }
}

void ShiftRegister::set_output()
{
  // Set all DFF - this is dependant on clock and reset values.
  // Utilize values determined in the update_reg() function.

  for (int i = 0; i < 8; i++)
    reg[i].set(dTemp[i], clk, rst);     // Update all DFFs

  for (int i = 0; i < 8; i++)
    pout[i] = reg[i].get_Q();           // Set parallel output to DFF Q values
}

string ShiftRegister::output_reg()
{
  string pretty_print;

  pretty_print += "Current ShiftRegister contains the following values: ";

  for (int i = 0; i < 8; i++)
    pretty_print += pr_dff[i];

  pretty_print += "\n";

  pretty_print += "Input = " + in_str.substr(4,8) + ", Mode = " + in_str.substr(0,2);

  pretty_print += ", Clk = "; pretty_print += in_str[13];
  pretty_print += ", Rst = "; pretty_print += in_str[12];
  pretty_print += ", sri = "; pretty_print +=  in_str[2];
  pretty_print += ", sli = "; pretty_print +=  in_str[3];

  pretty_print += "\n\t";

  pretty_print += "After operation, ShiftRegister now contains: ";

  for (int i = 0; i < 8; i++)
    pretty_print += pout[i];

  pretty_print += "\n\n";

  return pretty_print;
}