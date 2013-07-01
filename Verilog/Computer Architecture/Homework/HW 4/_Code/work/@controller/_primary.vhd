library verilog;
use verilog.vl_types.all;
entity Controller is
    port(
        busy            : in     vl_logic;
        clk             : in     vl_logic;
        start           : in     vl_logic;
        done            : out    vl_logic;
        en_CNT          : out    vl_logic;
        ld_M            : out    vl_logic;
        ld_Q            : out    vl_logic;
        rst_A           : out    vl_logic;
        rst_Count       : out    vl_logic;
        rst_Qr          : out    vl_logic
    );
end Controller;
