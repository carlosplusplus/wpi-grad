library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        DataInput       : in     vl_logic_vector(15 downto 0);
        AC_Input        : in     vl_logic_vector(15 downto 0);
        Reset_AC        : in     vl_logic;
        ShiftRight_AC   : in     vl_logic;
        Add_Input_AC    : in     vl_logic;
        Increment_AC    : in     vl_logic;
        Swaprightleft_AC: in     vl_logic;
        Complement_AC   : in     vl_logic;
        Multiply_AC     : in     vl_logic;
        alu_out         : out    vl_logic_vector(15 downto 0);
        MultiplicationOp1: out    vl_logic_vector(7 downto 0);
        MultiplicationOp2: out    vl_logic_vector(7 downto 0);
        Multiply        : out    vl_logic
    );
end ALU;
