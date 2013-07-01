// Carlos Lazo
// ECE574
// Homework #7

// Part 2: D Flip-Flop @ the Transistor-Level

`timescale 1ns/100ps

module DFlipFlop (input Clk, En, Rst, D, output Q);
  
  // Make necessary complements of inputs available.
  
  wire _Clk, _En, _Rst;
  wire D_out, Q_out;
  wire im_m1, im_m2;
  wire im_s1, im_s2;
  wire ms_link;
  
  not (_Clk, Clk), (_En, En), (_Rst, Rst);
  
  supply0 Gnd;
  supply1 Vdd;
  
  trireg #(0,0,100) cap;
  
  // First, based on EN, figure out what input will go into the circuit.
  // If EN = 1, D gets put in.  If EN = 0, feedback Q as the input.
  
  nmos #(3,4,5)
    mux1_1 (D_out, D  ,  En),
    mux1_2 (D_out, cap, _En);
    
  // Develop Master-portion of the D Flip-Flop:
  
  pmos #(4,5,6)
    mas_p1 (im_m1, Vdd, D_out),
    mas_p2 (ms_link, im_m1, Clk);
    
  nmos #(3,4,5)
    mas_n1 (im_m2, Gnd, D_out),
    mas_n2 (ms_link, im_m2, _Clk);
  
  // Develop Slave-portion of the D Flip-Flop:
    
  pmos #(4,5,6)
    slv_p1 (im_s1, Vdd, ms_link),
    slv_p2 (Q_out, im_s1, _Clk);
    
  nmos #(3,4,5)
    slv_n1 (im_s2, Gnd, ms_link),
    slv_n2 (Q_out, im_s2, Clk);
  
  // Store the Q value as seen when the clock hits.
    
  cmos (cap, Clk, _Clk, Q);
  
  // Lastly, if Rst = 0, Q = 0.  If not, Q = Q_out.
  
  nmos #(3,4,5)
    mux2_1 (Q,   Gnd,  Rst),
    mux2_2 (Q, Q_out, _Rst);
    

    
endmodule;