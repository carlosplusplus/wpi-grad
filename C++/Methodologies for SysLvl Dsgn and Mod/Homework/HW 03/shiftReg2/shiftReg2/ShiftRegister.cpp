// Carlos Lazo
// ECE579D
// Homework 03

#include "ShiftRegister.h"

// Define the AND gate evaluation function

void and::evl()
{
  if ((i1=='0')||(i2=='0')||(i3=='0'))
    o1 = '0';
  else if ((i1=='1')&&(i2=='1')&&(i3=='1'))
    o1 = '1';
  else
    o1 = 'X';
}

// Define the OR gate evaluation function

void or::evl()
{
  if ((i1=='1')||(i2=='1')||(i3=='1')||(i4=='1'))
    o1 = '1';
  else if ((i1=='0')&&(i2=='0')&&(i3=='0')&&(i4=='0'))
    o1 = '0';
  else
    o1 = 'X';
}

// Define the NOT gate evaluation function

void not::evl()
{
  if (i1 == '0')
    o1 = '1';
  else if (i1 == '1')
    o1 = '0';
  else
    o1 = 'X';
}

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

// GATE LEVEL Implementation of Shift Register

void ShiftRegister::update_reg()
{
  // Establish all necessary signals.

  not m1_n; m1_n.inp(m1) ; m1_n.evl();
  not m0_n; m0_n.inp(m0) ; m0_n.evl();

  // Perform shift-register operations based on mode inputs.

  and dn_gate, rs_gate, ls_gate, ld_gate;
  or  in_DFF;

  for (int i = 0; i < 8; i++)
  {
    // If mode = {0,0}, do nothing.

    dn_gate.inp(reg[i].get_Q(), m1_n.getV(), m0_n.getV());
    dn_gate.evl();

    // If mode = {0,1}, shift right.
    // If at the 1st shift register, rs_gate takes in sri.
    // If not, then it takes the Q value from the previous shift register.

    if (i == 0)
      rs_gate.inp(sri, m1_n.getV(), m0);
    else
      rs_gate.inp(reg[i-1].get_Q(), m1_n.getV(), m0);

    rs_gate.evl();

    // If mode = {1,0}, shift left.
    // If at the last shift register, ls_gate takes in sli.
    // If not, then it takes the Q value from the next shift register.

    if (i == 7)
      ls_gate.inp(sli, m1, m0_n.getV());
    else
      ls_gate.inp(reg[i+1].get_Q(), m1, m0_n.getV());

    ls_gate.evl();

    // If mode = {1,1}, parallel load.

    ld_gate.inp(din[i], m1, m0);
    ld_gate.evl();

    // Now that all computations are done, the OR of these gates will go into dTemp[i].

    in_DFF.inp(dn_gate.getV(), rs_gate.getV(), ls_gate.getV(), ld_gate.getV());
    in_DFF.evl();
    in_DFF.out(dTemp[i]);
  }
}

/* FUNCTIONAL Implementation of Shift Register

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

*/

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