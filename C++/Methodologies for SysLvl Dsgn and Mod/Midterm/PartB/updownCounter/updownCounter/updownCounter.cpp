// Carlos Lazo
// ECE579D
// Midterm Exam - Part B

#include "updownCounter.h"

// Define the updownCounter constructor

updownCounter::updownCounter()
{
  for (int i = 0; i < 3; i++)
  {
    dTemp[i].put('X',WIRE_DELAY);
    qout[i] = 'X';
  }

  c_clk = 'X'; c_rst = 'X'; c_ud = 'X';
  t_Delay = 0;

}

// Define the updownCounter load_input function

void updownCounter::load_input(string indata)
{
  in_str = indata;

  // The input stream from the text file is as follows:
  // updown | rst | clk ==> Information
  //    0      1     2  ==> Char Location

  c_ud = indata[0]; c_rst = indata[1]; c_clk = indata[2];

  // Set all input wires accordingly:

   ud.put(c_ud,  WIRE_DELAY);
  rst.put(c_rst, WIRE_DELAY);
  clk.put(c_clk, 200);          // 200ns pulse defined for clk

  pr_dff = "";

  // Store current flip-flop values:

  for (int i = 0; i < 3; i++)
    pr_dff += qout[i];

  t_Delay = 0;

}

// GATE LEVEL Implementation of updownCounter

void updownCounter::update_reg()
{
  
  // Begin 1st by defining y signals and their complements:

  wire y2(qout[0], WIRE_DELAY);
  wire y1(qout[1], WIRE_DELAY);
  wire y0(qout[2], WIRE_DELAY);

  nand y2_ng, y1_ng, y0_ng, ud_ng;
  wire y2_n , y1_n , y0_n , ud_n ;

  y2_ng.NAND(y2,y2,y2_n); y1_ng.NAND(y1,y1,y1_n);
  y0_ng.NAND(y0,y0,y0_n); ud_ng.NAND(ud,ud,ud_n);

  // *********************************************************************************
  // * Peform computation for D2 input - use color code from writeup for NAND gates: *
  // *********************************************************************************

    // Blue Expression

    nand  b2_1,  b2_2,  b2_3,  b2_4,  b2_5, b2_6;
    wire b2_o1, b2_o2, b2_o3, b2_o4, b2_o5, d2_b;

    b2_1.NAND(ud_n ,y2_n ,b2_o1); b2_2.NAND(b2_o1,b2_o1,b2_o2);
    b2_3.NAND( y1_n,y0_n ,b2_o3); b2_4.NAND(b2_o3,b2_o3,b2_o4);
    b2_5.NAND(b2_o2,b2_o4,b2_o5); b2_6.NAND(b2_o5,b2_o5, d2_b);

    // Green Expression

    nand  g2_1,  g2_2,  g2_3, g2_4;
    wire g2_o1, g2_o2, g2_o3, d2_g;

    g2_1.NAND(y2   ,y1,g2_o1); g2_2.NAND(g2_o1,g2_o1,g2_o2);
    g2_1.NAND(g2_o2,y0_n,g2_o3); g2_4.NAND(g2_o3,g2_o3, d2_g);

    // Orange Expression

    nand  o2_1,  o2_2,  o2_3, o2_4;
    wire o2_o1, o2_o2, o2_o3, d2_o;

    o2_1.NAND(   ud,  y2,o2_o1); o2_2.NAND(o2_o1,o2_o1,o2_o2);
    o2_3.NAND(o2_o2,y1_n,o2_o3); o2_4.NAND(o2_o3,o2_o3, d2_o);

    // Red Expression

    nand  r2_1,  r2_2,  r2_3, r2_4;
    wire r2_o1, r2_o2, r2_o3, d2_r;

    r2_1.NAND(ud_n ,y2,r2_o1); r2_2.NAND(r2_o1,r2_o1,r2_o2);
    r2_3.NAND(r2_o2,y0,r2_o3); r2_4.NAND(r2_o3,r2_o3,d2_r);

    // Purple Expression

    nand  p2_1,  p2_2,  p2_3,  p2_4,  p2_5, p2_6;
    wire p2_o1, p2_o2, p2_o3, p2_o4, p2_o5, d2_p;

    p2_1.NAND(   ud, y2_n,p2_o1); p2_2.NAND(p2_o1,p2_o1,p2_o2);
    p2_3.NAND(   y1,   y0,p2_o3); p2_4.NAND(p2_o3,p2_o3,p2_o4);
    p2_5.NAND(p2_o2,p2_o4,p2_o5); p2_6.NAND(p2_o5,p2_o5, d2_p);

    // Combine Blue + Green Expressions

    nand  bg2_1,  bg2_2, bg2_3;
    wire bg2_o1, bg2_o2, d2_bg;

    bg2_1.NAND(  d2_b,  d2_b,bg2_o1); bg2_2.NAND(d2_g,d2_g,bg2_o2);
    bg2_3.NAND(bg2_o1,bg2_o2, d2_bg);

    // Combine Orange + Red Expressions

    nand  or2_1,  or2_2, or2_3;
    wire or2_o1, or2_o2, d2_or;

    or2_1.NAND(  d2_o,  d2_o,or2_o1); or2_2.NAND(d2_r,d2_r,or2_o2);
    or2_3.NAND(or2_o1,or2_o2, d2_or);

    // Combine (Blue + Green) + (Orange + Red) Expressions

    nand  bgor2_1,  bgor2_2, bgor2_3;
    wire bgor2_o1, bgor2_o2, d2_bgor;

    bgor2_1.NAND(d2_bg   ,d2_bg   ,bgor2_o1); bgor2_2.NAND(d2_or,d2_or,bgor2_o2);
    bgor2_3.NAND(bgor2_o1,bgor2_o2,d2_bgor );

    // Combine (Blue + Green + Orange + Red) with Purple Expression = D2

    nand  bgorp2_1,  bgorp2_2,  bgorp2_3;
    wire bgorp2_o1, bgorp2_o2;

    bgorp2_1.NAND(d2_bgor,d2_bgor,bgorp2_o1); bgorp2_2.NAND(d2_p,d2_p,bgorp2_o2);
    bgorp2_3.NAND(bgorp2_o1,bgorp2_o2,dTemp[0]);

  // *********************************************************************************
  // * Peform computation for D1 input - use color code from writeup for NAND gates: *
  // *********************************************************************************

    // Blue Expression

    nand  b1_1,  b1_2,  b1_3, b1_4;
    wire b1_o1, b1_o2, b1_o3, d1_b;

    b1_1.NAND(   y1,  y0,b1_o1); b1_2.NAND(b1_o1,b1_o1,b1_o2);
    b1_3.NAND(b1_o2,ud_n,b1_o3); b1_4.NAND(b1_o3,b1_o3, d1_b);

    // Green Expression

    nand  g1_1,  g1_2,  g1_3, g1_4;
    wire g1_o1, g1_o2, g1_o3, d1_g;

    g1_1.NAND(   ud,  y1,g1_o1); g1_2.NAND(g1_o1,g1_o1,g1_o2);
    g1_3.NAND(g1_o2,y0_n,g1_o3); g1_4.NAND(g1_o3,g1_o3, d1_g);
    
    // Orange Expression

    nand  o1_1,  o1_2,  o1_3, o1_4;
    wire o1_o1, o1_o2, o1_o3, d1_o;

    o1_1.NAND( ud_n,y1_n,o1_o1); o1_2.NAND(o1_o1,o1_o1,o1_o2);
    o1_3.NAND(o1_o2,y0_n,o1_o3); o1_4.NAND(o1_o3,o1_o3, d1_o);

    // Red Expression

    nand  r1_1,  r1_2,  r1_3, r1_4;
    wire r1_o1, r1_o2, r1_o3, d1_r;

    r1_1.NAND(   ud,y1_n,r1_o1); r1_2.NAND(r1_o1,r1_o1,r1_o2);
    r1_3.NAND(r1_o2,  y0,r1_o3); r1_4.NAND(r1_o3,r1_o3, d1_r);

    // Combine Blue + Green Expressions

    nand  bg1_1,  bg1_2,  bg1_3;
    wire bg1_o1, bg1_o2, d1_bg;

    bg1_1.NAND(  d1_b,  d1_b,bg1_o1); bg1_2.NAND(d1_g,d1_g,bg1_o2);
    bg1_3.NAND(bg1_o1,bg1_o2, d1_bg);

    // Combine Orange + Red Expressions

    nand  or1_1,  or1_2, or1_3;
    wire or1_o1, or1_o2, d1_or;

    or1_1.NAND(  d1_o,  d1_o,or1_o1); or1_2.NAND(d1_r,d1_r,or1_o2);
    or1_3.NAND(or1_o1,or1_o2, d1_or);

    // Combine (Blue + Green) + (Orange + Red)  = D1

    nand  bgor1_1,  bgor1_2,  bgor1_3;
    wire bgor1_o1, bgor1_o2;

    bgor1_1.NAND(   d1_bg,   d1_bg,bgor1_o1); bgor1_2.NAND(d1_or,d1_or,bgor1_o2);
    bgor1_3.NAND(bgor1_o1,bgor1_o2,dTemp[1]);

  // *********************************************************************************
  // * Peform computation for D0 input - use color code from writeup for NAND gates: *
  // *********************************************************************************

    // Blue Expression

    nand  b0_1, b0_2;
    wire b0_o1, d0_b;

    b0_1.NAND(y1_n,y0_n,b0_o1); b0_2.NAND(b0_o1,b0_o1,d0_b);

    // Green Expression

    nand  g0_1, g0_2;
    wire g0_o1, d0_g;

    g0_1.NAND(y1,y0_n,g0_o1); g0_2.NAND(g0_o1,g0_o1,d0_g);


    // Combine Blue + Green Expressions = D0

    nand  bg0_1,  bg0_2,  bg0_3;
    wire bg0_o1, bg0_o2;

    bg0_1.NAND(  d0_b,  d0_b,bg0_o1); bg0_2.NAND(d0_g,d0_g,bg0_o2);
    bg0_3.NAND(bg0_o1,bg0_o2, dTemp[2]);

    // !!!!!!!!!!!!!!!!!!!!!!!!!!!
    // !!! END NAND GATE LOGIC !!!
    // !!!!!!!!!!!!!!!!!!!!!!!!!!!

    // Now that all flip flop logic is performed, compute maximum time delay:

    t_Delay = MAX3(dTemp[0].delayValue(),dTemp[1].delayValue(),dTemp[2].delayValue());

}

void updownCounter::set_output()
{
  // Set all DFF - this is dependant on clock and reset values.
  // Utilize values determined in the update_reg() function.

  for (int i = 0; i < 3; i++)
  {
    reg[i].DFF(dTemp[i],clk,rst);

    // Also, set qout values equal to values stored in D.

    qout[i] = reg[i].get_Q().getVal();
  }
}

string updownCounter::output_reg()
{
  string pretty_print = "";

  pretty_print += "The current state of the UpDown Counter is:\t";

  for (int i = 0; i < 3; i++)
    pretty_print += pr_dff[i];

  pretty_print += "\n";

  pretty_print += "Given >>> clk = ";
  pretty_print += c_clk;
  pretty_print += ", rst = ";
  pretty_print += c_rst;
  pretty_print += ", UpDown =";
  pretty_print += c_ud;
  
  pretty_print += "\n";

  pretty_print += "The next state of the UpDown Counter will be:\t";

  for (int i = 0; i < 3; i++)
    pretty_print += qout[i];

  char bufD[32];

  pretty_print += "\nTotal time delay to achieve this result was: ";
  pretty_print += _itoa(t_Delay,bufD,10);

  pretty_print += "\n\n";

  return pretty_print;

}