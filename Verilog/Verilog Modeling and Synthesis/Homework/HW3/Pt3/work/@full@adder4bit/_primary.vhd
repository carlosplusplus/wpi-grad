library verilog;
use verilog.vl_types.all;
entity FullAdder4bit is
    generic(
        SIZE            : integer := 4
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        cin             : in     vl_logic;
        s               : out    vl_logic_vector;
        cout            : out    vl_logic
    );
end FullAdder4bit;
