library verilog;
use verilog.vl_types.all;
entity CounterCell is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        init            : in     vl_logic;
        cin             : in     vl_logic;
        cout            : out    vl_logic
    );
end CounterCell;
