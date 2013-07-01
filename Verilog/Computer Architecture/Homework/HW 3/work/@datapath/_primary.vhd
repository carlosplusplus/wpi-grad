library verilog;
use verilog.vl_types.all;
entity Datapath is
    port(
        ALU_op          : in     vl_logic_vector(1 downto 0);
        ACC_ON_DBUS     : in     vl_logic;
        enACC           : in     vl_logic;
        enIR            : in     vl_logic;
        enPC            : in     vl_logic;
        MuxAsel         : in     vl_logic;
        MuxBsel         : in     vl_logic;
        clk             : in     vl_logic;
        addr_bus        : out    vl_logic_vector(15 downto 0);
        IR15_13         : out    vl_logic_vector(2 downto 0);
        zero            : out    vl_logic;
        data_bus        : inout  vl_logic_vector(15 downto 0)
    );
end Datapath;
