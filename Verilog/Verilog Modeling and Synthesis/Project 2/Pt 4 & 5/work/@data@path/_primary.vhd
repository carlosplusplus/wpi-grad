library verilog;
use verilog.vl_types.all;
entity DataPath is
    port(
        inData1         : in     vl_logic_vector(7 downto 0);
        inData2         : in     vl_logic_vector(7 downto 0);
        inData3         : in     vl_logic_vector(7 downto 0);
        inData4         : in     vl_logic_vector(7 downto 0);
        dp1_on_bus      : in     vl_logic;
        dp2_on_bus      : in     vl_logic;
        dp3_on_bus      : in     vl_logic;
        dp4_on_bus      : in     vl_logic;
        clk             : in     vl_logic;
        st_router       : in     vl_logic;
        fw_router       : in     vl_logic;
        inAddr          : in     vl_logic_vector(3 downto 0);
        outAddr         : in     vl_logic_vector(3 downto 0);
        rst             : in     vl_logic;
        output_port     : out    vl_logic_vector(7 downto 0);
        acknowledge     : out    vl_logic;
        ready1          : out    vl_logic;
        ready2          : out    vl_logic;
        ready3          : out    vl_logic;
        ready4          : out    vl_logic;
        received        : out    vl_logic
    );
end DataPath;
