// Carlos Lazo
// ECE579D
// Final Exam - Problem 4

#define SC_INCLUDE_DYNAMIC_PROCESSES

#include "systemc"
#include "common_header.h"

using namespace sc_core;
using namespace std;

struct Reader : sc_module
{
  tlm_utils::simple_initiator_socket<Reader> socket;

  SC_CTOR(Reader) : socket("readerSocket")
  {
    SC_THREAD(thread_process);
  }

  void thread_process()
  {

    cout << " - Initiating Reader thread process -\n\n";

    tlm::tlm_generic_payload* trans = new tlm::tlm_generic_payload;
    tlm::tlm_command cmd;

		sc_time delay = sc_time(8, SC_PS);

    string in_buf;  // To be used for initial data input.
    string a_str;   // Address string.
    string d_str;   // Data string.

    int a_int;      // Integer form of address.
    int d_int;      // Integer form of data;

    // Continue while loop for as long as information can be read in.

    while (getline(in_data,in_buf))
    {
      cout << "* Instruction read in = " << in_buf << "\n\n";

      // If in_buf[0] == R, then this is a READ command.
      // If not, then it is a WRITE command.

      if (in_buf[0] == 'R')
      {
        cout << "\tIn Reader thread: This is a READ command.\n";
        cmd = tlm::TLM_READ_COMMAND;
      }

      else
      {
        cout << "\tIn Reader thread: This is a WRITE command.\n";
        cmd = tlm::TLM_WRITE_COMMAND;
      }

      // Define address and data strings based on command.

      a_str = in_buf.substr(2,2);

      if (in_buf[0] == 'R')
        d_str = "";
      else
        d_str = in_buf.substr(5,in_buf.size()-5);

      cout << "\t\ta_str = " << a_str << ", and d_str = " << d_str << endl;

      // Now convert strings into their integer representations.

      sscanf(a_str.c_str(), "%x", &a_int);
      sscanf(d_str.c_str(), "%x", &d_int);

      cout << "\t\ta_int = " << a_int << ", and d_int = " << d_int << endl;

      // Setup b_transport package and send to Switch.

      trans->set_command(cmd);
      trans->set_address(a_int * 16);
      trans->set_data_ptr( reinterpret_cast<unsigned char*>(&d_int) );
      // Modify data_length to 16 bits
				  trans->set_data_length( 16 );
      // Modify data_streaming_width to 16 bits
				  trans->set_streaming_width( 16 ); // = data_length to indicate no streaming
      trans->set_byte_enable_ptr( 0 ); // 0 indicates unused
				trans->set_dmi_allowed( false ); // Mandatory initial value
				trans->set_response_status( tlm::TLM_INCOMPLETE_RESPONSE ); // Mandatory initial value
      
      // Send information to the Switch via b_transport:
      
      socket->b_transport(*trans, delay );  // Blocking transport call.
    }
  }
};