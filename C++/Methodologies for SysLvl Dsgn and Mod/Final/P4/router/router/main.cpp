// Carlos Lazo
// ECE579D
// Final Exam - Problem 4

#include "common_header.h"
#include "systemc"
#include "time.h"
#include "sys/timeb.h"

#include "reader.cpp"
#include "switch.cpp"
#include "memory.cpp"

using namespace sc_core;

SC_MODULE(Top)
{
  // Initialize all instances for system:

  Reader* reader;
  Switch<2,1>* router;
  Memory<1>*   memory1;
  Memory<2>*   memory2;

  SC_CTOR(Top)
  {
    reader = new Reader("reader");
    router = new Switch<2,1>("router");
    memory1 = new Memory<1>("memory1");
    memory2 = new Memory<2>("memory2");

    // Bind Writer initiator socket with Switch target socket

    router->targ_socket[0]->bind(reader->socket);

    // Bind Switch initiator sockets with Memory target sockets 

    (*(router->init_socket[0]) ).bind( memory1->socket );    //bind memory1 socket
    (*(router->init_socket[1]) ).bind( memory2->socket );    //bind memory2 socket
  }
};


int sc_main(int argc, char* argv[])
{
  Top top("top");
    sc_start();

  cout << "DONE!\n\n";

  int freeze;
  cin >> freeze;

  return 0;

}