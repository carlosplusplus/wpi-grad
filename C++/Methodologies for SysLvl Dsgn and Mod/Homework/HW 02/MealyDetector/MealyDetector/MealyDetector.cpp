// Carlos Lazo
// ECE 579D
// Homework 02

#include "characterPrimitives.h"
#include "MealyDetector.h"

// Create main testbench for the 11010 Mealy Machine:

int main ()
{
  string inVec;
  string outVec = ",,,,,";
  char xin('0'), reset, clock;

  // Variables and intermediate logic chars declared in order to use
  // all necessary primitive logic gates.

  char Y2('X'), Y1('X'), Y0('X'), D2, D1, D11, D12, D13,
    D0, D01, D02, D03, w, w1, w2;

  ifstream finp ("indata.tst");
  ofstream fout ("outdata.tst");

  while (xin != '.')
  {
    finp >> inVec;

    xin   = inVec[0];
    reset = inVec[1];
    clock = inVec[2];

    // Output current state and input being put into the system

    fout << "Current State: " << Y2 << Y1 << Y0 << ", Input: " << inVec << "\n";

    /**********************/
    /* DEFINE D2 FlipFlop */
    /**********************/

    // D2 = x & Y1 & Y0
    D2 = and ( and (xin, Y1), Y0);

    /**********************/
    /* DEFINE D1 FlipFlop */
    /**********************/

      // D11 = x & ~Y1 & Y0
    D11 = and ( and (xin, not(Y1)), Y0);
      // D12 = Y1 & ~Y0
    D12 = and (Y1, not(Y0));
      // D13 = x & Y2
    D13 = and (xin, Y2);

    // D1 = D11 + D12 + D13
    D1  = or ( or(D11,D12), D13);

    /**********************/
    /* DEFINE D0 FlipFlop */
    /**********************/

      // D01 = x & ~Y2
    D01 = and (xin, not(Y2));
      // D02 = ~Y1 & ~Y0
    D02 = and ( not(Y1), not(Y0));
      // D03 = ~x & Y1 & ~Y0
    D03 = and ( and (not(xin), Y1), not(Y0));

    // D0 = (D01 & D02) + D03
    D0  = or ( and(D01,D02), D03);

    /*******************/
    /* DEFINE Output w */
    /*******************/

      // w1 = (Y2Y1Y0 == 100)
    w1  = and ( Y2, and (not(Y1), not(Y0)));
      // w2 = ~x & Y2
    w2  = and ( not(xin), Y2);

    // w = w1 & w2
    w = and(w1,w2);

    // ******************** //

    // D Flip-Flop Assignments, based on clock and reset values

    dff_PAH (D2, clock, reset, Y2);
    dff_PAH (D1, clock, reset, Y1);
    dff_PAH (D0, clock, reset, Y0);

    // Apply the following values after application of previous inputs:

    outVec[0] = w;
    outVec[2] = Y2;
    outVec[3] = Y1;
    outVec[4] = Y0;

    // For the Mealy Machine, output the next state and the respective output
    // after the D flip-flops have been set with the current input values.

    fout << "\tOutput, Next State: " << outVec + "\n\n";

  }
  fout << "END FILESTREAM";

  return 0;
}