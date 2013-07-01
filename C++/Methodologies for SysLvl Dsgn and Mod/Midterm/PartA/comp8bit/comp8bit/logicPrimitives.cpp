// Carlos Lazo
// ECE579D
// Midterm Exam - Part A

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

  else
    wv =    '1'; // Value = 1

  // Setup gate delay based on largest total delay seen.
  // Be sure to add in both the gate delay and wire delay

  wd = this->delayValue() + WIRE_DELAY + MAX2(ad, bd);

  o1.put(wv, wd); // Place calculated value on output wire
}