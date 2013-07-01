library verilog;
use verilog.vl_types.all;
entity FullAdder4bitTester is
    generic(
        SIZE            : integer := 4;
        SIM_CHOICE      : integer := 1
    );
end FullAdder4bitTester;
