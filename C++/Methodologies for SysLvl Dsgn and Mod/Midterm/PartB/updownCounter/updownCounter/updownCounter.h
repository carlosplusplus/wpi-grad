// Carlos Lazo
// ECE579D
// Midterm Exam - Part B

#include "logicPrimitives.h"

// Define the updownCounter Class

class updownCounter {

  private: 

    // Declare all private member variables of the updownCounter:

    char qout [3];
    char c_clk, c_rst, c_ud;
    
    wire clk, rst, ud;

    int t_Delay;

    string in_str;  // Stores input string for printing
    string pr_dff;  // Stores previous flip flop values

    dff    reg [3]; // DFF's that make up updownCounter 
    wire dTemp [3]; // Define temp DFF wires for computation

  public:

    // Public functions that will be executed in order:

    updownCounter();    // Default Constructor

    void load_input (string);   // Parse input string into member variables.
    void update_reg();  // Based on ud mode, update counter accordingly.
    void set_output();  // Set all DFF's, based on clock and reset signals.
    string output_reg();// Formatted output generated for the updownCounter.

};