// Carlos Lazo
// ECE574
// Project 2

// Router Design
// rtlRouter Tester

`timescale 1ns/100ps

module rtlRouterTester;
  
  // Declare all inputs and outputsA:
    
  reg [7:0] inData1, inData2, inData3, inData4;
  reg clk, rst, request1, request2, request3, request4;
    
  wire [7:0] output_port;
  wire ready1, ready2, ready3, ready4;
    
  // Instantiate an rtlRouter module:
    
  rtlRouter UUT (inData1, inData2, inData3, inData4,
                 clk, rst, request1, request2, request3, request4,
                 output_port,
                 ready1, ready2, ready3, ready4);
                 
  // Set all reg inputs to initial values:
                   
  initial begin
    
    inData1 = 0; inData2 = 0; inData3 = 0; inData4 = 0;
    clk = 0; rst = 1;
    request1 = 0; request2 = 0; request3 = 0; request4 = 0;
    
  end
  
  // Every 'x' ns, give random data to the DataPort variables.
  
  initial repeat (72) begin
    #22;
    inData1 = $random;
    inData2 = $random;
    inData3 = $random;
    inData4 = $random;
  end
  
  initial repeat (72) #22 clk = ~clk;
  
  // Begin the main testbench sequence:
  
  initial begin
    
    rst <= #50 0;
    
    request1 <= #100 1;
    
  end

endmodule