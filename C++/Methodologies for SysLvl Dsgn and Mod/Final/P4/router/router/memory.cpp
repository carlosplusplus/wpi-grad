// Carlos Lazo
// ECE579D
// Final Exam - Problem 4

#define SC_INCLUDE_DYNAMIC_PROCESSES

#include "common_header.h"

template<unsigned int id>
struct Memory: sc_module
{
	tlm_utils::simple_target_socket<Memory> socket;

	enum { SIZE = 4096 };    // Increase memory size to 4096 elements
	const sc_time LATENCY;

	SC_CTOR(Memory)
	: socket("socket"), LATENCY(0, SC_PS)
	{
		socket.register_b_transport(       this, &Memory::b_transport);
		
    for (int i = 0; i < SIZE; i++)
		  mem[i] = 0;

    // Link memory instance to an output file.

    out_id = id;

    if (out_id == 1)
      out.open("Out1.txt");
    if (out_id == 2)
      out.open("Out2.txt");
    
	}

	virtual void b_transport( tlm::tlm_generic_payload& trans, sc_time& delay )
	{
		tlm::tlm_command cmd = trans.get_command();
		unsigned int     adr = trans.get_address();       // Change since now 8-bit words.
		unsigned char*   ptr = trans.get_data_ptr();
		unsigned int     len = trans.get_data_length();
		unsigned char*   byt = trans.get_byte_enable_ptr();
		unsigned int     wid = trans.get_streaming_width();

		delay = SC_ZERO_TIME;

    // If TLM Command == READ, output information @ mem[adr] to external file.
    // Choose the correct external file.

		if ( cmd == tlm::TLM_READ_COMMAND )
    {
      cout << "\tIn Memory b_transport.  A READ operation is being performed.\n";

      unsigned int a_int = adr / 16;
      unsigned int d_int = mem[adr];

      cout << "\t\ta_int = " << a_int << ", and d_int = " << d_int << endl;

      char a_buf [32];
      char d_buf [32];

      itoa(a_int,a_buf,16);
      itoa(d_int,d_buf,16);

      string a_str(a_buf);
      string d_str(d_buf);

      // If address/data is a single memory element, append 0 to the front.

      if (a_str.size() == 1)
        a_str = "0" + a_str;

      if (d_str.size() == 1)
        d_str = "0" + d_str;

      cout << "\t\ta_str = " << a_str << ", and d_str = " << d_str << endl;

      // Output to respective memory element based on address parity:

      if (out_id == 1)
      {
        cout << "\tOutput address and data info to Out1.txt\n\n";
        out << a_str << " " << d_str << endl;
      }

      if (out_id == 2)
      {
        cout << "\tOutput address and data info to Out2.txt\n\n";
        out << a_str << " " << d_str << endl;
      }
    }

		else if ( cmd == tlm::TLM_WRITE_COMMAND )
    {
      cout << "\tIn Memory b_transport.  A WRITE operation is being performed.\n\n";
			memcpy(&mem[adr], ptr, len);
    }
	}

	int mem[SIZE];
  int out_id;
  ofstream out;
};