// Carlos Lazo
// ECE579D
// Homework 03

#include <fstream>
#include <iostream>
#include <string>

using namespace std;

// Define a 3-input AND gate

class and {
  char i1, i2, i3, o1;
  
  public:
    and () {o1 = 'X';}
    void inp (char a, char b, char c) {i1 = a; i2 = b; i3 = c;}
    void evl ();
    void out (char& w) {w=o1;}
    char getV () {return o1;}
};

// Define a 4-input OR gate

class or {
  char i1, i2, i3, i4, o1;
  
  public:
    or () {o1 = 'X';}
    void inp (char a, char b, char c, char d) {i1 = a; i2 = b; i3 = c; i4 = d;}
    void evl ();
    void out (char& w) {w=o1;}
    char getV () {return o1;}
};

// Define the NOT gate

class not {
  char i1, o1;

  public:
    not () {o1 = 'X';}
    void inp (char a) {i1 = a;}
    void evl ();
    void out (char& w) {w=o1;}
    char getV () {return o1;}
};

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