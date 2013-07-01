library verilog;
use verilog.vl_types.all;
entity FullAdder is
    port(
        a               : in     vl_logic;
        b               : in     vl_logic;
        cin             : in     vl_logic;
        s               : out    vl_logic;
        cout            : out    vl_logic
    );
end FullAdder;
