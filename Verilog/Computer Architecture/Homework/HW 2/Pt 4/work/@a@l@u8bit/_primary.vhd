library verilog;
use verilog.vl_types.all;
entity ALU8bit is
    port(
        A               : in     vl_logic_vector(7 downto 0);
        B               : in     vl_logic_vector(7 downto 0);
        S               : in     vl_logic_vector(2 downto 0);
        R               : out    vl_logic_vector(7 downto 0);
        Co              : out    vl_logic
    );
end ALU8bit;
