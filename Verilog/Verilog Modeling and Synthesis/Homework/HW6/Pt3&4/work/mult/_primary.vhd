library verilog;
use verilog.vl_types.all;
entity mult is
    port(
        a               : in     vl_logic_vector(7 downto 0);
        b               : in     vl_logic_vector(7 downto 0);
        start           : in     vl_logic;
        clk             : in     vl_logic;
        r               : out    vl_logic_vector(15 downto 0);
        done            : out    vl_logic
    );
end mult;
