// Carlos Lazo
// ECE579D
// Midterm Exam - Part A

#include "comparator.h"

// Declare wires of Logic 0 and Logic 1 for later use

wire LOGIC_0 ('0', WIRE_DELAY);
wire LOGIC_1 ('1', WIRE_DELAY);

// Empty default constructor

comp_elem::comp_elem() {}

// Define function comp_elem, which will perform NAND gate logic

void comp_elem :: proc(wire a, wire b, wire e, wire g, wire& E, wire& G)
{

  // Place all values from incoming wires into comparator memory -

  ai.put(a.getVal(), a.delayValue()); bi.put(b.getVal(), b.delayValue());
  eq.put(e.getVal(), e.delayValue()); gt.put(g.getVal(), g.delayValue());

  // Stage 1 of Logic -
  
  nand s1_1 , s1_2 ;
  wire s1_o1, s1_o2;

  s1_1.NAND(ai, ai, s1_o1);
  s1_2.NAND(bi, bi, s1_o2);

  // Stage 2 of Logic -

  nand s2_1 , s2_2 ;
  wire s2_o1, s2_o2;

  s2_1.NAND(bi, s1_o1, s2_o1);
  s2_2.NAND(ai, s1_o2, s2_o2);

  // Stage 3 of Logic -

  nand s3_1 , s3_2 ;
  wire s3_o1, s3_o2;

  s3_1.NAND(s2_o1, s2_o2, s3_o1);
  s3_2.NAND(s2_o2, s2_o2, s3_o2);

  // Stage 4 of Logic -

  nand s4_1;
  wire s4_o1;

  s4_1.NAND(s3_o1, s3_o1, s4_o1);

  // Stage 5 of Logic -

  nand s5_1 , s5_2 , s5_3 ;
  wire s5_o1, s5_o2, s5_o3;

  s5_1.NAND(eq, s4_o1, s5_o1);
  s5_2.NAND(gt, gt, s5_o2);
  s5_3.NAND(s3_o2, s3_o2, s5_o3);

  // Stage 6 of Logic -

  nand s6_1 , s6_2 ;
  wire s6_o1, s6_o2;

  s6_1.NAND(s5_o1, s5_o1, E);
  s6_2.NAND(s5_o2, s5_o3, G);

  // Set internal variables to final output as well:

  EQ.put(E.getVal(), E.delayValue());
  GT.put(G.getVal(), G.delayValue());
}

// Empty default constructor

comp_8bit::comp_8bit() {}

// This function will be used to initialize all ai and bi values of the comparator.
// It is important to note that ai[0] is the MSB and ai[7] is the LSB.

void comp_8bit::load_in (string astr, string bstr)
{
  for (int i = 0; i < 8; i++)
  {
    a[i].put(astr[i], WIRE_DELAY);
    b[i].put(bstr[i], WIRE_DELAY);
  }

  a_s = astr; b_s = bstr;
}

// Create the logic for the 8bit comparator.

void comp_8bit::output()
{

  // Using a for-loop, cascade all 1-bit comparators with one-another.
  // Note that for the 1st comparator, we use predetermined values for eq & gt.

  int flag = 1;
  int comp_num = 8;
  
  for (int i = 0; i < 8; i++)
  {
    if (i == 0)
      c_array[0].proc (a[0], b[0], LOGIC_1, LOGIC_0, e[0], g[0]);
    else
      c_array[i].proc(a[i], b[i], e[i-1], g[i-1], e[i], g[i]);
  
    // Extra information regarding in which comparator EQ and GT were "really" determined:

    if ((e[i].getVal() == '0' || g[i].getVal() == '1') && (flag == 1))
    {
      comp_num = i + 1;
      flag = 0;
    }
  }

  cout << "The 8-bit value for A = " << a_s << endl;
  cout << "The 8-bit value for B = " << b_s << endl;

  cout << "\tIt was determined that GT = " << g[7].getVal()
       << " : Delay Time = " << g[7].delayValue() << endl;
  cout << "\tIt was determined that EQ = " << e[7].getVal()
       << " : Delay Time = " << e[7].delayValue() << endl;

  cout << "\t\tEQ and GT were determined at 1 bit comparator #" << comp_num << endl << endl;

}