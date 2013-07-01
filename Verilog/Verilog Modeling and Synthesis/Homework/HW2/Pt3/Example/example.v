`timescale 1ns/100ps
module example;

reg [7:0] my_memory [0:31];
integer outfile, i;

initial begin

  outfile= $fopen("mem_out.txt","w");
  
  $readmemh("mem_in.txt" ,my_memory); 

  for(i=0; i<31; i=i+1)
     $fdisplayh(outfile, my_memory[i]);

  $fflush(outfile);
  $fclose(outfile);
   
end //initial
endmodule
