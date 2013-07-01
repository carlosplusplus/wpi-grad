library verilog;
use verilog.vl_types.all;
entity S2PC_Controller is
    port(
        clk             : in     vl_logic;
        start           : in     vl_logic;
        addr            : out    vl_logic;
        ld_reg          : out    vl_logic;
        out_en          : out    vl_logic;
        ready           : out    vl_logic
    );
end S2PC_Controller;
