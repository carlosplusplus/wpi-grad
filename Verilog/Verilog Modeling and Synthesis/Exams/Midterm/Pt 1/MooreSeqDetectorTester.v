// Carlos Lazo
// ECE574
// Test 1

// Part 1: Moore Sequence Detector Tester: 11011 & 11101

`timescale 1ns/100ps

module MooreSeqDetectorTester;
  
  // Define all inputs and outputs of the system:
  
  parameter MAX = 4;            // Maximum number of input strings.
                                // Set to 4 input strings for this testbench.
  
  reg [0:15] inSeq  [0:MAX-1];  // Memory used to read in input strings.
  reg [0:15] outSeq [0:MAX-1];  // Memory used to keep track of output.
  
  reg clk, rst, a;              // Inputs of the system.
  integer bit_count, in_count;  // Counters used to keep track of memory locations.

  wire w;                       // Outputs of the system.
  integer outfile, i;           
  
  MooreSeqDetector UUT(a, clk, rst, w);    // Instantiation of Moore Detector.
  
  // Initialize all necessary values:
  
  initial begin
    
    a = 0;
      
    bit_count = 0;
    in_count  = 0;
    
    clk = 0;
    rst = 0;
    
    // Read in all binary data from intest.dat into inSeq memory
    
    $readmemb("intest.dat", inSeq);
    
  end
  
  // Perform operations at the positive edge of the clock:
  
  always @(posedge clk) begin
    
    // First, check to see if done with the input sequences.
    // If so, print all output to file and stop the simulation.
    
    if (in_count == MAX) begin
      
      outfile = $fopen("outtest.dat", "w");
    
      for (i=0; i<MAX; i=i+1)
        $fdisplayb(outfile, outSeq[i]);
        
      $fflush(outfile);
      $fclose(outfile);
      $stop;
      
    end
    
    // If not, proceed to the sequence analysis:
      
    else begin
      
      // On the positive edge of the clock, assign input a
      // to the 'current' bit in the 'current' input sequence.
  
      a = inSeq[in_count][bit_count];
      
      // Based on that input, store the current output w into
      // the output memory to be written later.
      
      outSeq[in_count][bit_count] = w;
      
      // Increment bit_count by 1 to progress through the input sequence.
      
      bit_count = bit_count + 1;
      
      // If we've reached the end of one input sequence,
      // reset the bit count and start the next sequence.
      
      // Reset the Moore Machine so that it starts from initial states
      // at the next input sequence.
      
      if (bit_count == 16) begin
        
        bit_count <= 0;             // Reset bit count to 0.
        in_count  <= in_count + 1;  // Increment input sequence by 1.
        
        // Reset the state machines.
        
        rst = 1;
        #2;       // Delay needs to be bigger than #1 delay in state machine.
        rst = 0;
      end
    end
  end
  
  // Initialize the clock, and repeat until $stop condition is reached:
  
  initial repeat (300) #10 clk = ~clk;
  
endmodule