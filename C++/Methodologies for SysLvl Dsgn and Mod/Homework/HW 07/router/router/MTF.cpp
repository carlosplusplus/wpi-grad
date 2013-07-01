// Carlos Lazo
// ECE579D
// Homework 07

#define SC_INCLUDE_DYNAMIC_PROCESSES

#include "common_header.h"

extern sc_signal<bool> mtfAllowed;

struct MTF: sc_module
{
	int mem[256];
	int* buffer;
	bool dmi_ptr_valid;
	tlm::tlm_dmi dmi_data;

	tlm_utils::simple_initiator_socket<MTF> socket;

	SC_CTOR(MTF)
	: socket("MTFSocket")
	{
		buffer = new int[256];
		SC_THREAD(thread_process);
	}

	void thread_process()
	{
    cout << "Initiate MTF [BWT] (thread process):" << endl;

		int data = 0;
		tlm::tlm_command cmd;
		tlm::tlm_generic_payload* trans = new tlm::tlm_generic_payload;
		sc_time delay = sc_time(8, SC_PS);

		wait(mtfAllowed.default_event());

		if(mtfAllowed == true){

      cout << "\n**************************************************\n";
      cout << "* BEGIN READ FROM MEMORY, WRITE TO MTF LOCAL MEM *\n";
      cout << "**************************************************\n\n";

			for (int i = 0; i < 256; i += 8)
			{
				cmd = tlm::TLM_READ_COMMAND;

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

				fout << "From MTF: at "<< sc_time_stamp()<<"	"<< "	delay=  "<< delay  << "	address:	"<< hex << i << "	" << name() << "		new, cmd=" << (cmd ? 'W' : 'R')
			    << ", data=" << hex << data << endl;

				socket->b_transport( *trans, delay );  // Blocking transport call
				if ( trans->is_response_error() )
				{
					char txt[100];
					sprintf(txt, "Error from b_transport, response status = %s",
					trans->get_response_string().c_str());
				}
				if ( trans->is_response_ok())
				{
					char txt[100];
					sprintf(txt, "ok from b_transport in process 1 , response status = %s",
					trans->get_response_string().c_str());
					unsigned char*   ptr = trans->get_data_ptr();
					memcpy(&mem[i/8], ptr, 8);
				}

        cout << "From MTF:\tTrans = { " << (cmd ? 'W' : 'R') << ", " << hex << i
				<< " } , data = " << hex << data << " at time " << sc_time_stamp() << endl;

			}

      cout << "\n************************************************\n";
      cout << "* END READ FROM MEMORY, WRITE TO MTF LOCAL MEM *\n";
      cout << "************************************************\n\n";

      cout << "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" << endl;
      cout << "!!! ENTER BWT Calculation !!!" << endl;
      cout << "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" << endl << endl;

			buffer = MTF_(mem);

      cout << "!!!!!!!!!!!!!!!!!!!!!!!!!!!!" << endl;
      cout << "!!! EXIT BWT Calculation !!!" << endl;
      cout << "!!!!!!!!!!!!!!!!!!!!!!!!!!!!" << endl << endl;

      /*

      cout << "What string does buffer have in it?\n" << endl;

      for (int i = 0; i < 256; i += 1)
        cout << buffer[i];

      cout << endl << endl;

      */

      data = 0;

      cout << "\n****************************************************\n";
      cout << "* BEGIN WRITE TO MEMORY, AFTER MTF (BWT ALGO) DONE *\n";
      cout << "****************************************************\n\n";

			for (int i = 0; i < 256; i += 8)
			{

        // Begin by converting each 8bit word into an 8bit string.
        string base_str = "";

        for (int j = i; j < i+8; j++)
          base_str += bitset<1>(buffer[j]).to_string();  // Convert each int to str.

        data = bitset<32>(base_str).to_ulong();

        cout << "DATA TO WRITE: " << base_str << "\tIn HEX: " << data << endl;

				cmd = tlm::TLM_WRITE_COMMAND;

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

        fout << "From MTF: at	"<< sc_time_stamp()<<"	"<< "	delay=  "<< delay  << "	address:	"<< hex << i << "	" << name() << "	new, cmd=" << (cmd ? 'W' : 'R')
			    << ", data=" << hex << data << endl;

				socket->b_transport( *trans, delay );  // Blocking transport call
				if ( trans->is_response_error() )
				{
					char txt[100];
					sprintf(txt, "Error from b_transport, response status = %s",
					trans->get_response_string().c_str());
				}
				if ( trans->is_response_ok())
				{
					char txt[100];
					sprintf(txt, "ok from b_transport in process 1 , response status = %s",
					trans->get_response_string().c_str());
				}
				cout << "From MTF:\ntrans = { " << (cmd ? 'W' : 'R') << ", " << hex << trans->get_address()
				<< " } , data = " << hex << data << " at time " << sc_time_stamp()+ delay << endl << endl;

			}

      cout << "**************************************************\n";
      cout << "* END WRITE TO MEMORY, AFTER MTF (BWT ALGO) DONE *\n";
      cout << "**************************************************\n\n"; 
		}
	}

  // Define the MTF function, which now performs BWT:

	int* MTF_(int* mem)
  {
		// FIRST, convert the memory received into a 256 bit local string:

    string base_str = "";

    for (int i = 0; i < 32; i++)
      base_str += bitset<8>(mem[i]).to_string();  // Convert each int to str
 
    cout << "Base string from MEM = \n\n" << base_str << "\n\n";

		// SECOND, create all rotations for this string. Output rotations to external file.

    // Open external file to output all rotations:

    ofstream rt_out("BWT_rotations.txt");

    vector <string> base_rt (256);

    base_rt[0]     = base_str;
    string itr_str = base_str;

    rt_out << "Start BWT Base String Rotations:\n\n";
    rt_out << "Rotation 1:\n" << base_rt[0] << endl << endl;

    for (int i = 1; i < 256; i++)
    {
      // Create rotation from current itr_str and set in vector:
      rotate(itr_str.begin(), itr_str.begin()+1, itr_str.end());
      base_rt[i] = itr_str;

      rt_out << "Rotation " << (i+1) << ":\n" << base_rt[i] << endl << endl;
    }

    // THIRD, sort all rotations, and generate BWT Transform output from last element of rows.

    sort(base_rt.begin(), base_rt.end());

    cout << "Sorted BWT Rotations Generated and Output to: BWT_Rotations.txt\n\n";

    rt_out << "***********************************\n";
    rt_out << "* SORTED BWT Rotations Generated: *\n";
    rt_out << "***********************************\n\n";

    for (int i = 0; i < 256; i++)
      rt_out << base_rt[i] << endl << endl;

    rt_out << endl << endl;

    rt_out << "*************************\n";
    rt_out << "* ENCODED BWT ROTATION: *\n";
    rt_out << "*************************\n\n";

    cout << "Encoded BWT Output string from vector of sorted strings:\n\n";

    // Create encoded BWT Output from the last character of vector of sorted strings:
    for (int i = 0; i < 256; i++)
    {
      if (base_rt[i][255] == '0')
        buffer[i] = 0;
      else if (base_rt[i][255] == '1')
        buffer[i] = 1;
      else
        buffer[i] = 2;

      cout   << buffer[i];
      rt_out << buffer[i];
    }

    cout << endl << endl;

    rt_out.close();

    return buffer;

	}

};