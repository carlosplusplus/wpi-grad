library verilog;
use verilog.vl_types.all;
entity Controller is
    port(
        instruction     : in     vl_logic_vector(2 downto 0);
        clk             : in     vl_logic;
        new_instruction : in     vl_logic;
        ready           : out    vl_logic;
        Reset_AC        : out    vl_logic;
        ShiftRight_AC   : out    vl_logic;
        Add_Input_AC    : out    vl_logic;
        Increment_AC    : out    vl_logic;
        Swaprightleft_AC: out    vl_logic;
        Complement_AC   : out    vl_logic;
        Multiply_AC     : out    vl_logic;
        alu_on_bus      : out    vl_logic;
        ld_AC           : out    vl_logic
    );
end Controller;
