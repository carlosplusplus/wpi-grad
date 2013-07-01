library verilog;
use verilog.vl_types.all;
entity rtlRouter is
    port(
        inData1         : in     vl_logic_vector(7 downto 0);
        inData2         : in     vl_logic_vector(7 downto 0);
        inData3         : in     vl_logic_vector(7 downto 0);
        inData4         : in     vl_logic_vector(7 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        request1        : in     vl_logic;
        request2        : in     vl_logic;
        request3        : in     vl_logic;
        request4        : in     vl_logic;
        output_port     : out    vl_logic_vector(7 downto 0);
        ready1          : out    vl_logic;
        ready2          : out    vl_logic;
        ready3          : out    vl_logic;
        ready4          : out    vl_logic
    );
end rtlRouter;
