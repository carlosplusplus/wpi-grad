// Carlos Lazo
// ECE579D
// Midterm Exam - Part C

#include "systemc.h"
#include "tb_serialAdder.h"

using namespace sc_dt;

// Generate data for ain value:

void tb_serialAdder::data_ain()
{
  int data;
  FILE *ifp;
  ifp = fopen("ainfile.dat","r");

  for (int i = 0; i < 100; i = i + 5)
  {
    if (feof(ifp)) ain = SC_LOGIC_0;
    else ain = SC_LOGIC_1;
    wait (5,SC_NS);
  }
}

// Generate data for bin value from file:
void tb_serialAdder::data_bin()
{
  int data;
  FILE *ifp;
  ifp = fopen("binfile.dat","r");

  for (int i = 0; i < 100; i = i + 10)
  {
    if (feof(ifp)) bin = SC_LOGIC_0;
    else bin = SC_LOGIC_1;
    wait (10,SC_NS);
  }
}

// Set timing data for start here in the testbench:
void tb_serialAdder::data_start()
{
  wait (20,SC_NS);
  start = SC_LOGIC_1;
  wait (10,SC_NS);
  start = SC_LOGIC_0;
}

// Set timing data for reset here in the testbench:
void tb_serialAdder::data_rst()
{
  wait (5,SC_NS);
  rst = SC_LOGIC_1;
  wait (10,SC_NS);
  rst = SC_LOGIC_0;
}

// Set timing data for clk here in the testbench:
void tb_serialAdder::data_clk()
{
  for (int i = 0; i < 50; i++)
  {
    clk = SC_LOGIC_1;
    wait (5,SC_NS);
    clk = SC_LOGIC_0;
    wait (5,SC_NS);
  }  
}