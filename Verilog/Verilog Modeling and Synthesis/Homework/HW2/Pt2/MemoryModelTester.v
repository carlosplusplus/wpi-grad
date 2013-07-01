// Carlos Lazo
// ECE574
// Homework #2

// This is the module for the memory modeling Test Bench
// for Homework #2 Part 2. 

`timescale 1ns/100ps

module MemoryModelTester;
  
  // Define all variables needed for the tester.
  
  reg clock, read, write;
  reg [7:0] inMem;
  reg [9:0] addr;
  wire [7:0] outMem;
  
  // Instantiate a variable of type MemoryModel.
  
  MemoryModel UUT (clock, read, write,
                   inMem, addr, outMem);
                   
  // Initialize all inputs respectively.                
  
  initial begin
    clock = 0;
    read  = 0;
    write = 0;
    inMem = 0;
    addr  = 0;
  end
  
  // Change the clock input every 10 ns.
  // This timing will make it easy to develop test scenarios.
  
  initial repeat (10) #10 clock = ~clock;
  
  // Create the testing scenario:
  
  initial begin
    
    // Scenario 1 - Test simple writing and reading capability.
    //              At 5ns, set write = 1 and define an address.
    //              At 10ns, clock will be at rising edge, and
    //              write will be asserted. At 15ns, assert read
    //              and outbus should display contents at that
    //              address. Reset read & write back to 0.
    
    inMem <= #5  8'b00001111;
    write <= #5  1;
    addr  <= #5  10'd1000;
    read  <= #15 1;
    read  <= #16 0;
    write <= #16 0;
    
    // Scenario 2 - Write a different 8-bit value during the next 3
    //              rising edges of the clock, but to different registers
    //              within the memory block. Intermix read statements at
    //              varying VALID addresses.
    
    write <= #20 1;
    
          // Write happens at #30.
    inMem <= #20 8'b10101010;
    addr  <= #25 10'd500;

          // Assert read at address 500 at #35.
    addr  <= #30 10'd500;
    read  <= #35 1;
    read  <= #36 0;

          // Write happens at #50.
    inMem <= #40 8'b11011011;
    addr  <= #45 10'd250;

          // Assert read at address 250 at #55.          
    addr  <= #50 10'd250;
    read  <= #55 1;
    read  <= #56 0;

          // Write happens at #70.          
    inMem <= #60 8'b00111010;
    addr  <= #65 8'd100;
          
          // Assert read at address 500 at #75.
          // Ensures that contents are still there.         
    addr  <= #60 10'd1000;
    read  <= #75 1;
    read  <= #76 0;
    
    write <= #80 0;
    
    // Scenario #3 - This is an attempt to try and write in only 4 bits of
    //               data into the memory block instead of the regular 8 bits.
    
          // Write happens at #90.
    write <= #85 1;
    addr  <= #85 10'd777;
    inMem <= #85  4'b1111;
    
          // Assert read at address 777 at #91.
    read  <= #91 1;
    read  <= #92 0;
    
  end
endmodule