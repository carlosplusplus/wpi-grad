// Carlos Lazo
// ECE579
// Homework 06

#include <iostream>
#include <string>

#include "systemc.h"

using namespace std;

SC_MODULE(S2PC)
{

  // Define all fixed module variables:

  sc_in_clk   clk;           // Define internal clock
  sc_in<bool> rst;           // Define reset signal
  sc_in<bool> serin;         // Define serial input of S2PC
  sc_in<bool> start;         // Define start signal

  sc_out <bool> ready;       // Indicating system is ready to start
  sc_out <bool> done;        // Indicating that serial input is done

  sc_out<sc_lv<9> > parout;  // Define parallel output
  sc_lv<9>          t_reg;   // Define local variable

  // Declare internal module variables for computation:

  sc_uint<8>       counter;
  sc_signal <bool> count_en;
  sc_signal <bool> ld_en;
  sc_signal <bool> par_en;

  // Enumerate all 3 possible states the S2PC will see:

  enum states {rdy, rd_in, out};
  sc_signal <states> p_state;

  // Create two functions, one which will act as the Controller,
  // and the other which will serve as the Datapath.

  void controller ();
  void datapath ();

  // Declare inline constructor for the S2PC:

  SC_CTOR (S2PC) : count_en(0), ld_en(0), par_en(0)
  {
    p_state = rdy;

    // Set sensitivies based on clk values. 
    // For the purposes of this HW:
    //    Posedge(clk) will trigger the controller
    //    Negedge(clk) will trigger the datapath (reg)

    SC_THREAD (controller)
      sensitive << clk.pos();

    SC_THREAD (datapath)
      sensitive << clk.neg();
  }

};