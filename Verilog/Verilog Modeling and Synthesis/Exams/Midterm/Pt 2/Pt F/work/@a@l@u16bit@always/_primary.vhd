library verilog;
use verilog.vl_types.all;
entity ALU16bitAlways is
    generic(
        SIZE            : integer := 16
    );
    port(
        A               : in     vl_logic_vector;
        B               : in     vl_logic_vector;
        S               : in     vl_logic_vector(1 downto 0);
        Ci              : in     vl_logic;
        R               : out    vl_logic_vector;
        Co              : out    vl_logic;
        V               : out    vl_logic;
        Z               : out    vl_logic
    );
end ALU16bitAlways;
