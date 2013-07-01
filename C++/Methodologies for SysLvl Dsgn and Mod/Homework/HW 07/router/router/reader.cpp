// Carlos Lazo
// ECE579D
// Homework 07

#define SC_INCLUDE_DYNAMIC_PROCESSES

#include "systemc"

#include "common_header.h"

using namespace sc_core;
using namespace std;

extern sc_signal<bool> readAllowed;
extern int compressedLen;

struct Reader: sc_module
{
	tlm_utils::simple_initiator_socket<Reader> socket;

	SC_CTOR(Reader)
	: socket("readerSocket")
	{
		SC_THREAD(thread_process);
	}

	void thread_process()
	{
    cout << "Initiate Reader (thread process):" << endl;

		tlm::tlm_generic_payload* trans = new tlm::tlm_generic_payload;
		sc_time delay = sc_time(4, SC_PS);

		int readerAllowed = 1;
    int data = 0; int out_data = 0;

		wait(readAllowed.default_event());
		if(readAllowed == true){

    // Setup loop to retrieve all relevant information from the memory:

      int* out_buf = new int[compressedLen];

      for (int i = 0; i < compressedLen; i++)
      {				

				tlm::tlm_command cmd = tlm::TLM_READ_COMMAND;
				trans->set_command( cmd );
				trans->set_address( i*8 );
				trans->set_data_ptr( reinterpret_cast<unsigned char*>(&data) );
				trans->set_data_length( 1 );
				trans->set_streaming_width( 1 ); // = data_length to indicate no streaming
				trans->set_byte_enable_ptr( 0 ); // 0 indicates unused
				trans->set_dmi_allowed( false ); // Mandatory initial value
				trans->set_response_status( tlm::TLM_INCOMPLETE_RESPONSE ); // Mandatory initial value

        fout << "In Reader: at	"<< sc_time_stamp()<<"	"<< "	delay=  "<< delay  << "	address:	"<< dec << i << "	" << name() << "	new, cmd=" << (cmd ? 'W' : 'R')
			    << ", data=" << hex << data << endl;
				socket->b_transport( *trans, delay );  // Blocking transport call

        //cout << "In Writer: Data = " << hex << data << ", at address: " << dec << trans->get_address() << endl;
        
        cout << "In Reader: trans = { " << (cmd ? 'W' : 'R') << ", " << dec << trans->get_address()
				<< " } , data = " << dec << data << " at time " << sc_time_stamp()+ delay << endl;

        out_data = bitset<4>(data).to_ulong();

        out_buf[i] = out_data;
			}

      // Now output all data to external file:

      //fout.close();

      ofstream str_res("output.txt");

      str_res << "THE FINAL COMPRESSED STRING IS:\n\n";

      for (int k = 0; k < compressedLen; k++)
        str_res << out_buf[k];

      str_res.close();
		}
	}
};


