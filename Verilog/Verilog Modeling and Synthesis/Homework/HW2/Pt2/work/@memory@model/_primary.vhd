library verilog;
use verilog.vl_types.all;
entity MemoryModel is
    port(
        clk             : in     vl_logic;
        read            : in     vl_logic;
        write           : in     vl_logic;
        inbus           : in     vl_logic_vector(7 downto 0);
        addrbus         : in     vl_logic_vector(9 downto 0);
        outbus          : out    vl_logic_vector(7 downto 0)
    );
end MemoryModel;
