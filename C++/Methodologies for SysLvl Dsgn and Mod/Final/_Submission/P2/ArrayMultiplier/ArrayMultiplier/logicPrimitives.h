// Carlos Lazo
// ECE579D
// Final Exam - Problem 2

#include <fstream>
#include <iostream>
#include <string>

using namespace std;

#define MAX2(a,b)((a < b) ? b : a);

// Define the wire class, which will hold:
//    logic value and timing

class wire {
  char value;
  int delay;

  public:
    wire () {value = 'X'; delay = 0;}
    wire (char v, int d) { value = v; delay = d;}
    void put (char  v, int  d) {value = v; delay = d;}
    void get (char& v, int& d) {v = value; d = delay;}
    int delayValue() {return this->delay;}
    char getVal() {return this->value;}
};

// Define a 2-input AND gate

class and {
  wire i1, i2, o1;
  int gateDelay;

  public:
    and() {gateDelay = 2;} // Gate Delay = 2, since there are 2 inputs.
    int delayValue () {return this->gateDelay;}
    void AND (wire, wire, wire&);
};

// Define a 3-input OR gate

class or {
  wire i1, i2, i3, o1;
  int gateDelay;
  
  public:
    or() {gateDelay = 3;} // Gate Delay = 6, since there are 3 inputs.
      int delayValue() {return this->gateDelay;}
      void OR (wire, wire, wire, wire&);
};

// Define a 2-input XOR gate

class xor {
  wire i1, i2, o1;
  int gateDelay;

  public:
    xor() {gateDelay = 2;} // Gate Delay = 2, since there are 2 inputs.
    int delayValue () {return this->gateDelay;}
    void XOR (wire, wire, wire&);
};

// Define an Array Multiplier cell

class multcell {

  public:

    void perform_mult(wire, wire, wire, wire, wire&, wire&);

};
