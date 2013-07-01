library verilog;
use verilog.vl_types.all;
entity Router is
    port(
        dp_bus          : in     vl_logic_vector(7 downto 0);
        inAddr          : in     vl_logic_vector(3 downto 0);
        outAddr         : in     vl_logic_vector(3 downto 0);
        clk             : in     vl_logic;
        st_router       : in     vl_logic;
        fw_router       : in     vl_logic;
        rst             : in     vl_logic;
        r_out           : out    vl_logic_vector(7 downto 0);
        acknowledge     : out    vl_logic;
        received        : out    vl_logic
    );
end Router;
