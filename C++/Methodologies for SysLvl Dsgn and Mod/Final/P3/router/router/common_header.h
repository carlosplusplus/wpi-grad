// Carlos Lazo
// ECE579D
// Homework 07

#ifndef __COMMON_HEADER_H__
#define __COMMON_HEADER_H__

#define SC_INCLUDE_DYNAMIC_PROCESSES

#include "systemc"
using namespace sc_core;
using namespace sc_dt;
using namespace std;

#include "tlm.h"
#include "tlm_utils/simple_initiator_socket.h"
#include "tlm_utils/simple_target_socket.h"
#include "tlm_utils/passthrough_target_socket.h"
#include "tlm_utils/multi_passthrough_initiator_socket.h"
#include "tlm_utils/multi_passthrough_target_socket.h"
#include "tlm_utils/peq_with_cb_and_phase.h"
#include "tlm_utils/instance_specific_extensions.h"

#include <iomanip>
#include <deque>
#include <iostream>

// Added in iostream for C++ terminal debug output.
#include <iostream>
// Added in fstream to allow for external file read/write.
#include <fstream>
// Added in to make file-reading easier.
#include <bitset>
#include <string>
#include <sstream>
// Added in to facilitate string rotations
#include <algorithm>
#include <vector>
// Allows for viewing of commands that access memory (R/W)
static ofstream fout("activity_file.txt");

#endif