// Carlos Lazo
// ECE579D
// Homework 07

#define SC_INCLUDE_DYNAMIC_PROCESSES

#include "common_header.h"

extern sc_signal<bool> writeAllowed;

// The Writer socket is the 1st process that is called.
// It reads from an external file, then writes into memory.

struct Writer: sc_module
{
	tlm_utils::simple_initiator_socket<Writer> socket;

	SC_CTOR(Writer)
	: socket("writerSocket")
	{
		SC_THREAD(thread_process);
	}

	void thread_process()
	{
    cout << "Initiate Writer (thread process):\n\n";
  
		tlm::tlm_generic_payload* trans = new tlm::tlm_generic_payload;
		sc_time delay = sc_time(8, SC_PS);

		if(writeAllowed == true){

      cout << "\n***********************************************\n";
      cout << "* BEGIN READ FROM INPUT FILE, WRITE TO MEMORY *\n";
      cout << "***********************************************\n\n";

      // Declare a file from which to read character input:
      fstream in_data ("input.txt");

      // Updated for HW 07, since we now need 32, 8-bit words:
			for (int i = 0; i < 256; i += 8)
      {
				int data; string in_buf;

        cout << "Data IN: "; 

        // Read in each 8-bit word from an external input file:

        getline(in_data,in_buf);
        cout << in_buf << ",\t";

        data = bitset<32>(in_buf).to_ulong();

        cout << "Data HEX: " << data << endl;

        tlm::tlm_command cmd = tlm::TLM_WRITE_COMMAND;
				trans->set_command( cmd );
				trans->set_address( i );
				trans->set_data_ptr( reinterpret_cast<unsigned char*>(&data) );
        // Modify data_length to 8 bits
				  trans->set_data_length( 8 );
        // Modify data_streaming_width to 8 bits
				  trans->set_streaming_width( 8 ); // = data_length to indicate no streaming
				trans->set_byte_enable_ptr( 0 ); // 0 indicates unused
				trans->set_dmi_allowed( false ); // Mandatory initial value
				trans->set_response_status( tlm::TLM_INCOMPLETE_RESPONSE ); // Mandatory initial value

        fout << "From WRITER: at "<< sc_time_stamp()<<"	"<< "	delay=  "<< delay  << "	address:	"<< hex << i << "	" << name() << "	new, cmd=" << (cmd ? 'W' : 'R')
			    << ", data=" << hex << data << endl;
				socket->b_transport(*trans, delay );  // Blocking transport call
				if ( trans->is_response_error() )
				{
					char txt[100];
					sprintf(txt, "Error from b_transport, response status = %s",
					trans->get_response_string().c_str());
					SC_REPORT_ERROR("TLM-2", txt);
				}
        cout << "From WRITER:\n\tTrans = { " << (cmd ? 'W' : 'R') << ", " << hex << i
				<< " } , data = " << hex << data << " at time " << sc_time_stamp() << endl;

			}
		}

    cout << endl;
    cout << "*********************************************\n";
    cout << "* END READ FROM INPUT FILE, WRITE TO MEMORY *\n";
    cout << "*********************************************\n\n";

		wait(writeAllowed.default_event());
	}
};


