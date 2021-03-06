// Carlos Lazo
// ECE505
// Homework 03

// Testbench for the 16-bit CPU

`timescale 1ns/100ps

module CompArch_CPU_Tester;
  
  // Initialize all necessary variables:
  
  reg [15:0] mem_data;
  reg clk, reset, control;
  
  wire [15:0] addr_bus, data_bus;
  wire rd_mem, wr_mem;
  
  integer HexFile, check;
  
  // Instantiate the 16bit CPU:
  
  CompArch_CPU UUT (clk, reset, addr_bus,
                    rd_mem, wr_mem, data_bus);
                    
  // Initialize all variables to default values: 
  
  initial begin  
    clk   = 0;
    reset = 1;  
    
    mem_data = 16'b0;
    control  = 0;
  end
  
  // Set the clock to invert every 10ns:
  
  always #10 clk = ~clk;
  
  initial begin
    Convert;  // Read mnemonics, convert to machine language.
    HexFile = $fopen ("HexadecimalFile.mem", "r+");
    
    #40 reset = 0;
    #550;
    $fclose(HexFile);
    $finish;
  end
  
  // Reset block to test the Halt state.
  
  initial begin
    reset <= #525 1;
    reset <= #535 0;
  end
  
  // Perform logic based on read and write signals sent from Controller.
  
  always @ (posedge clk) begin : Memory_Read_Write
    control = 0;
    #1;
    
    // If reading from the shared memory, read data into mem_data.
    
    if (rd_mem) begin
      #1;
      check = $fseek  (HexFile, 6 * addr_bus, 0);
      check = $fscanf (HexFile, "%h", mem_data);
      control = 1;
    end
    
    // If writing to the shared memory, write into mem_data.
    
    if (wr_mem) begin
      #1;
      check = $fseek  (HexFile, 6 * addr_bus, 0);
      $fwrite (HexFile, "%h", data_bus);
      $fflush (HexFile);
    end
  end
  
  // Assign information to data_bus based on reading or writing:
  
  assign data_bus = (control) ? mem_data : 16'bz;
  
  // Develop the assembler program to decode mnemonics:

  task Convert;
    begin : interp_mnemonic
       
      reg [12:0] addr;
      reg [3 * 8 : 1] opCode;
      reg [15:0] data, writeData;
      reg JustData;
      integer i, HexFile, InstFile, check;
      
      // There are a total of 2^13 possible memory addresses.
      // Write 0000 as initial 4 HEX bits into all memory slots.
       
      HexFile = $fopen ("HexadecimalFile.mem");
      for (i = 0; i < 8192; i = i + 1)
        $fwrite (HexFile, "0000\n");
        
      $fflush (HexFile); $fclose (HexFile);
      
      // Initialize pointers to both instruction and hex files.
      
      InstFile = $fopen ("InstructionFile.mem", "r");
      HexFile  = $fopen ("HexadecimalFile.mem", "r+");
      
      // Begin scanning through each instruction until the end of file is reached.
      
      while ($fscanf (InstFile, "%h", addr) != -1) begin
        
        check = $fseek (HexFile, addr * 6, 0);
        check = $fgets (opCode, InstFile);
        
        JustData = 0;
        
        // Set op_code bits according to the instruction received:
        
        case(opCode)
          "LDA" : writeData[15:13] = 0;
          "STA" : writeData[15:13] = 1;
          "SUM" : writeData[15:13] = 2;
          "SUB" : writeData[15:13] = 3;
          "JMP" : writeData[15:13] = 4;
          "JEZ" : writeData[15:13] = 5;
          "HLT" : writeData[15:13] = 6;
          
          // If we are reading in data, the write the data into writeData. 
          
          ":::" : begin
            JustData = 1;
            check = $fscanf (InstFile, "%h", writeData);
          end
          
          default: begin
            JustData = 1;
            check = $fscanf (InstFile, "%h", writeData);
          end
        endcase
        
        // If it is a valid instruction and not just data,
        // write the operand into memory at writeData [12:0].
        
        if (JustData == 0) begin
          check = $fscanf (InstFile, "%h", data);
          writeData [12:0] = data [12:0];
        end
        
        // Write information into HexadecimalFile.mem
        
        $fwrite (HexFile, "%h", writeData);
        
      end
      
      $fflush (HexFile);
      $fclose (HexFile); $fclose (InstFile);

    end
  endtask
  
endmodule