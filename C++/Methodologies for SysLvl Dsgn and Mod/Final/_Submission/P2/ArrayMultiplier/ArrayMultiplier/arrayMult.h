// Carlos Lazo
// ECE579D
// Final Exam - Problem 2

#include "logicPrimitives.h"

// Define the arrayMult Class

class arrayMult {

  private:

    // Declare all private member variables of the 4x4 Array Multiplier:

    wire x_in [4];    // Input X wires.
    wire y_in [4];    // Input Y wires.
    wire po   [8];    // Declare output wires.

    string x_str, y_str, result;

  public:

    void load_input (string x, string y); // Load input wires.
    void MULT();                          // Perform array multiplication.
    void output_result ();              // Output multiplication result.

};



