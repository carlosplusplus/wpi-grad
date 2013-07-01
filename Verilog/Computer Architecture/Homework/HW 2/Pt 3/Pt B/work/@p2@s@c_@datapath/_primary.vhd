library verilog;
use verilog.vl_types.all;
entity P2SC_Datapath is
    port(
        p_in            : in     vl_logic_vector(7 downto 0);
        addr            : in     vl_logic_vector(2 downto 0);
        clk             : in     vl_logic;
        ld_reg          : in     vl_logic;
        out_en          : in     vl_logic;
        sout            : out    vl_logic
    );
end P2SC_Datapath;
