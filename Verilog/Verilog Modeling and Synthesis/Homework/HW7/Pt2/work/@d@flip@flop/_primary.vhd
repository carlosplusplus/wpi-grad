library verilog;
use verilog.vl_types.all;
entity DFlipFlop is
    port(
        Clk             : in     vl_logic;
        En              : in     vl_logic;
        Rst             : in     vl_logic;
        D               : in     vl_logic;
        Q               : out    vl_logic
    );
end DFlipFlop;
