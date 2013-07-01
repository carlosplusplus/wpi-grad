library verilog;
use verilog.vl_types.all;
entity ALU8bitTester is
    generic(
        SIZE            : integer := 8;
        SIM_CHOICE      : integer := 1
    );
end ALU8bitTester;
