library verilog;
use verilog.vl_types.all;
entity FullAdder16bitTester is
    generic(
        SIZE            : integer := 16;
        SIM_CHOICE      : integer := 4
    );
end FullAdder16bitTester;
