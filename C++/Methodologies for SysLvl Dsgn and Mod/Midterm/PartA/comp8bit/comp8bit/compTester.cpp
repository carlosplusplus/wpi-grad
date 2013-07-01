// Carlos Lazo
// ECE579D
// Midterm Exam - Part A

#include "comparator.h"

// Main Testbench for 8-bit Comparator -

int main()
{

  // Initialize 8-bit Comparator

  comp_8bit uut;

  // Test #1 (EQ)

  string a = "00000000";
  string b = "00000000"; 

  uut.load_in(a,b);
  uut.output();

  // Test #2 (GT)

  a = "01100001";
  b = "01011110"; 

  uut.load_in(a,b);
  uut.output();

  // Test #3 (EQ)

  a = "11111111";
  b = "11111111"; 

  uut.load_in(a,b);
  uut.output();

  // Test #4 (GT)

  a = "11100100";
  b = "11100000";

  uut.load_in(a,b);
  uut.output();

  // Test #5 (0)

  a = "11100000";
  b = "11110000";

  uut.load_in(a,b);
  uut.output();

  // Test #6 (0)

  a = "10100101";
  b = "11100111";

  uut.load_in(a,b);
  uut.output();

  // Test #7 (GT)

  a = "11101110";
  b = "11101100";

  uut.load_in(a,b);
  uut.output();

  // Test #8 (GT)

  a = "01100000";
  b = "11100000";

  uut.load_in(a,b);
  uut.output();

  // Test #9 (0)

  a = "00110111";
  b = "00111111";

  uut.load_in(a,b);
  uut.output();

  // Test #10 (EQ)

  a = "10101001";
  b = "10101001";

  uut.load_in(a,b);
  uut.output();

  return 0;
}