// Carlos Lazo
// ECE579D
// Homework 07

#define SC_INCLUDE_DYNAMIC_PROCESSES

#include "common_header.h"

template<unsigned int N_TARGETS, unsigned int N_INITIATORS>
struct Switch: sc_module
{
	tlm_utils::simple_target_socket_tagged<Switch>*    targ_socket[N_INITIATORS];
	tlm_utils::simple_initiator_socket_tagged<Switch>* init_socket[N_TARGETS];

	int writerCounter;
	int MTFCounter;
	int runCounter;
	int readCounter;
	int* startAdr;

	SC_CTOR(Switch)
	{
		writerCounter = 0;
		MTFCounter = 0;
		runCounter = 0;
		readCounter = 0;

		startAdr = new int[N_INITIATORS];

    // Updated start addresses of operations based on new memory layout.

		startAdr[0] = 0;    //startAdr[0] = 0;
		startAdr[1] = 256;  //startAdr[1] = 16;
		startAdr[2] = 512;  //startAdr[2] = 32;
		startAdr[3] = 512;  //startAdr[3] = 32;

		for (unsigned int i = 0; i < N_INITIATORS; i++)
		{
			char txt[20];
			sprintf(txt, "targ_socket_%d", i);
			targ_socket[i] = new tlm_utils::simple_target_socket_tagged<Switch>(txt);
			targ_socket[i]->register_b_transport(       this, &Switch::b_transport, i);
		}
		for (unsigned int i = 0; i < N_TARGETS; i++)
		{
			char txt[20];
			sprintf(txt, "init_socket_%d", i);
			init_socket[i] = new tlm_utils::simple_initiator_socket_tagged<Switch>(txt);
		}
	}

	virtual void b_transport( int id, tlm::tlm_generic_payload& trans, sc_time& delay )
	{
		int target_nr = 0;
		sc_dt::uint64 address = trans.get_address();
		sc_dt::uint64 read_address = 0;
		sc_dt::uint64 write_address = 0 ;
		decode_address( address, read_address, write_address, id, startAdr[id]);

		if(id == 0){//Writer
			writeAllowed = true;
			trans.set_address(write_address);
			(*init_socket[target_nr])->b_transport(trans, delay);

      cout << "\tID is: " << id << " - After calling b_transport in Switch: " << endl;
			if(trans.is_response_ok() && writerCounter < startAdr[id + 1])
				writerCounter = writerCounter + 8;  // Change since now 8-bit words.
			if(trans.is_response_ok() && writerCounter >= startAdr[id + 1]){
				writeAllowed = false;
				mtfAllowed = true;
			}
		}
		else if(id == 1){//mtf
			if(mtfAllowed == true){
				if(trans.get_command() == tlm::TLM_WRITE_COMMAND)
					trans.set_address( write_address );
				if(trans.get_command() == tlm::TLM_READ_COMMAND)
					trans.set_address(read_address);
				(*init_socket[target_nr])->b_transport(trans, delay);

        cout << "\tID is: " << id << " - After calling b_transport in Switch: " << endl;
				if(trans.is_response_ok() && MTFCounter < startAdr[id + 1])
					MTFCounter = MTFCounter + 8;      // Change since now 8-bit words.
				if(trans.is_response_ok() && MTFCounter >= startAdr[id + 1]){
					runAllowed.write(true);
				}
			}
		}
		else if(id == 2){//runL
			if(runAllowed == true){
				if(trans.get_command() == tlm::TLM_WRITE_COMMAND)
					trans.set_address( write_address );
				if(trans.get_command() == tlm::TLM_READ_COMMAND)
					trans.set_address(read_address);

				(*init_socket[target_nr])->b_transport(trans, delay);

        //cout << "\tID is: " << id << " - After calling b_transport in Switch: " << endl;
				if(trans.is_response_ok() && runCounter < startAdr[id + 1])
					runCounter = runCounter + 8;      // Change since now 8-bit words.
				if(trans.is_response_ok() && runCounter >= startAdr[id + 1]- startAdr[id]){
					readAllowed.write(true);
				}
			}
		}
		else if(id == 3){//Reader
			if(readAllowed == true){
				if(trans.get_command() == tlm::TLM_READ_COMMAND)
					trans.set_address(read_address );
				(*init_socket[target_nr])->b_transport(trans, delay);

        //cout << "\tID is: " << id << " - After calling b_transport in Switch: " << endl;
				if(readCounter <= startAdr[id]- startAdr[id - 1]){
					readCounter = readCounter + 8;    // Change since now 8-bit words.
					trans.set_response_status(tlm::TLM_INCOMPLETE_RESPONSE);
				}
				else if(readCounter > startAdr[id]- startAdr[id - 1]){
					trans.set_response_status(tlm::TLM_OK_RESPONSE);
				}
			}
			else
				trans.set_response_status(tlm::TLM_INCOMPLETE_RESPONSE);
		}

	}

	inline void decode_address( sc_dt::uint64 address, sc_dt::uint64& read_address, sc_dt::uint64& write_address, sc_dt::uint64 index, sc_dt::uint64 offset )
	{
		write_address = address + startAdr[index];
		if(index != 0)
			read_address = address + startAdr[index - 1];
	}
};




