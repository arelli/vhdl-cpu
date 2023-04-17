library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Instr_internal : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE;

architecture Behavioral of IFSTAGE is


SIGNAL pc_tmp_added : STD_LOGIC_VECTOR (31 downto 0); --pc after addition with immediate
SIGNAL pc_tmp_out : STD_LOGIC_VECTOR (31 downto 0); 	--pc output
SIGNAL pc_tmp_incr : STD_LOGIC_VECTOR (31 downto 0); 	--pc after +4
SIGNAL pc_imm_tmp : STD_LOGIC_VECTOR (31 downto 0);
SIGNAL pc_tmp_mux : STD_LOGIC_VECTOR (31 downto 0);	--pc after mux
SIGNAL pc_sel_tmp : STD_LOGIC;
SIGNAL pc_lden_tmp : STD_LOGIC;
SIGNAL rst_tmp : STD_LOGIC;
SIGNAL clk_tmp : STD_LOGIC;

Component single_register is  -- A 32-bit Register
    Port ( CLK : in  STD_LOGIC;  -- clock
           RST : in  STD_LOGIC;  -- reset register to 0
           Datain : in  STD_LOGIC_VECTOR (31 downto 0); -- input bus
           WE : in  STD_LOGIC;  -- Write Enable(inout means a bidirectional bus, able to check its value internally without intermediate signal/buffer)
           Dataout : out  STD_LOGIC_VECTOR (31 downto 0));  --Data output bus
end Component;

Component mux32_2_to_1 is
    Port ( Select_in : in  STD_LOGIC;
           Input0 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input1 : in  STD_LOGIC_VECTOR (31 downto 0);
           mux_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component imm_adder is
    Port ( 	imm : in  STD_LOGIC_VECTOR (31 downto 0);
				pc_in : in  STD_LOGIC_VECTOR (31 downto 0);
				add_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component incrementor4 is
    Port ( pc_in : in  STD_LOGIC_VECTOR (31 downto 0);
           pc_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

begin
incr: incrementor4 PORT MAP(
			pc_in=>pc_tmp_out,
			pc_out=>pc_tmp_incr
		);
pcadd: imm_adder PORT MAP(
			imm=>pc_imm_tmp,
			pc_in=>pc_tmp_incr,
			add_out=>pc_tmp_added
		);
mux_pc: mux32_2_to_1 PORT MAP(
			Select_in=>pc_sel_tmp,
			Input0=>pc_tmp_incr,
			Input1=>pc_tmp_added,
			mux_out=>pc_tmp_mux
		);
pc_reg: single_register PORT MAP(
			CLK=>Clk,
			RST=>Reset,
			Datain=>pc_tmp_mux,
			WE=>pc_lden_tmp,
			Dataout=>pc_tmp_out
		);
		
ifstage_proc:PROCESS(PC_Immed,PC_sel,PC_LdEn,Reset,Clk,pc_imm_tmp,pc_sel_tmp,pc_lden_tmp,rst_tmp,clk_tmp,pc_tmp_out)
BEGIN

		pc_imm_tmp<=PC_Immed;
		pc_sel_tmp<=PC_sel;
		pc_lden_tmp<=PC_LdEn;
		rst_tmp<=Reset;
		clk_tmp<=Clk;
END PROCESS;

Instr_internal<=pc_tmp_out;
end Behavioral;

