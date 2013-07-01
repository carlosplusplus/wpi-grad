// Carlos Lazo
// ECE579D
// Final Exam - Problem 3

#include "systemc"
#include "time.h"
#include "sys/timeb.h"
#include "common_header.h"

using namespace sc_core;

// Declare a common semaphore, called bus, with 4 tokens

sc_semaphore bus(4);

// Define the Master module:

SC_MODULE (Master) {

  // Define private member variables of module:

  sc_in <bool> clock; // External clock provided to module
  int id;             // Unique identifier of Master module

  void MASTER_REQ()
  {
    while(true)
    {
      int t1_rand = rand()%  5 + 1;  // Random # from 1 -  5.
                                     // Wait time prior to issuing request.

      int t2_rand = rand()% 10 + 1;  // Random # from 1 - 10.
                                     // If request granted, wait time before releasing semaphore.

      wait(t1_rand);

      // Print time when Master requests access to device after t1_rand seconds.

      fout << "\n@" << sc_time_stamp() << "\tMASTER " << id << " is requesting access to device";
      fout << " after waiting << " << t1_rand << " seconds." << endl;

      // Attempt to obtain semaphore, if available (non-blocking).

      if (bus.trywait() != -1)
      {
        // Print time that Master will need device, and then wait t2_rand seconds.

        fout << "\t* MASTER " << id << " granted access to device and needs it for ";
        fout << t2_rand << " seconds." << endl;

        wait (t2_rand);

        // Return semaphore to device.

        bus.post();

        // Print time that Master has released semaphore back to device.

        fout << "\n@" << sc_time_stamp() << "\tMASTER " << id << " releases semaphore back to device.";
        fout << " Count = " << bus.get_value();

      }

      // If obtaining the semaphore was unsuccessful, then print so.

      else

        fout << "\t!!! MASTER " << id << " denied access to device. !!!";

      fout << endl;
    }
  }

  // Define Master constructor:

  Master(sc_module_name _n, int _id) : sc_module(_n), id(_id)
  {
    SC_CTHREAD(MASTER_REQ,clock.pos());
  }

  SC_HAS_PROCESS(Master); // Required if processes are used but SC_CTOR is not called
};

// Define the semaphore_access module, which will be used as a simple timer.

SC_MODULE (semaphore_access) {

  // Define inputs of the module:

  sc_in<bool> clock;

  // Define local variables of the module:

  int count;

  // Stop the Clock after t = 100 seconds

  void timer()
  {
     while(true)
    {
      wait();
      count++;
      if (count > 100)
        sc_stop();
    }
  }

  SC_CTOR(semaphore_access)
  {
    count = 0;

    SC_CTHREAD(timer,clock.pos());
  }
};

// MAIN PROGRAM

int sc_main (int argc, char* argv[]) {

  // Initialize a random seed for timing:

  srand ( time(NULL) );

  // Initialize semaphore_access module & common clock:

  sc_clock clock ("my_clock",1,0.5);
  
  semaphore_access SA ("SA");
    SA.clock(clock.signal());

  // Initialize all 5 Master modules:

  Master M1("M1",1);
    M1.clock(clock);
  Master M2("M2",2);
    M2.clock(clock);
  Master M3("M3",3);
    M3.clock(clock);
  Master M4("M4",4);
    M4.clock(clock);
  Master M5("M5",5);
    M5.clock(clock);

  cout << endl;

  sc_start(0); // First time called will init schedular
  sc_start();  // Run the simulation till sc_stop is encountered

  int freeze;
  cin >> freeze;

  return 0;// Terminate simulation
}