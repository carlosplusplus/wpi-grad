library verilog;
use verilog.vl_types.all;
entity Controller is
    port(
        op_code         : in     vl_logic_vector(2 downto 0);
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        zero            : in     vl_logic;
        ALU_op          : out    vl_logic_vector(1 downto 0);
        ACC_ON_DBUS     : out    vl_logic;
        enACC           : out    vl_logic;
        enIR            : out    vl_logic;
        enPC            : out    vl_logic;
        MuxAsel         : out    vl_logic;
        MuxBsel         : out    vl_logic;
        rd_mem          : out    vl_logic;
        wr_mem          : out    vl_logic
    );
end Controller;
