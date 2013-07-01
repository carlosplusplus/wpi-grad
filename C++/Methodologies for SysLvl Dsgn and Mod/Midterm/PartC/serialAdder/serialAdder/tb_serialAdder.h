// Carlos Lazo
// ECE579D
// Midterm Exam - Part C

#include "systemc.h"
#include "serialAdder.h"

SC_MODULE (tb_serialAdder) {
    sc_out <sc_logic> ain;     // Serial input for a
    sc_out <sc_logic> bin;     // Serial input for b
    sc_out <sc_logic> start;   // Start pulses received here
    sc_out <sc_logic> clk;     // System clock
    sc_out <sc_logic> rst;     // System reset
    
    serialAdder UUT;          // Instantiated serial adder

    // Declare all functions which will read in data:

    void data_ain();
    void data_bin();
    void data_start();
    void data_clk();
    void data_rst();

    // Declare tb_serialAdder Constructor
    SC_CTOR(tb_serialAdder) : UUT("UUT")
    {
      SC_THREAD(data_ain);
      SC_THREAD(data_bin);
      SC_THREAD(data_start);
      SC_THREAD(data_clk);
      SC_THREAD(data_rst);
      sensitive << clk << ain << bin;

      UUT.ain(ain);
      UUT.bin(bin);
      UUT.start(start);
      UUT.rst(rst);
      UUT.clk(clk);

    }
};