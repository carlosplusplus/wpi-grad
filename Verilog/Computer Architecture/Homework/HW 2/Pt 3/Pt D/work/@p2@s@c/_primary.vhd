library verilog;
use verilog.vl_types.all;
entity P2SC is
    port(
        p_in            : in     vl_logic_vector(7 downto 0);
        clk             : in     vl_logic;
        start           : in     vl_logic;
        sout            : out    vl_logic;
        ready           : out    vl_logic
    );
end P2SC;
