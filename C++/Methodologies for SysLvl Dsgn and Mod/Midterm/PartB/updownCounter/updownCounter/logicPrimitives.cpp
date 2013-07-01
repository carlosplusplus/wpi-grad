// Carlos Lazo
// ECE579D
// Midterm Exam - Part B

#include "logicPrimitives.h"

// Define the NAND function

void nand::NAND(wire i1, wire i2, wire& o1)
{
  char av, bv, wv;
  int  ad, bd, wd;

  i1.get(av, ad);
  i2.get(bv, bd);

  // Apply all logic possibilities of NAND

  if ((av == '1') && (bv == '1'))
    wv =    '0'; // Value = 0

  else if ((av == 'X') || (bv == 'X'))
    wv =    'X'; // Value = X

  else
    wv =    '1'; // Value = 1

  // Setup gate delay based on largest total delay seen.
  // Be sure to add in both the gate delay and wire delay

  wd = this->delayValue() + WIRE_DELAY + MAX2(ad, bd);

  o1.put(wv, wd); // Place calculated value on output wire
}

// Define the DFF function

void dff::DFF(wire D, wire C, wire R)
{

  char Dv, Cv, Rv, Qv;
  int  Dd, Cd, Rd, Qd;

  D.get(Dv, Dd);
  C.get(Cv, Cd);
  R.get(Rv, Rd);

  if (Rv == '1') {
    Qv = '0'; Qd = 0;
  }

  else if (Cv == 'P') {
    if (Cd >= Dd) Qv = Dv;
    else Qv = 'X';

    Qd = this->clkQDelay;
  }

  // Catch-all statement, leave Q as it is (e.g. clk = 'N')

  else
    this->Q.get(Qv, Qd);

  this->Q.put(Qv, Qd);
}