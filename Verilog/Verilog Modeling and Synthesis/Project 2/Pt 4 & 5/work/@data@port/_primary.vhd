library verilog;
use verilog.vl_types.all;
entity DataPort is
    port(
        data_in         : in     vl_logic_vector(7 downto 0);
        data_on_bus     : in     vl_logic;
        data_out        : out    vl_logic_vector(7 downto 0);
        ready           : out    vl_logic
    );
end DataPort;
