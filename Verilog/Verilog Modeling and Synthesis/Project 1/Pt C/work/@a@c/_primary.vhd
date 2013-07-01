library verilog;
use verilog.vl_types.all;
entity AC is
    port(
        data_in         : in     vl_logic_vector(15 downto 0);
        load            : in     vl_logic;
        clk             : in     vl_logic;
        data_out        : out    vl_logic_vector(15 downto 0)
    );
end AC;
