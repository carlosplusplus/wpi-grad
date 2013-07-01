library verilog;
use verilog.vl_types.all;
entity Controller is
    port(
        request1        : in     vl_logic;
        request2        : in     vl_logic;
        request3        : in     vl_logic;
        request4        : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        acknowledge     : in     vl_logic;
        received        : in     vl_logic;
        dp1_on_bus      : out    vl_logic;
        dp2_on_bus      : out    vl_logic;
        dp3_on_bus      : out    vl_logic;
        dp4_on_bus      : out    vl_logic;
        st_router       : out    vl_logic;
        fw_router       : out    vl_logic;
        inAddr          : out    vl_logic_vector(3 downto 0);
        outAddr         : out    vl_logic_vector(3 downto 0)
    );
end Controller;
