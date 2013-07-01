// Carlos Lazo
// ECE579
// Homework 05

#include "shiftReg.h"
#include "systemc.h"

// Define the functionality of the Shift Register:

void ShiftRegister::update_reg()
{

  // Current value to be processed were last contents of ShiftRegister
  p_temp = pout.read();

  // Set internal mode to current mode
  m_temp = mode.read();

  // Use a switch statement to perform ShiftRegister functionality

  switch (m_temp)
  {
    // Mode = 00: Do Nothing
    case 0: break;

    // Mode = 01: Shift right
    case 1:
    {
      p_temp = (sri.read(), p_temp.range(7,1));
      pout.write(p_temp);
      break;
    }

    // Mode = 10: Shift left
    case 2:
    {
      p_temp = (p_temp.range(6,0),sli.read());
      pout.write(p_temp);
      break;
    }

    // Mode = 11: Parallel load
    case 3:
    {
      pout.write(pin);
      break;
    }
  }

  // Reset takes precedence and sets pout = 0

  if (rst.read() == 1)
    pout.write(0);
}

int sc_main (int argc, char* argv[])
{
  cout << endl << endl;

  // Declare all sc_signals in the main (testbench):

  sc_signal<bool> clk;           // Define internal clock
  sc_signal<bool> rst;           // Define internal reset
  sc_signal<bool> sri;           // Define serial right
  sc_signal<bool> sli;           // Define serial left

  sc_signal <sc_uint<2> > mode;  // Define mode array
  sc_signal <sc_uint<8> >  pin;  // Define parallel input
  sc_signal<sc_uint<8> >  pout;  // Define parallel output

  // Connect all ports to ShiftRegister:

  ShiftRegister sysC_Reg ("sysC_Reg");
    sysC_Reg.clk(clk);
    sysC_Reg.rst(rst);
    sysC_Reg.sri(sri);
    sysC_Reg.sli(sli);
    sysC_Reg.mode(mode);
    sysC_Reg.pin(pin);
    sysC_Reg.pout(pout);

  // Open the VCD file to be used for data recording and place signals:

    sc_trace_file *wf = sc_create_vcd_trace_file("reg_Out");
      sc_trace(wf,clk,"clk");
      sc_trace(wf,rst,"rst");
      sc_trace(wf,sri,"sri");
      sc_trace(wf,sli,"sli");
      sc_trace(wf,mode,"mode");
      sc_trace(wf,pin,"pin");
      sc_trace(wf,pout,"pout");

  // Set all initial variable values:

  rst  = 0;
  mode = 0;
  sri  = 0;
  sli  = 0;
  pin  = 15;  // 0x0F in Hex

  // Apply a reset for 1 clock cycle:
  rst = 1;

  clk = 0; sc_start(1);
  clk = 1; sc_start(1);

  // Deassert reset signal for 2 clock cycle:
  rst = 0;

  clk = 0; sc_start(1);
  clk = 1; sc_start(1);
  
  // Perform a load operation:

  mode = 3;
  
  clk = 0; sc_start(1);
  clk = 1; sc_start(1);

  // Shift right a total of 2 times, with sri = 1

  sri  = 1;
  mode = 1;

  for (int i = 0; i < 2; i++)
  {
    clk = 0; sc_start(1);
    clk = 1; sc_start(1);
  }

  // Shift left a total of 2 times, with sli = 0

  mode = 2;

  for (int i = 0; i < 2; i++)
  {
    clk = 0; sc_start(1);
    clk = 1; sc_start(1);
  }

  // Apply a reset for 1 clock cycle:
  rst = 1;

  clk = 0; sc_start(1);
  clk = 1; sc_start(1);

  // Deassert reset signal for 1 clock cycles:
  rst = 0;

  clk = 0; sc_start(1);
  clk = 1; sc_start(1);

  // Perform a load operation:

  pin  = 153;  //0x99 in Hex
  mode = 3;

  clk = 0; sc_start(1);
  clk = 1; sc_start(1);

  // Shift right 3x and fill with 1's

  mode = 1;
  sri  = 1;

  for (int i = 0; i < 3; i++)
  {
    clk = 0; sc_start(1);
    clk = 1; sc_start(1);
  }

  // Change to do nothing and finish simulation

  mode = 0;

  clk = 0; sc_start(1);
  clk = 1; sc_start(1);

  // Close trace file and end simulation

  sc_close_vcd_trace_file(wf);

  return 0;
}