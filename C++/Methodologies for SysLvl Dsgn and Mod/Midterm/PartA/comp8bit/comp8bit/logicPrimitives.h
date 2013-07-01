// Carlos Lazo
// ECE579D
// Midterm Exam - Part A

#include <fstream>
#include <iostream>
#include <string>

using namespace std;

#define MAX2(a,b)((a < b) ? b : a);
#define MAX3(a,b,c) (c>((a>b)?a:b))?c:((a>b)?a:b);

const int WIRE_DELAY = 1;

// Define the wire class, which will hold logic value and timing.
// By default, wires will have a timing delay of 1

class wire {
  char value;
  int delay;

  public:
    wire () {value = 'X'; delay = WIRE_DELAY;}
    wire (char v, int d) {value = v; delay = d;}
    void put (char  v, int  d) {value = v; delay = d;}
    void get (char& v, int& d) {v = value; d = delay;}
    int delayValue() {return this->delay;}
    char getVal() {return this->value;}
};

// Define a 2-input NAND gate

class nand {
  wire i1, i2, o1;
  int gateDelay;
  
  public:
    nand () {gateDelay = 2;} // Gate Delay = 2, since this is a 2 input NAND gate.
    int delayValue() {return this->gateDelay;}
    void NAND (wire, wire, wire&);
};