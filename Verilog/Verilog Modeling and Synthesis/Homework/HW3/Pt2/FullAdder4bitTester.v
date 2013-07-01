// Carlos Lazo
// ECE574
// Homework #3

// Part 2: Full Adder, 4 bit testbench implementation.

`timescale 1ns/100ps

module FullAdder4bitTester;
  
  // Define a parameter so that the adder can be any size:
  
  parameter SIZE = 4;
   
  // Declare all inputs as reg and outputs as wire:
  
  reg  [SIZE-1:0] a, b;
  reg  cin;
  
  wire [SIZE-1:0] s;
  wire cout;
  
  // Instantiate a FullAdder4bit:
  
  FullAdder4bit UUT (a,b,cin,s,cout);
    
  // Define a parameter to choose the appropriate simulation:
  
  parameter SIM_CHOICE = 1;
  
  // Create the testbench sequences:
  
  initial begin
    
    // Simulation #1:
    
    // Add the values a = 0011 and b = 1100 with cin = 0:
    // Result should be s = 1111, cout = 0.
    
    if (SIM_CHOICE == 1) begin
      
      a   <= 4'b0011;      
      b   <= 4'b1100;
      cin <= 0;
      
      // End testbench simulation.
      
      #50;
      
    end 

    // Simulation #2:
    
    // Add the values a = 0111 and b = 0000 with cin = 1:
    // Result should be s = 1000, cout = 0.
      
    else if (SIM_CHOICE == 2) begin
      
      a   <= 4'b0111;
      b   <= 4'b0000;
      cin <= 1;
    
      // End testbench simulation.
      
      #50;
      
    end
         
    // Simulation #3:
    
    // Add the values a = 1111 and b = 1111 with cin = 0:
    // Result should be s = 1110, cout = 1.
    
    else if (SIM_CHOICE == 3) begin
      
      a   <= 4'b1111;
      b   <= 4'b1111;
      cin <= 0;
      
      // End testbench simulation.
      
      #50;
      
    end
    
    // Simulation #4:
    
    // Add the values a = 0011 and b = 1100 with cin = 1:
    // Result should be s = 0000, cout = 1.
    // This will produce the WORST CASE circuit delay.
    
    else if (SIM_CHOICE == 4) begin
      
      a   <= 4'b0011;      
      b   <= 4'b1100;
      cin <= 1;
      
      // End testbench simulation.
      
      #50;
      
    end  
    
    else begin
      $display ("An invalid number was chosen for SIM_CHOICE.");      
    end
    
  end
    
endmodule