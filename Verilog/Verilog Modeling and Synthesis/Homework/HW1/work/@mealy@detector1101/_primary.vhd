library verilog;
use verilog.vl_types.all;
entity MealyDetector1101 is
    generic(
        sA              : integer := 0;
        sB              : integer := 1;
        sC              : integer := 2;
        sD              : integer := 3
    );
    port(
        A               : in     vl_logic;
        clk             : in     vl_logic;
        R               : in     vl_logic;
        W               : out    vl_logic
    );
end MealyDetector1101;
