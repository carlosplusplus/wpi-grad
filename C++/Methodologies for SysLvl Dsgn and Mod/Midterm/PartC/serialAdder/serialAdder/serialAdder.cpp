// Carlos Lazo
// ECE579D
// Midterm Exam - Part C

#include "serialAdder.h"
#include "systemc.h"

using namespace std;
using namespace sc_dt;

#define HI SC_LOGIC_1
#define LO SC_LOGIC_0

// Combinational logic:

// Define the combinational logic for the serialAdder as a FSM

void serialAdder::comb_func()
{

  // By default, set the next state to idle:

  n_state = idle;

  // Delineate transitional logic of serial adder:
  switch (p_state)
  {
    case (idle): 
      {
      if (start.read() == SC_LOGIC_1) 
        n_state = add;
      else
        n_state = idle_t;

      break;
    }

    case (idle_t): 
    {
      if (start.read() == SC_LOGIC_1) 
        n_state = add;
      else
        n_state = idle;

      break;
    }

    case (add):
    {
      if (counter < 7)
        n_state = add_t;
      else
        n_state = output;
      break;
    }

    case (add_t):
    {
      if (counter < 7)
        n_state = add;
      else
        n_state = output;
      break;
    }

    case (output):
    {
      n_state = idle;
      break;
    }

    default : n_state = idle;
  }

  // Perform logic operations based on p_state:

  if (p_state == idle || p_state == idle_t)
  {
    cout << "I'm in the idle state." << endl;
    ready.write(SC_LOGIC_1);
    counter = 0;
  }

  else if (p_state == add || p_state == add_t)
  {

    cout << "I'm in the add state, and counter = " << counter << "." << endl;

    if (counter == 0)
    {
      c_in = SC_LOGIC_0;
      sum  = SC_LOGIC_0;
    }

    // If adding, perform logic on values and store to result.

    sc_lv<8> temp = result.read();

    cout << "Current result is: ";

    for (int i = 0; i < 8; i++)
      cout << temp[i];

    cout << endl;

    //cout << "DEBUG 2" << endl;
    
    sum   = (ain.read() ^ bin.read()) ^ c_in;
    c_out = (ain.read() & bin.read()) | (c_in & (ain.read() ^ bin.read()));

    // Perform a right shift since LSB's are coming in first,
    // and set the current cout to the next cin.

    temp[7 - counter] = sum;

    c_in     = c_out;

    cout << "The new result is: ";

    for (int i = 0; i < 8; i++)
      cout << temp[i];

    cout << endl;

    // Write current sum to result register:

    result.write(temp);

    counter = counter + 1;
  }

  else if (p_state == output)
  {
    counter = 0;
    ready.write(SC_LOGIC_1);
  }

}

// Declare the sequential part of the serialAdder,
// which is controlled by the posedge clk transition.

void serialAdder::seq_func()
{
  while(1){

    if (rst.read() == SC_LOGIC_1)
    {
      cout << "I was RESET!" << endl;
      p_state = idle;
    }

    else
      p_state = n_state;

    wait();
  }
}



// Quick Testbench to prove functionality:

int sc_main (int argc, char* argv[])
{

  sc_report_handler::set_actions("/IEEE_Std_1666/deprecated", SC_DO_NOTHING);

  sc_signal <sc_logic> clk;
  sc_signal <sc_logic> rst;
  sc_signal <sc_logic> ain;
  sc_signal <sc_logic> bin;
  sc_signal <sc_logic> str;

  clk = SC_LOGIC_0;
  rst = SC_LOGIC_0;
  ain = SC_LOGIC_0;
  bin = SC_LOGIC_0;
  str = SC_LOGIC_0;

  sc_signal <sc_logic> ready;
  sc_signal <sc_lv<8> > res;

  serialAdder UUT("UUT");
    UUT.rst(rst);
    UUT.ain(ain);
    UUT.bin(bin);
    UUT.clk(clk);
    UUT.start(str);

    UUT.ready(ready);
    UUT.result(res);

  sc_trace_file *out_file;
  out_file = sc_create_vcd_trace_file ("outfile");

    sc_trace(out_file,ain,"ain");
    sc_trace(out_file,bin,"bin");
    sc_trace(out_file,rst,"rst");
    sc_trace(out_file,rst,"clk");
    sc_trace(out_file,str,"start");
    sc_trace(out_file,ready,"ready");
    sc_trace(out_file,res,"result");

  sc_start(5);

  clk = SC_LOGIC_1;
  rst = SC_LOGIC_1;
  sc_start(5);

  clk = SC_LOGIC_0;
  rst = SC_LOGIC_0;

  sc_start(5);

  ain = SC_LOGIC_1;
  clk = SC_LOGIC_1;
  sc_start(5);

  clk = SC_LOGIC_0;

  sc_start(5);
  
  str = SC_LOGIC_1;
  clk = SC_LOGIC_1;
  sc_start(5);

  str = SC_LOGIC_0;
  clk = SC_LOGIC_0;

  sc_start(5);

  clk = SC_LOGIC_1;

  sc_start(5);

  clk = SC_LOGIC_0;
  bin = SC_LOGIC_1;

  for (int i = 0; i < 15; i++)
  {
    if (i == 3)
    { ain = SC_LOGIC_0; bin = SC_LOGIC_0;}

    sc_start(5);

    clk = SC_LOGIC_1;
    sc_start(5);

    clk = SC_LOGIC_0;
  }

  sc_close_vcd_trace_file (out_file);

  cout << endl << endl;

  return 0;
}