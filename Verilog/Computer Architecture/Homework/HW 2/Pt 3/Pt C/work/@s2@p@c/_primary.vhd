library verilog;
use verilog.vl_types.all;
entity S2PC is
    port(
        clk             : in     vl_logic;
        start           : in     vl_logic;
        s_in            : in     vl_logic;
        parout          : out    vl_logic_vector(8 downto 0);
        ready           : out    vl_logic
    );
end S2PC;
