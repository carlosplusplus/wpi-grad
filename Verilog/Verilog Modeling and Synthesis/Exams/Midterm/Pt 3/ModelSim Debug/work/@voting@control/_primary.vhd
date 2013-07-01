library verilog;
use verilog.vl_types.all;
entity VotingControl is
    port(
        data            : in     vl_logic_vector(7 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        \out\           : out    vl_logic_vector(7 downto 0)
    );
end VotingControl;
