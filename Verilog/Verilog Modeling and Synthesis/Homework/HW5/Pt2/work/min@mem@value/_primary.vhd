library verilog;
use verilog.vl_types.all;
entity minMemValue is
    port(
        clk             : in     vl_logic;
        data            : in     vl_logic_vector(7 downto 0);
        start           : in     vl_logic;
        rd_addr         : out    vl_logic_vector(9 downto 0);
        ready           : out    vl_logic;
        \out\           : out    vl_logic_vector(7 downto 0)
    );
end minMemValue;
