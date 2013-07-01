// Carlos Lazo
// ECE579D
// Homework 04

#include "ShiftRegHuff.h"

// Define the ShiftRegHuff constructor

ShiftRegHuff::ShiftRegHuff()
{
  for (int i = 0; i < 8; i++)
  { din[i] = 'X'; pout[i] = 'X'; dTemp[i].put('X',0,0); }
  
  // Note that DFF's have Q = 'X' by default, as per that specific constructor
  din[8] = '\0'; pout[8] = '\0'; dTemp[8].put('\0',0,0);
  clk = 'X'; rst = 'X'; m1 = 'X'; sri = 'X'; sli = 'X';

  t_Delay = 0; t_Power = 0;
}

// Define the ShiftRegHuff load_input function

void ShiftRegHuff::load_input(string indata)
{
  in_str = indata;

  // The input stream from the text file is as follows:
  // m1 m0 | sri | srl | din | rst | clk ==> Information
  //  0 1     2     3    4-11   12    13 ==> String Location

  m1  = indata[0];  m0 = indata[1];
  sri = indata[2]; sli = indata[3];

  for (int i = 4; i < 12; i++)
    din[i-4] = indata[i];       // din[0] = MSB, din[7] = LSB

  // Declare new wire values for rst and clk based on each input

  rst = indata[12]; clk = indata[13];

  w_rst.put(rst,  0,0);
  w_clk.put(clk, 50,0); // Assume a clock delay of 50ns.

  // Store current flip-flop values:

  pr_dff = "";

  for (int i = 0; i < 8; i++)
    pr_dff += pout[i];

  t_Delay = 0;
  t_Power = 0;
}

// Huffamn Model - Combinational Portion of Shift Register

void CombLogic::update_reg(ShiftRegHuff& out)
{
  char wv; int wd, wp;

  // Begin analyzing mode logic -

  if ( (out.m1 == '0') && (out.m0 == '0') )
  {
    // Mode 0 - Do nothing. Set dTemp values to current DFF values

    for (int i = 0; i < 8; i++)
      out.dTemp[i] = out.reg[i].get_Q();
  }

  if ( (out.m1 == '0') && (out.m0 == '1') )
  {
    // Mode 1 - Right Shift

    for (int i = 0; i < 7; i++){
      out.reg[i].get_Q().get(wv,wd,wp);
      out.dTemp[i+1].put(wv,wd,wp); }   // Shift all elements to the right

    out.dTemp[0].put(out.sri,0,0);          // Set MSB to the sli input
  }

  if ( (out.m1 == '1') && (out.m0 == '0') )
  {
    // Mode 2 - Left Shift

    for (int i = 0; i < 7; i++){
      out.reg[i+1].get_Q().get(wv,wd,wp);
      out.dTemp[i].put(wv,wd,wp); }     // Shift all elements to the left

    out.dTemp[7].put(out.sli,0,0);          // Set LSB to the sli input
  }

  if ( (out.m1 == '1') && (out.m0 == '1') )
  {
    // Mode 3 - Parallel Load

    for (int i = 0; i < 8; i++)
      out.dTemp[i].put(out.din[i],0,1);       // Set elements to load input
  }

  out.t_Delay = 70; // Back annotate worst case timing delay
  out.t_Power = 16; // Back annotate worst case power consumption
}

void ShiftRegHuff::set_output()
{
  // Set all DFF - this is dependant on clock and reset values.
  // Utilize values determined in the update_reg() function.

  for (int i = 0; i < 8; i++)
    reg[i].DFF(dTemp[i], w_clk, w_rst); // Update all DFFs

  char tv; int td,tp;

  for (int i = 0; i < 8; i++)
  {
    reg[i].get_Q().get(tv,td,tp);
    pout[i] = tv                ;       // Set parallel output to DFF Q values
  }
}

string ShiftRegHuff::output_reg()
{
  string pretty_print;

  pretty_print += "Current ShiftRegHuff contains the following values: ";

  for (int i = 0; i < 8; i++)
    pretty_print += pr_dff[i];

  pretty_print += "\n";

  pretty_print += "Input = " + in_str.substr(4,8) + ", Mode = " + in_str.substr(0,2);

  pretty_print += ", Clk = "; pretty_print += in_str[13];
  pretty_print += ", Rst = "; pretty_print += in_str[12];
  pretty_print += ", sri = "; pretty_print +=  in_str[2];
  pretty_print += ", sli = "; pretty_print +=  in_str[3];

  pretty_print += "\n\t";

  pretty_print += "After operation, ShiftRegHuff now contains:   ";

  for (int i = 0; i < 8; i++)
    pretty_print += pout[i];

  pretty_print += "\n\t";

  char bufD[32], bufP[32];

  pretty_print += "Total time delay = ";          pretty_print += _itoa(t_Delay,bufD,10);
  pretty_print += ", Total Power Consumption = "; pretty_print += _itoa(t_Power,bufP,10);

  pretty_print += "\n\n";

  return pretty_print;
}