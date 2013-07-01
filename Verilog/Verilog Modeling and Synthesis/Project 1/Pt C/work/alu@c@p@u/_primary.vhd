library verilog;
use verilog.vl_types.all;
entity aluCPU is
    port(
        DataInput       : in     vl_logic_vector(15 downto 0);
        instruction     : in     vl_logic_vector(2 downto 0);
        clk             : in     vl_logic;
        new_instruction : in     vl_logic;
        rst             : in     vl_logic;
        DataOutput      : out    vl_logic_vector(15 downto 0);
        ready           : out    vl_logic
    );
end aluCPU;
