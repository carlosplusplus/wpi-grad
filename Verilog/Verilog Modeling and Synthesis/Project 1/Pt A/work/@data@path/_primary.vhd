library verilog;
use verilog.vl_types.all;
entity DataPath is
    port(
        DataInput       : in     vl_logic_vector(15 downto 0);
        Reset_AC        : in     vl_logic;
        ShiftRight_AC   : in     vl_logic;
        Add_Input_AC    : in     vl_logic;
        Increment_AC    : in     vl_logic;
        Swaprightleft_AC: in     vl_logic;
        Complement_AC   : in     vl_logic;
        Multiply_AC     : in     vl_logic;
        alu_on_bus      : in     vl_logic;
        clk             : in     vl_logic;
        ld_AC           : in     vl_logic;
        DataOutput      : out    vl_logic_vector(15 downto 0)
    );
end DataPath;
