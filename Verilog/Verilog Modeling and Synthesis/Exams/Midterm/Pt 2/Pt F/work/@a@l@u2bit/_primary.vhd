library verilog;
use verilog.vl_types.all;
entity ALU2bit is
    port(
        A               : in     vl_logic_vector(1 downto 0);
        B               : in     vl_logic_vector(1 downto 0);
        S               : in     vl_logic_vector(1 downto 0);
        Ci              : in     vl_logic;
        R               : out    vl_logic_vector(1 downto 0);
        Co              : out    vl_logic;
        V               : out    vl_logic;
        Z               : out    vl_logic
    );
end ALU2bit;
