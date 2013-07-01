// Carlos Lazo
// ECE574
// Homework #6

// Part 4: 8-bit 2's Compliment Multiplier
//         Faulty Model Testbench

`timescale 1ns/100ps

module multTester;

  // Define inputs and outputs:
  
  reg [7:0] a, b;
  reg start, clk;
  
  wire [15:0] r;
  wire done;
  
  mult MUT (a, b, start, clk, r, done);
  
  // Define test bench initial values.
  
  initial begin
    
    a = 8'b00000000;
    b = 8'b00000000;
    
    clk   = 0;
    start = 0;
    
  end
  
  // Develop an Interactive Testbench.
  
  // It will wait for done = 1 before performing a multiplication.
  // This will happen a total of 20 times before the simulation ends.
  
  initial begin
    
    repeat (20) begin
      
      wait (done == 1'b0);
      wait (done == 1'b1);
      
      a <= $random;
      b <= $random;
      
    end
    
    #25; $finish;
    
  end
  
  // Generate the start pulse train.

  always begin
    
    start <= 1;
    
    @ (posedge clk);
    @ (negedge clk);
    
    start <= 0;
    
    @ (posedge clk);
    @ (negedge clk);
    
    @ (posedge clk);
    @ (negedge clk);
    
  end
  
  // Generate the clock pulse train.
    
  always #3 clk = ~clk;
  
endmodule