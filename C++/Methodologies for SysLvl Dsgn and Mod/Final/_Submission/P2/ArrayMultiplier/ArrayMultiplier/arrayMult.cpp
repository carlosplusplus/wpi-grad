// Carlos Lazo
// ECE579D
// Final Exam - Problem 2

#include "arrayMult.h"

// Load in X and Y input strings, and assume delay = 1 for each.

void arrayMult::load_input(string x, string y)
{
  // Since string[0] = MSB, ensure wire array is setup in ascending order.

  x_in[3].put(x[0],1);
  x_in[2].put(x[1],1);
  x_in[1].put(x[2],1);
  x_in[0].put(x[3],1);

  y_in[3].put(y[0],1);
  y_in[2].put(y[1],1);
  y_in[1].put(y[2],1);
  y_in[0].put(y[3],1);

  x_str = x;
  y_str = y;

  /*

  Test for input values:

  for (int i = 0; i < 4; i++)
    cout << x_in[3-i].getVal();

  cout << endl;

  for (int i = 0; i < 4; i++)
    cout << y_in[3-i].getVal();

  */
}

// Generate logic for 4x4 Multiplier array, using multcell class.

void arrayMult::MULT()
{

  // Create an ZERO wire for initial values -

  wire ZERO('0',1);

  // Multiplier Cell #01

  multcell M01;
  wire w_M01_co;

  M01.perform_mult(x_in[0],y_in[0],ZERO,ZERO,w_M01_co,po[0]);

  // Multiplier Cell #02

  multcell M02;
  wire w_M02_co; wire w_M02_po;

  M02.perform_mult(x_in[0],y_in[1],w_M01_co,ZERO,w_M02_co,w_M02_po);

  // Multiplier Cell #03

  multcell M03;
  wire w_M03_co; wire w_M03_po;

  M03.perform_mult(x_in[0],y_in[2],w_M02_co,ZERO,w_M03_co,w_M03_po);

  // Multiplier Cell #04

  multcell M04;
  wire w_M04_co; wire w_M04_po;

  M04.perform_mult(x_in[0],y_in[3],w_M03_co,ZERO,w_M04_co,w_M04_po);

  // Multiplier Cell #05

  multcell M05;
  wire w_M05_co;

  M05.perform_mult(x_in[1],y_in[0],ZERO,w_M02_po,w_M05_co,po[1]);

  // Multiplier Cell #06

  multcell M06;
  wire w_M06_co; wire w_M06_po;

  M06.perform_mult(x_in[1],y_in[1],w_M05_co,w_M03_po,w_M06_co,w_M06_po);

  // Multiplier Cell #07

  multcell M07;
  wire w_M07_co; wire w_M07_po;

  M07.perform_mult(x_in[1],y_in[2],w_M06_co,w_M04_po,w_M07_co,w_M07_po);

  // Multiplier Cell #08

  multcell M08;
  wire w_M08_co; wire w_M08_po;

  M08.perform_mult(x_in[1],y_in[3],w_M07_co,ZERO,w_M08_co,w_M08_po);

  // Multiplier Cell #09

  multcell M09;
  wire w_M09_co;

  M09.perform_mult(x_in[2],y_in[0],ZERO,w_M06_po,w_M09_co,po[2]);

  // Multiplier Cell #10

  multcell M10;
  wire w_M10_co; wire w_M10_po;

  M10.perform_mult(x_in[2],y_in[1],w_M09_co,w_M07_po,w_M10_co,w_M10_po);

  // Multiplier Cell #11

  multcell M11;
  wire w_M11_co; wire w_M11_po;

  M11.perform_mult(x_in[2],y_in[2],w_M10_co,w_M08_po,w_M11_co,w_M11_po);

  // Multiplier Cell #12

  multcell M12;
  wire w_M12_co; wire w_M12_po;

  M12.perform_mult(x_in[2],y_in[3],w_M11_co,ZERO,w_M12_co,w_M12_po);

  // Multiplier Cell #13

  multcell M13;
  wire w_M13_co;

  M13.perform_mult(x_in[3],y_in[0],ZERO,w_M10_po,w_M13_co,po[3]);

  // Multiplier Cell #14

  multcell M14;
  wire w_M14_co;

  M14.perform_mult(x_in[3],y_in[1],w_M13_co,w_M11_po,w_M14_co,po[4]);

  // Multiplier Cell #15

  multcell M15;
  wire w_M15_co;

  M15.perform_mult(x_in[3],y_in[2],w_M14_co,w_M12_po,w_M15_co,po[5]);

  // Multiplier Cell #16

  multcell M16;

  M16.perform_mult(x_in[3],y_in[3],w_M15_co,ZERO,po[7],po[6]);

  /*

  // See worst case delay path:

  cout << "Worst Case Delay Path:\n\n";
  cout << "\tMC01 - cout = " << w_M01_co.delayValue() << endl;
  cout << "\tMC02 - cout = " << w_M02_co.delayValue() << endl;
  cout << "\tMC03 - cout = " << w_M03_co.delayValue() << endl;
  cout << "\tMC04 - pout = " << w_M04_po.delayValue() << endl;
  cout << "\tMC07 - cout = " << w_M07_co.delayValue() << endl;
  cout << "\tMC08 - pout = " << w_M08_po.delayValue() << endl;
  cout << "\t\tMC10 - cout = " << w_M10_co.delayValue() << endl;
  cout << "\tMC11 - cout = " << w_M11_co.delayValue() << endl;
  cout << "\tMC12 - pout = " << w_M12_po.delayValue() << endl;
  cout << "\t\tMC14 - cout = " << w_M14_co.delayValue() << endl;
  cout << "\tMC15 - cout = " << w_M15_co.delayValue() << endl;
  cout << "\tMC16 - cout = " << po[7].delayValue() << endl;
  
  */

}

void arrayMult::output_result()
{
  
  // First, look at output wires to determine maximum delay:

  int maxDelay = 0;

  for (int i = 0; i < 8; i++) {
    if (po[i].delayValue() > maxDelay){
      maxDelay = po[i].delayValue();
      // cout << "Delay Value @ p" << i << "is: " << po[i].delayValue() << endl;
    }}


  // Second, create output string:

  result = "";

  for (int i = 0; i < 8; i++)
    result = result + po[7-i].getVal();

  // Print out results to terminal window:

  cout << "Multiplication of X = " << x_str << " and Y = " << y_str << " is: " << result << endl;
  cout << "\tDelay Value for this operation = " << maxDelay << endl << endl;

}