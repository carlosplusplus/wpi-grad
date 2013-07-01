library verilog;
use verilog.vl_types.all;
entity HW2Pt1 is
    port(
        clk             : in     vl_logic;
        iNB             : in     vl_logic_vector(7 downto 0);
        iB              : in     vl_logic_vector(7 downto 0);
        aNB             : out    vl_logic_vector(7 downto 0);
        bNB             : out    vl_logic_vector(7 downto 0);
        aB              : out    vl_logic_vector(7 downto 0);
        bB              : out    vl_logic_vector(7 downto 0)
    );
end HW2Pt1;
