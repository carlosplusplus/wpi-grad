library verilog;
use verilog.vl_types.all;
entity Multiplier is
    port(
        MultiplicationOp1: in     vl_logic_vector(7 downto 0);
        MultiplicationOp2: in     vl_logic_vector(7 downto 0);
        clk             : in     vl_logic;
        Multiply        : in     vl_logic;
        Multiplication_Output: out    vl_logic_vector(15 downto 0);
        Multiplication_Done: out    vl_logic
    );
end Multiplier;
