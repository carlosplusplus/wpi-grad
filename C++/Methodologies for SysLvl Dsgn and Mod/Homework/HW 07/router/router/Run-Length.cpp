// Carlos Lazo
// ECE579D
// Homework 07

#define SC_INCLUDE_DYNAMIC_PROCESSES

#include "systemc"

#include "common_header.h"

extern sc_signal<bool> runAllowed;
extern int compressedLen;

struct RunLength: sc_module
{

	tlm_utils::simple_initiator_socket<RunLength> socket;
	string compressedSt;

	SC_CTOR(RunLength)
	: socket("RunLengthSocket")
	{
		buffer = new int[256];
		compressedSt = "";
		SC_THREAD(thread_process);
	}

	void thread_process()
	{
    cout << "Initiate RunLength (thread process):" << endl;

		int data = 0;
		tlm::tlm_command cmd;
		tlm::tlm_generic_payload* trans = new tlm::tlm_generic_payload;
		sc_time delay = sc_time(8, SC_PS);

		wait(runAllowed.default_event());
		if(runAllowed == true){

      cout << "\n**************************************************\n";
      cout << "* BEGIN READ FROM MEMORY, WRITE TO RLE LOCAL MEM *\n";
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

				fout << "at	"<< sc_time_stamp()<<"	"<< "	delay=  "<< delay  << "	address:	"<< hex << i << "	" << name() << "	new, cmd=" << (cmd ? 'W' : 'R')
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
        cout << "From RLE:\ttrans = { " << (cmd ? 'W' : 'R') << ", " << hex << trans->get_address()
				<< " } , data = " << hex << data << " at time " << sc_time_stamp()+ delay << endl;

			}

      cout << "\n************************************************\n";
      cout << "* END READ FROM MEMORY, WRITE TO RLE LOCAL MEM *\n";
      cout << "************************************************\n\n";

      cout << "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" << endl;
      cout << "!!! ENTER RLE Calculation !!!" << endl;
      cout << "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" << endl << endl;

			compressedSt = RunLength_(mem);

      cout << "!!!!!!!!!!!!!!!!!!!!!!!!!!!!" << endl;
      cout << "!!! EXIT RLE Calculation !!!" << endl;
      cout << "!!!!!!!!!!!!!!!!!!!!!!!!!!!!" << endl << endl;

			data = 0;

      cout << "\n************************************\n";
      cout << "* BEGIN WRITE TO MEMORY, AFTER RLE *\n";
      cout << "************************************\n\n";

      compressedLen = compressedSt.length(); // Store size of compression string to pull from memory.

      cout << "Length of COMPRESSED string from RLE = " << compressedLen << endl << endl;

      // In this case, send one hexadecimal bit at a time:

      for (int i = 0; i < compressedLen; i++)
      {
        data = bitset<4>(compressedSt[i]).to_ulong();

        cmd = tlm::TLM_WRITE_COMMAND;

			  trans->set_command( cmd );
			  trans->set_address( i*8 );
        trans->set_data_ptr(reinterpret_cast<unsigned char*>(&data) );
			  trans->set_data_length( 1 );
			  trans->set_streaming_width( 1 ); // = data_length to indicate no streaming
			  trans->set_byte_enable_ptr( 0 ); // 0 indicates unused
			  trans->set_dmi_allowed( false ); // Mandatory initial value
			  trans->set_response_status( tlm::TLM_INCOMPLETE_RESPONSE ); // Mandatory initial value

        fout << "From RLE: at	"<< sc_time_stamp()<<"	"<< "	delay=  "<< delay  << "	address:" << dec << i << "	" << name() << "	new, cmd=" << (cmd ? 'W' : 'R')
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
        cout << "From RLE: trans = { " << (cmd ? 'W' : 'R') << ", " << dec << trans->get_address()
			  << " } , data =" << hex << data << " at time " << sc_time_stamp()+ delay << ", i = " << dec << i << endl;

      }

      cout << "\n**********************************\n";
      cout << "* END WRITE TO MEMORY, AFTER RLE *\n";
      cout << "**********************************\n\n";
		}
	}

  // Program the Run-Length compression algorithm, using STL string class:

	string RunLength_(int* mem){
	
  // Convert the memory received into a 256 bit local string:

    string base_str = "";

    for (int i = 0; i < 32; i++)
      base_str += bitset<8>(mem[i]).to_string();  //Convert each int to str

    cout << "Base string is:\n" << base_str << endl << endl;

    // Perform Run-Length Encoding (RLE) on the base string:

    bool IS_0 = false;
    char IS_1 = false;
    int runLength = 1;
    int ptr = 0;

    while (ptr < 256)
    {
      stringstream convStr;
      string concat = "";

      // Determine whether this current run is of 0's or 1's:

      if (base_str.at(ptr) == '0') IS_0 = true;
      else IS_1 = true;

      // Begin accumulation of runs:

      while (((ptr + 1) < 256) && (base_str.at(ptr) == base_str.at(ptr+1)))
      {
        runLength++;
        ptr++;

        //cout << "Current runLength = " << dec << runLength << ", and ptr = " << dec << ptr << endl;
      }

      // Now append runLength and actual character to the compressedSt:

      convStr << runLength;
      concat  = convStr.str();

      compressedSt += concat;

      //cout << "CURRENT compressedStr = " << compressedSt << endl;

      if (IS_0) compressedSt += "0";
      if (IS_1) compressedSt += "1";

      // Reset all variables and increment pointer variable.

      IS_0 = false; IS_1 = false; runLength = 1; ptr++; convStr.clear();

      //cout << "Current runLength = " << dec << runLength << ", and ptr = " << dec << ptr << endl;
    }

    cout << "\nFINAL Compressed string is: \n" << compressedSt << endl << endl;

		return compressedSt;
	}

	int mem[256];
	int* buffer;
	bool dmi_ptr_valid;
	tlm::tlm_dmi dmi_data;
};


