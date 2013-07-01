// Carlos Lazo
// ECE574
// Homework #2, Part 1

// This file is the tester for the Pre & Post synthesis
// simulations of the Blocking & Non-Blocking assignments.

`timescale 1ns/100ps

module HW2Pt1Tester;
  
  reg clk;
  reg [7:0] input_B_NB;
  
  // Define all outputs as wires.
  
  wire [7:0] aNB_Pre , bNB_Pre , aB_Pre ,  bB_Pre;
  wire [7:0] aNB_Post, bNB_Post, aB_Post, bB_Post;
  
  // Instantiate both Pre_Synthesis and Post_Synthesis
  // versions of the Blocking & NonBlocking code.
  
  HW2Pt1   Pre_Synth  (clk, input_B_NB, input_B_NB,
                    aNB_Pre , bNB_Pre , aB_Pre ,  bB_Pre);
                    
  HW2Pt1PS Post_Synth (clk, input_B_NB, input_B_NB,
                    aNB_Post, bNB_Post, aB_Post, bB_Post);
                    
  // Set clock to start at 0 and input_B_NB to all 0's.
                    
  initial begin
    clk = 0; input_B_NB = 0;
  end
  
  // Repeat the clock for a total of 50 cycles.
  
  initial repeat (50) #7 clk = ~clk;
  
  // Create a pseudo-randomized input changing sequence that flips
  // the input bits at different frequencies.
  
  initial repeat (20) #15  input_B_NB   [2] = ~input_B_NB [2];
  initial repeat (18) #20  input_B_NB [8:6] = ~input_B_NB [8:6];
  initial repeat (30) #10  input_B_NB [4:3] = ~input_B_NB [4:3];             
                   
endmodule