// Carlos Lazo
// ECE579D
// Homework 04

#include "ShiftRegister.h"

// Define the ShiftRegister constructor

ShiftRegister::ShiftRegister()
{
  for (int i = 0; i < 8; i++)
  { din[i] = 'X'; pout[i] = 'X'; dTemp[i].put('X',0,0); }
  
  // Note that DFF's have Q = 'X' by default, as per that specific constructor
  din[8] = '\0'; pout[8] = '\0'; dTemp[8].put('\0',0,0);
  clk = 'X'; rst = 'X'; m1 = 'X'; sri = 'X'; sli = 'X';

  t_Delay = 0; t_Power = 0;
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

// GATE LEVEL Implementation of Shift Register

void ShiftRegister::update_reg()
{

  // Declare all necessary wires.

  wire w_sr, w_sl, w_m1, w_m0, w_din;

  w_sr.put(sri,0,0); w_sl.put(sli,0,0);
  w_m1.put( m1,0,0); w_m0.put( m0,0,0);

  // Declare NOT wires of input signals m1 and m0.

  wire w_m1N; not n1; n1.NOT(w_m1, w_m1N);
  wire w_m0N; not n0; n0.NOT(w_m0, w_m0N);

  // Declare all necessary gates and wires for mode calculation.

  and dn_gate, rs_gate, ls_gate, ld_gate;
  or  in_DFF;

  wire w_dnO, w_rsO, w_lsO, w_ldO, w_inDFF;

  char wv; int wd, wp;
  
  // Perform shift-register operations based on mode inputs.

  for (int i = 0; i < 8; i++)
  {
    w_din.put(din[i],0,1);        // Assume inputs count towards power consumption

    // If mode = {0,0}, do nothing.

    dn_gate.AND(reg[i].get_Q(), w_m1N, w_m0N, w_dnO);

    // If mode = {0,1}, shift right.
    // If at the 1st shift register, rs_gate takes in sri.
    // If not, then it takes the Q value from the previous shift register.

    if (i == 0) 
      rs_gate.AND(w_sr, w_m1N, w_m0, w_rsO);
    else
      rs_gate.AND(reg[i-1].get_Q(), w_m1N, w_m0, w_rsO);

    // If mode = {1,0}, shift left.
    // If at the last shift register, ls_gate takes in sli.
    // If not, then it takes the Q value from the next shift register.

    if (i == 7)
      ls_gate.AND(w_sl, w_m1, w_m0N, w_lsO);
    else
      ls_gate.AND(reg[i+1].get_Q(), w_m1, w_m0N, w_lsO);

    // If mode = {1,1}, parallel load.

    ld_gate.AND(w_din, w_m1, w_m0, w_ldO);

    // Now that all computations are done, the OR of these gates will go into dTemp[i].

    in_DFF.OR(w_dnO, w_rsO, w_lsO, w_ldO, w_inDFF);

    w_inDFF .get(wv, wd, wp);
    dTemp[i].put(wv, wd, wp);

    // Update current operation's delay and power consumption:

    t_Delay += wd;
    t_Power += wp;

    /*//Debug code:
    cout << "DEBUG: w_dnO = " << w_dnO.getVal() << " , w_rsO = " << w_rsO.getVal() << " ,";
    cout << "w_lsO = " << w_lsO.getVal() << " , w_ldO = " << w_ldO.getVal();
    cout << " ::: w_inDFF = " << w_inDFF.getVal() << endl;
    cout << "\twv = " << wv << " , wd = " << wd << " , wp = " << wp << ", t_Delay = " << t_Delay;
    cout << ", t_Power = " << t_Power << endl << endl;*/
    
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
    reg[i].DFF(dTemp[i], w_clk, w_rst); // Update all DFFs

  char tv; int td,tp;

  for (int i = 0; i < 8; i++)
  {
    reg[i].get_Q().get(tv,td,tp);
    pout[i] = tv                ;       // Set parallel output to DFF Q values
  }
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

  pretty_print += "After operation, ShiftRegister now contains:   ";

  for (int i = 0; i < 8; i++)
    pretty_print += pout[i];

  pretty_print += "\n\t";

  char bufD[32], bufP[32];

  pretty_print += "Total time delay = ";          pretty_print += _itoa(t_Delay,bufD,10);
  pretty_print += ", Total Power Consumption = "; pretty_print += _itoa(t_Power,bufP,10);

  pretty_print += "\n\n";

  return pretty_print;
}