library verilog;
use verilog.vl_types.all;
entity DFlipFlop is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        D               : in     vl_logic;
        Q               : out    vl_logic
    );
end DFlipFlop;
