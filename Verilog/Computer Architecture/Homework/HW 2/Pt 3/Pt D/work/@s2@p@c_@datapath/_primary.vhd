library verilog;
use verilog.vl_types.all;
entity S2PC_Datapath is
    port(
        clk             : in     vl_logic;
        s_in            : in     vl_logic;
        done            : in     vl_logic;
        shift_en        : in     vl_logic;
        parout          : out    vl_logic_vector(8 downto 0)
    );
end S2PC_Datapath;
