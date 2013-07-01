// Carlos Lazo
// ECE579D
// Final Exam - Problem 4

#define SC_INCLUDE_DYNAMIC_PROCESSES

#include "common_header.h"

template<unsigned int N_TARGETS, unsigned int N_INITIATORS>
struct Switch:sc_module
{
  tlm_utils::simple_target_socket_tagged<Switch>*    targ_socket[N_INITIATORS];
	tlm_utils::simple_initiator_socket_tagged<Switch>* init_socket[N_TARGETS];

  SC_CTOR(Switch)
  {

    // Set the number of incoming socket connections (= 1)

    for (unsigned int i = 0; i < N_INITIATORS; i++)
		{
			char txt[20];
			sprintf(txt, "targ_socket_%d", i);
			targ_socket[i] = new tlm_utils::simple_target_socket_tagged<Switch>(txt);
			targ_socket[i]->register_b_transport(       this, &Switch::b_transport, i);
		}

    // Set the number of outgoing socket connections (= 2)

		for (unsigned int i = 0; i < N_TARGETS; i++)
		{
			char txt[20];
			sprintf(txt, "init_socket_%d", i);
			init_socket[i] = new tlm_utils::simple_initiator_socket_tagged<Switch>(txt);
		}
  }

  // Define an overloaded b_transport that takes ID into account for the Reader.

  virtual void b_transport( int id, tlm::tlm_generic_payload& trans, sc_time& delay )
	{

    int target_nr = 0;

    sc_dt::uint64 address = trans.get_address();

    // If address is ODD, go to Memory1.  Else, Memory2.

    if ((address / 16) % 2 == 1)
      target_nr = 0;
    else
      target_nr = 1;

    // If ID is defined as Reader (ID = 0), select which memory socket chosen.

		if (id == 0)
    {
      cout << "\tIn Switch b_transport. Target memory chosen is Memory" << (target_nr + 1) << endl;

			(*init_socket[target_nr])->b_transport(trans, delay);
		}
	}
};