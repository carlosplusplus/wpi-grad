// Carlos Lazo
// ECE579
// Homework 06

#include "S2PC.h"
#include "systemc.h"

using namespace std;

int sc_main (int argc, char* argv[])
{
  cout << endl << endl;

  // Define all fixed module variables:

  sc_signal<bool> clk;         // Define internal clock
  sc_signal<bool> rst;         // Define reset signal
  sc_signal<bool> serin;       // Define serial input of S2PC
  sc_signal<bool> start;       // Define start signal

  sc_signal<bool> ready;       // Indicating system is ready to start
  sc_signal<bool> done;        // Indicating that serial input is done

  sc_signal<sc_lv<9> > parout; // Define parallel output

  // Connect all ports to ShiftRegister:

  S2PC sysC_S2PC ("sysC_S2PC");
    sysC_S2PC.clk(clk);
    sysC_S2PC.rst(rst);
    sysC_S2PC.serin(serin);
    sysC_S2PC.start(start);
    sysC_S2PC.ready(ready);
    sysC_S2PC.done(done);
    sysC_S2PC.parout(parout);

  // Open the VCD file to be used for data recording and place signals:

    sc_trace_file *wf = sc_create_vcd_trace_file("S2PC_Out");
      sc_trace(wf,clk,"clk");
      sc_trace(wf,rst,"rst");
      sc_trace(wf,serin,"serin");
      sc_trace(wf,start,"start");
      sc_trace(wf,ready,"ready");
      sc_trace(wf,done,"done");
      sc_trace(wf,parout,"parout");

    // Set all initial values:

    clk = 0; rst = 1; serin = 1; start = 0;

    // Reset the circuit to start off with:

    clk = 1; sc_start(1,SC_NS);
    clk = 0; sc_start(1,SC_NS);

    rst = 0;

    // Hit a pulse on start, which should fill in 1's to parout:

    start = 1; sc_start(1,SC_NS);
    start = 0; sc_start(1,SC_NS);

    // Run a total of 10 pulses to see parout contain valid values:

    for (int i = 0; i < 10; i++)
    {
      clk = 0; sc_start(1,SC_NS);
      clk = 1; sc_start(1,SC_NS);
    }

    // Reset circuit once again:

    clk = 0; rst = 1; serin = 1; start = 0;

    clk = 1; sc_start(1,SC_NS);
    clk = 0; sc_start(1,SC_NS);

    rst = 0;

    // Hit a pulse on start, then alternate serial input data:

    start = 1; sc_start(1,SC_NS);
    start = 0; sc_start(1,SC_NS);

    for (int i = 0; i < 10; i++)
    {
      if (i%2 == 0)
        serin = 0;
      else
        serin = 1;

      clk = 0; sc_start(1,SC_NS);
      clk = 1; sc_start(1,SC_NS);
    }

    sc_close_vcd_trace_file(wf);

  return 0;
}