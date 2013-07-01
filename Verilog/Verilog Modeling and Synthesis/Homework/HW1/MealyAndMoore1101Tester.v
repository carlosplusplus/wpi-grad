`timescale 1ns/100ps

module MealyAndMoore1101Tester;
  
  reg aa, clock, rst;
  wire wMealy, wMoore;
  
  MealyDetector1101 UUMealy (aa, clock, rst, wMealy);
  MooreDetector1101 UUMoore (aa, clock, rst, wMoore);
  
  initial begin
    aa = 0; clock = 0; rst = 1;
  end
  
  initial repeat (47) #7 clock = ~clock;
  initial repeat (18) #17 aa = ~aa;
  initial begin
    #23 rst = 0;
  end
  
  always @(wMealy) if (wMealy == 1)
    $display ("A 1 was detected on wMealy at time = %t", $time);
  
  always @(wMoore) if (wMoore == 1)
    $display ("A 1 was detected on wMoore at time = %t", $time);
    
endmodule