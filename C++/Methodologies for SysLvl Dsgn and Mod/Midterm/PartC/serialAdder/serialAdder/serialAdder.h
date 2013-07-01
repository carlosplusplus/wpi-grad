// Carlos Lazo
// ECE579D
// Midterm Exam - Part C

#include <iostream>
#include <string>

#include "systemc.h"

using namespace std;

SC_MODULE(serialAdder)
{
  // Define all fixed module variables:

  sc_in <sc_logic> ain;     // Serial input for a
  sc_in <sc_logic> bin;     // Serial input for b
  sc_in <sc_logic> start;   // Start pulses received here
  sc_in <sc_logic> clk;     // System clock
  sc_in <sc_logic> rst;     // System reset

  sc_out<sc_logic>  ready;  // Indicates that system is ready to add
  sc_out<sc_lv<8> > result; // Outputs result of serial addition

  // Declare internal variables to serialAdder:

  sc_uint<8> counter;       // Counter for FSM
  sc_logic   sum;           // Sum for current computation
  sc_logic   c_in;          // Carry in for current computation
  sc_logic   c_out;         // Carry out for next computation
  
  enum states {idle,idle_t,add,add_t,output}; // States for FSM
  sc_signal <states> p_state, n_state;        // Signals for FSM

  // Define functions for serialAdder

  void comb_func();
  void  seq_func();

  // Define constructor for serialAdder:

  SC_CTOR (serialAdder) : counter(0)
  {
    SC_METHOD(comb_func);
    sensitive << p_state << ain << bin;
  
    SC_THREAD(seq_func);
    sensitive << clk.pos();

  }

};