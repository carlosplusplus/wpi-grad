library verilog;
use verilog.vl_types.all;
entity Datapath is
    port(
        mc              : in     vl_logic_vector(15 downto 0);
        mp              : in     vl_logic_vector(15 downto 0);
        clk             : in     vl_logic;
        done            : in     vl_logic;
        en_CNT          : in     vl_logic;
        ld_M            : in     vl_logic;
        ld_Q            : in     vl_logic;
        rst_A           : in     vl_logic;
        rst_Count       : in     vl_logic;
        rst_Qr          : in     vl_logic;
        prod            : out    vl_logic_vector(31 downto 0);
        busy            : out    vl_logic
    );
end Datapath;
