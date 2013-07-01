library verilog;
use verilog.vl_types.all;
entity MooreSeqDetector is
    generic(
        sA1             : integer := 0;
        sB1             : integer := 1;
        sC1             : integer := 2;
        sD1             : integer := 3;
        sE1             : integer := 4;
        sF1             : integer := 5;
        sA2             : integer := 0;
        sB2             : integer := 1;
        sC2             : integer := 2;
        sD2             : integer := 3;
        sE2             : integer := 4;
        sF2             : integer := 5
    );
    port(
        a               : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        w               : out    vl_logic
    );
end MooreSeqDetector;
