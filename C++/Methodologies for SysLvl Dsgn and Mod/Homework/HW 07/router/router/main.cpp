// Carlos Lazo
// ECE579D
// Homework 07

#include "writer.cpp"
#include "reader.cpp"
#include "switch.cpp"
#include "MTF.cpp"
#include "Run-Length.cpp"
#include "memory.cpp"
#include "systemc"
#include "time.h"
#include "sys/timeb.h"
using namespace sc_core;

// Core signals remain the same.

sc_core::sc_signal<bool> readAllowed;
sc_core::sc_signal<bool> mtfAllowed;
sc_core::sc_signal<bool> runAllowed;
sc_core::sc_signal<bool> writeAllowed;
int compressedLen;

unsigned int Memory::mem_nr = 0;

SC_MODULE(Top)
{
	Writer* writer;
	Reader* reader;
	MTF* mtf;
	RunLength* runL;
	Switch<1,4>* router;  // Switch declaration remains the same.
	Memory*    memory;

	SC_CTOR(Top)
	{
    // Signals initialized in the same order.

    compressedLen = 0;
		writeAllowed.write(true);
		readAllowed.write(false);
		mtfAllowed.write(false);
		runAllowed.write(false);
		reader = new Reader("reader");
		writer = new Writer("writer");
		mtf = new MTF("mtf");
		runL = new RunLength("runL");
		router    = new Switch<1,4>("router");
		for (int i = 0; i < 1; i++)
		{
			char txt[20];
			sprintf(txt, "memory_%d", i);
			memory   = new Memory(txt);
		}

		router->targ_socket[0]->bind(writer->socket);           //writer id = 0;
		router->targ_socket[1]->bind(mtf->socket);              //mtf id = 1;
		router->targ_socket[2]->bind(runL->socket);             //runL id = 2;
		router->targ_socket[3]->bind(reader->socket);           //reader id = 3;
		(*(router->init_socket[0]) ).bind( memory->socket );    //bind memory socket
	}
};


int sc_main(int argc, char* argv[])
{
	clock_t t1, t2;
	long duration1;

	t1 = clock();

	Top top("top");
    sc_start();

	t2 = clock();
	duration1 = (t2-t1);
	fout << "duration1: " << duration1/(double) CLOCKS_PER_SEC  << endl;

  int freeze;
  cin >> freeze;

  return 0;
}


