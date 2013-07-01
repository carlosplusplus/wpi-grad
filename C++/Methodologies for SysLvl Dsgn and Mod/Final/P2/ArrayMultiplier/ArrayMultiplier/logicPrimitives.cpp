// Carlos Lazo
// ECE579D
// Final Exam - Problem 2

#include "logicPrimitives.h"

// Define the AND function

void and::AND(wire i1, wire i2, wire &o1)
{
  char av, bv, wv;
  int  ad, bd, wd;

  i1.get(av, ad);
  i2.get(bv, bd);

  // Perform gate level operations.

  if ((av == '0') || (bv == '0'))
  {
    wv = '0';

    // Output delay = Max(i1 delay, i2 delay) + gate delay

    wd = this->gateDelay + MAX2(ad,bd);
  }

  else
  {
    wv = '1';

    // Output delay = Max(i1 delay, i2 delay) + gate delay

    wd = this->gateDelay + MAX2(ad,bd);
  }

  o1.put(wv,wd);  
}

  /*

  Test for AND Gate in Main Program:

  wire w_t1('1',3); wire w_t2('1',2); wire w_o;
  and g_t;

  g_t.AND(w_t1,w_t2,w_o);

  cout << "Output value = " << w_o.getVal() << ", and Delay = " << w_o.delayValue() << endl << endl;

  */

// Define the OR function

void or::OR(wire i1, wire i2, wire i3, wire& o1)
{
  char av, bv, cv, wv;
  int  ad, bd, cd, wd;

  i1.get(av, ad);
  i2.get(bv, bd);
  i3.get(cv, cd);

  if ((av == '1')||(bv == '1')||(cv == '1'))
  {
    wv = '1'; // Value = 1

    // Output delay = Max(i1 delay, i2 delay, i3 delay) + gate delay

    wd = MAX2(ad,bd);
    wd = this->gateDelay + MAX2(wd,cd);
  }

  else
  {
    wv = '0'; // Value = 0

    // Output delay = Max(i1 delay, i2 delay, i3 delay) + gate delay

    wd = MAX2(ad,bd);
    wd = this->gateDelay + MAX2(wd,cd);

  }

  o1.put(wv, wd); // Place calculated value on output wire
}

/*

  Test for OR Gate in Main Program:

  wire w_t1('0',1); wire w_t2('0',2); wire w_t3('0',8); wire w_o;
  or g_t;

  g_t.OR(w_t1,w_t2,w_t3,w_o);

  cout << "Output value = " << w_o.getVal() << ", and Delay = " << w_o.delayValue() << endl << endl;

*/

// Define the XOR function

void xor::XOR(wire i1, wire i2, wire &o1)
{
  char av, bv, wv;
  int  ad, bd, wd;

  i1.get(av, ad);
  i2.get(bv, bd);

  // Perform gate level operations.

  if (((av == '0') && (bv == '0')) || ((av == '1') && (bv == '1')))
  {
    wv = '0';

    // Output gate delay should be worst case from either gate.

    wd = this->gateDelay + MAX2(ad,bd);

  }

  else
  {
    wv = '1';

    // Output delay = Max(i1 delay, i2 delay) + gate delay

    wd = this->gateDelay + MAX2(ad,bd);
  }

  o1.put(wv,wd);
}

/*

  Test for XOR Gate in Main Program:

  wire w_t1('0',5); wire w_t2('1',3); wire w_o;
  xor g_t;

  g_t.XOR(w_t1,w_t2,w_o);

  cout << "Output value = " << w_o.getVal() << ", and Delay = " << w_o.delayValue() << endl << endl;

*/

// Define the gate level logic for the Multiplier Cell

void multcell::perform_mult(wire xi, wire yi, wire ci, wire pi, wire &co, wire &po)
{
  
  // Define all necessary wires for this operation:

  wire w_A1, w_A2, w_A3, w_A4;  // Wires for AND gate outputs.
  wire w_X1;                    // Wires for XOR gate outputs.

  // Define all necessary gates for this operation:

  and g_A1, g_A2, g_A3, g_A4;   // AND gates.
  or  g_O1;                     // OR  gate.
  xor g_X1, g_X2;               // XOR gate.

  // Perform all associated logic and connections with multiplier cell:

  g_A1.AND(xi,yi,w_A1);
  g_A2.AND(pi,w_A1,w_A2);
  g_A3.AND(w_A1,ci,w_A3);
  g_A4.AND(ci,pi,w_A4);
  g_O1.OR(w_A2,w_A3,w_A4,co);
  g_X1.XOR(pi,w_A1,w_X1);
  g_X2.XOR(w_X1,ci,po);
}

/*

  Test for MultCell logic in Main Program:

  wire xi ('1',3);
  wire yi ('1',1);
  wire ci ('0',1);
  wire pi ('0',1);
  
  wire co; wire po;

  multcell MC1;

  MC1.perform_mult(xi,yi,ci,pi,co,po);

  cout << "po = " << po.getVal() << ", with delay = " << po.delayValue() << endl;
  cout << "co = " << co.getVal() << ", with delay = " << co.delayValue() << endl;

*/

