library verilog;
use verilog.vl_types.all;
entity BinaryCounter8bit is
    generic(
        SIZE            : integer := 8
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        init            : in     vl_logic;
        cin             : in     vl_logic;
        cout            : out    vl_logic
    );
end BinaryCounter8bit;
