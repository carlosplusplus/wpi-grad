library verilog;
use verilog.vl_types.all;
entity CompArch_CPU is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        addr_bus        : out    vl_logic_vector(15 downto 0);
        rd_mem          : out    vl_logic;
        wr_mem          : out    vl_logic;
        data_bus        : inout  vl_logic_vector(15 downto 0)
    );
end CompArch_CPU;
