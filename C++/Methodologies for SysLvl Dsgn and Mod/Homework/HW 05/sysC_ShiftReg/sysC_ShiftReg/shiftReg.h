// Carlos Lazo
// ECE579
// Homework 05

#include <iostream>
#include <string>

#include "systemc.h"

using namespace std;

SC_MODULE(ShiftRegister)
{

  // Define all fixed module variables:

  sc_in_clk   clk;           // Define internal clock
  sc_in<bool> rst;           // Define internal reset
  sc_in<bool> sri;           // Define serial right
  sc_in<bool> sli;           // Define serial left

  sc_in <sc_uint<2> > mode;  // Define mode array
  sc_in <sc_uint<8> >  pin;  // Define parallel input
  sc_out<sc_uint<8> > pout;  // Define parallel output

  // Declare temporary module variables for computation:

  sc_uint<8>       p_temp;
  sc_uint<2>       m_temp;

  // Declare function for ShiftRegister:

  void update_reg();

  // Declare inline constructor for ShiftRegister:

  SC_CTOR(ShiftRegister)
  {
    // Set sensitivies based on rst & clk values.  
    SC_METHOD(update_reg);
    sensitive << rst.pos() << clk.pos();
  }
};