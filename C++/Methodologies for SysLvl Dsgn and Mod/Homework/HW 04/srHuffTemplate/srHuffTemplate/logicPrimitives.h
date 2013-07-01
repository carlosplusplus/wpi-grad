// Carlos Lazo
// ECE579D
// Homework 04

#ifndef LOGICPRIMITIVES_H
#define LOGICPRIMITIVES_H

#include <fstream>
#include <iostream>
#include <string>

using namespace std;

#define MAX2(a,b)((a < b) ? b : a);
#define MAX3(a,b,c) (c>((a>b)?a:b))?c:((a>b)?a:b);

// Define the wire class, which will hold:
//    logic value, pwr consumption, and timing

class wire {
  char value;
  int delay, pwr;

  public:
    wire () {delay = 0; pwr = 0; value = 'X';}
    void put (char  v, int  d, int  p) {value = v; delay = d; pwr = p;}
    void get (char& v, int& d, int& p) {v = value; d = delay; p = pwr;}
    int delayValue() {return this->delay;}
    char getVal() {return this->value;}
};

// Define a 3-input AND gate

class and {
  wire i1, i2, i3, o1;
  int gateDelay;
  
  public:
    and () {gateDelay = 3;} // Gate Delay = 3, since this is a 3 input AND gate.
    int delayValue() {return this->gateDelay;}
    void AND (wire, wire, wire, wire&);
};

// Define a 4-input OR gate

class or {
  wire i1, i2, i3, i4, o1;
  int gateDelay;
  
  public:
    or () {gateDelay = 4;} // Gate Delay = 4, since this is a 4 input OR gate.
    int delayValue() {return this->gateDelay;}
    void OR (wire, wire, wire, wire, wire&);
};

// Define the NOT gate

class not {
  wire i1, o1;
  int gateDelay;
  
  public:
    not () {gateDelay = 1;} // Gate Delay = 1, since this is a NOT gate.
    int delayValue() {return this->gateDelay;}
    void NOT (wire, wire&);
};

// Define the DFF class

class dff {
  wire Q;
  int clkQDelay;

  public:
    dff() {clkQDelay = 3;} // Set Clock Delay = 3
    int delayValue() {return this->clkQDelay;}
    wire get_Q() {return this->Q;}
    void DFF(wire, wire, wire);
};

#endif