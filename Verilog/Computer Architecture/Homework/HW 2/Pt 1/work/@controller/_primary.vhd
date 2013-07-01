library verilog;
use verilog.vl_types.all;
entity Controller is
    port(
        clk             : in     vl_logic;
        start           : in     vl_logic;
        grant           : in     vl_logic;
        received        : in     vl_logic;
        ready           : out    vl_logic;
        busy            : out    vl_logic;
        request         : out    vl_logic;
        avail           : out    vl_logic;
        comp_en         : out    vl_logic;
        ld_reg          : out    vl_logic;
        in_on_bus       : out    vl_logic;
        out_on_bus      : out    vl_logic;
        addr            : out    vl_logic_vector(2 downto 0)
    );
end Controller;
