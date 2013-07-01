// Carlos Lazo
// ECE579D
// Midterm Exam - Part A

#ifndef COMPARATOR_H
#define COMPARATOR_H

#include "logicPrimitives.h"

// Define the comp_elem Class

class comp_elem {

  private:
    wire ai, bi, eq, gt, EQ, GT;

  public:

    // Constructors:
    comp_elem ();

    // Declare functions:
    void proc (wire a, wire b, wire e, wire g, wire& E, wire& G);
};

// Define the comp_8bit Class

class comp_8bit {

  private:
  
    comp_elem c_array[8];
    wire a[8], b[8], e[8], g[8];
    string a_s, b_s;

  public:

    // Constructors:
    comp_8bit ();

    void load_in (string astr, string bstr);
    void output();
};

#endif