// Carlos Lazo
// ECE579D
// Homework 03

#include <fstream>
#include <iostream>
#include <string>

using namespace std;

// Define the D-Flip Flop Class

class DFF {
  private:
    char Q;

  public:
    DFF();                      // Default Constructor

    void set (char, char, char); // Used to set DFF

    char get_Q() { return Q; }  // Function to return Q;
};

// Define the ShiftRegister Class

class ShiftRegister {

  private: 

    // Declare all private member variables of the Shift Register:

    char din   [9]; // Parallel input
    char pout  [9]; // Parallel output
    char clk, rst, m1, m0, sri, sli;

    string in_str;  // Stores input string for printing
    string pr_dff;  // Stores previous flip flop values

    DFF    reg [8]; // DFF's that make up Shift Register 
    char dTemp [9]; // Define temp DFF chars for computation

  public:

    // Public functions that will be executed in order:

    ShiftRegister();      // Default Constructor

    void load_input (string);   // Parse input string into private member variables
    void update_reg();          // Based on m1m0 mode, update register accordingly
    void set_output();          // Set all DFF's, based on clock and reset signals.
    string output_reg();        // Formatted output generated for the Shift Register.

};
