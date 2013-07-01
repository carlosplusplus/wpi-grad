// Carlos Lazo
// ECE579D
// Final Exam - Problem 2

#include "arrayMult.h"

int main ()
{

  arrayMult AM;

  AM.load_input("0001", "0001");
  AM.MULT();
  AM.output_result();

  AM.load_input("0010", "0010");
  AM.MULT();
  AM.output_result();

  AM.load_input("0111", "0000");
  AM.MULT();
  AM.output_result();

  AM.load_input("0111", "0111");
  AM.MULT();
  AM.output_result();

  AM.load_input("1111", "0111");
  AM.MULT();
  AM.output_result();

  // Freeze screen output.

  int freeze;
  cin  >> freeze;

  return 0;
}