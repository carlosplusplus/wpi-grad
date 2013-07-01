library verilog;
use verilog.vl_types.all;
entity P2SC_Controller is
    port(
        clk             : in     vl_logic;
        start           : in     vl_logic;
        addr            : out    vl_logic_vector(2 downto 0);
        ld_reg          : out    vl_logic;
        out_en          : out    vl_logic;
        ready           : out    vl_logic
    );
end P2SC_Controller;
