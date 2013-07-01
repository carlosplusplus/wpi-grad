// Carlos Lazo
// ECE579D
// Homework 04

#include "logicPrimitives.h"

// Define the AND function

void and::AND(wire i1, wire i2, wire i3, wire& o1)
{
  char av, bv, cv, wv;
  int  ad, bd, cd, wd;
  int  ap, bp, cp, wp;

  i1.get(av, ad, ap);
  i2.get(bv, bd, bp);
  i3.get(cv, cd, cp);

  if ((av == '0')||(bv == '0')||(cv == '0'))
  {
    wv =    '0'; // Value = 0

    // Setup gate delay and pwr based on which input is '0' first

    if (av == '0') {
      wd = ad + this->gateDelay; wp = ap + 1; }
    else if (bv == '0') {
      wd = bd + this->gateDelay; wp = bp + 1; }
    else {
      wd = cd + this->gateDelay; wp = cp + 1; }
  }

  else if ((av == '1')&&(bv == '1')&&(cv == '1'))
  {
    wv =    '1'; // Value = 1

    // When all gates are = 1, calculate 'worst case' pwr and delays

    wp = MAX3(ap,bp,cp) + 1; 
    wd = this->gateDelay + MAX3(ad,bd,cd);
  }

  else
  {
    wv =    'X'; // Value = X
    
    // Setup gate delay and pwr based on which input is '0' first

    if (av != '1') {
      wd = ad + this->gateDelay; wp = ap + 1; }
    else if (bv != '1') {
      wd = bd + this->gateDelay; wp = bp + 1; }
    else {
      wd = cd + this->gateDelay; wp = cp + 1; }
  }

  o1.put(wv, wd, wp); // Place calculated value on output wire
}

// Define the OR function

void or::OR(wire i1, wire i2, wire i3, wire i4, wire& o1)
{
  char av, bv, cv, dv, wv;
  int  ad, bd, cd, dd, wd;
  int  ap, bp, cp, dp, wp;

  i1.get(av, ad, ap);
  i2.get(bv, bd, bp);
  i3.get(cv, cd, cp);
  i4.get(dv, dd, dp);

  if ((av == '1')||(bv == '1')||(cv == '1')||(dv == '1'))
  {
    wv =    '1'; // Value = 1

    // Setup gate delay and pwr based on which input is '1' first

    if (av == '1') {
      wd = ad + this->gateDelay; wp = ap + 1; }
    else if (bv == '1') {
      wd = bd + this->gateDelay; wp = bp + 1; }
    else if (cv == '1') {
      wd = cd + this->gateDelay; wp = cp + 1; }
    else {
      wd = dd + this->gateDelay; wp = dp + 1; }
  }

  else if ((av == '0')&&(bv == '0')&&(cv == '0')&&(dv == '0'))
  {
    wv =    '0'; // Value = 0

    // When all gates are = 1, calculate 'worst case' pwr and delays

    wp = MAX3(ap,bp,cp); wp = MAX2(wp, dp);
    wd = MAX3(ad,bd,cd); wd = this->gateDelay + MAX2(wd, dd);
  }

  else
  {
    wv =    'X'; // Value = X
    
    // Setup gate delay and pwr based on which input is '0' first

    if (av != '0') {
      wd = ad + this->gateDelay; wp = ap + 1; }
    else if (bv != '0') {
      wd = bd + this->gateDelay; wp = bp + 1; }
    else if (cv != '0') {
      wd = cd + this->gateDelay; wp = cp + 1; }
    else {
      wd = dd + this->gateDelay; wp = dp + 1; }
  }

  o1.put(wv, wd, wp); // Place calculated value on output wire
}

// Define the NOT function

void not::NOT(wire i1, wire& o1)
{
  char av, wv;
  int  ad, wd;
  int  ap, wp;

  i1.get(av,ad,ap);

  if      (av == '1') wv = '0';
  else if (av == '0') wv = '1';
  else                wv = 'X';

  wd = ad + this->gateDelay;
  wp = ap + 1;

  o1.put(wv,wd,wp);

}

// Define the DFF function

void dff::DFF(wire D, wire C, wire R)
{

  char Dv, Cv, Rv, Qv;
  int  Dd, Cd, Rd, Qd;
  int  Dp, Cp, Rp, Qp;

  D.get(Dv, Dd, Dp);
  C.get(Cv, Cd, Cp);
  R.get(Rv, Rd, Rp);

  if (Rv == '1') {
    Qv = '0'; Qd = 0; Qp = 0;
  }

  else if (Cv == 'P') {
    if (Cd >= Dd) Qv = Dv;
    else Qv = 'X';

    Qd = this->clkQDelay;
    Qp = 1;
  }

  // Catch-all statement, leave Q as it is (e.g. clk = 'N')

  else
    this->Q.get(Qv, Qd, Qp);

  this->Q.put(Qv, Qd, Qp);
}