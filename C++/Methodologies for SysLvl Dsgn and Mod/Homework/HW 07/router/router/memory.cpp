// Carlos Lazo
// ECE579D
// Homework 07

#define SC_INCLUDE_DYNAMIC_PROCESSES

#include "common_header.h"

struct Memory: sc_module
{
	tlm_utils::simple_target_socket<Memory> socket;

	enum { SIZE = 2048 };    // Increase memory size to 2048 elements
	const sc_time LATENCY;

	SC_CTOR(Memory)
	: socket("socket"), LATENCY(0, SC_PS)
	{
		socket.register_b_transport(       this, &Memory::b_transport);
		for (int i = 0; i < SIZE; i++)
		mem[i] = 0;
		++mem_nr;
	}

	virtual void b_transport( tlm::tlm_generic_payload& trans, sc_time& delay )
	{
		tlm::tlm_command cmd = trans.get_command();
		sc_dt::uint64    adr = trans.get_address() / 8;       // Change since now 8-bit words.
		unsigned char*   ptr = trans.get_data_ptr();
		unsigned int     len = trans.get_data_length();
		unsigned char*   byt = trans.get_byte_enable_ptr();
		unsigned int     wid = trans.get_streaming_width();

		delay = SC_ZERO_TIME;

		if ( cmd == tlm::TLM_READ_COMMAND )
			memcpy(ptr, &mem[adr], len);
		else if ( cmd == tlm::TLM_WRITE_COMMAND )
			memcpy(&mem[adr], ptr, len);

		if ( cmd == tlm::TLM_READ_COMMAND )
        {
          fout << "at	"<< sc_time_stamp()<<"	"<< "	delay=  "<< delay  << "	address:	"<<hex << adr << "	" << name() << "	Execute READ,	target = " << name()
               << "	data = " << *reinterpret_cast<int*>(ptr) << endl;
        }
        else if ( cmd == tlm::TLM_WRITE_COMMAND )
          fout << "at	"<< sc_time_stamp()<<"	"<< "	delay=  "<< delay  << "	address:	"<< hex << adr << "	" << name() << "	Execute WRITE,	target = " << name()
               << "	data = " << *reinterpret_cast<int*>(ptr) << endl;

		trans.set_dmi_allowed(false);
		trans.set_response_status( tlm::TLM_OK_RESPONSE );
	}
	int mem[SIZE];
	static unsigned int mem_nr;
};