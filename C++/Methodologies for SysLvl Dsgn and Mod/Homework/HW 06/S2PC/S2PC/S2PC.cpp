// Carlos Lazo
// ECE579
// Homework 06

#include "S2PC.h"
#include "systemc.h"

// Define the functionality of the S2PC Controller:

void S2PC::controller()
{
  // Declare all Controller state machine logic:

  while (1)
  {
    // First, check the reset condition -
    if (rst.read() == 1){
      p_state = rdy; }

    // If not, perform next state computation -
    else switch (p_state)
    {
      // If ready and start = 1, begin reading in data.
      case (rdy) :
      {
        if (start.read() == 1)
          p_state = rd_in;
        else
          p_state = rdy;
        break;
      }

      // If in data collection stage, check counter state for transition.
      // Else, continue reading in serial data.
      case (rd_in) :
      {
        if (counter == 7)
          p_state = out;
        else
          p_state = rd_in;
        break;
      }

      // If in the output stage, 
      case (out) :
        p_state = rdy;

      default : p_state = rdy;
    }

    // Now define and set all Controller signals to Datapath:

    if (p_state == rdy)
    {
      ready = 1; done = 1;
      count_en.write(0); par_en.write(1); ld_en.write(0);
    }
    
    if (p_state == rd_in)
    {
      ready = 0; done = 0;
      count_en.write(1); par_en.write(0); ld_en.write(1);
    }

    if (p_state == out)
    {
      ready = 0; done = 1;
      count_en.write(0); par_en.write(1); ld_en.write(0);
    }

    // Now that Controller signals are done, end thread.

    wait();
  }
}

// Define the functionality of the S2PC Datapath:

void S2PC::datapath()
{

  while (1)
  {

    // First, check the reset condition:
    if (rst.read() == 1)
      t_reg = 0;

    // If we have enabled loading of the register, perform a shift:
    else if (ld_en.read() == 1)
    {
      t_reg = (t_reg[8], serin.read(), t_reg.range(7,1));

      // Increment the counter if currently enabled:
      if (count_en.read() == 1)
        counter++;

      // If counter is at maximum value, compute parity:
      if (counter == 7)
      {
        t_reg = (xor_reduce(t_reg), t_reg.range(7,0));
        counter = 0;
      }
    }

    // If parout is ready, write the internal register to it:
    if (par_en.read() == 1)
      parout.write(t_reg);

    wait();
  }
}