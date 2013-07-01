library verilog;
use verilog.vl_types.all;
entity BoothMultiplier is
    port(
        mc              : in     vl_logic_vector(15 downto 0);
        mp              : in     vl_logic_vector(15 downto 0);
        clk             : in     vl_logic;
        start           : in     vl_logic;
        prod            : out    vl_logic_vector(31 downto 0)
    );
end BoothMultiplier;
