library verilog;
use verilog.vl_types.all;
entity ALU8bit is
    port(
        Ain             : in     vl_logic_vector(7 downto 0);
        Bin             : in     vl_logic_vector(7 downto 0);
        Fn              : in     vl_logic_vector(1 downto 0);
        CI              : in     vl_logic;
        Result          : out    vl_logic_vector(7 downto 0);
        CO              : out    vl_logic;
        OV              : out    vl_logic
    );
end ALU8bit;
