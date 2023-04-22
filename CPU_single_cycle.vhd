-- This is the Top Level module for the single cycle MIPS CPU. It contains
-- all the sub-modules needed for executing sequences of commands, 
-- loops and arithmetic and memory operations. This is also the first part of the project.
-- This is ONLY a port map to combine the Datapath and the Control. Does not contain logic.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CPU_single_cycle is  -- there are n ooutputs! We just monitor the RF and the memory. 
    Port ( Reset : in  STD_LOGIC;
           Clock : in  STD_LOGIC);
end CPU_single_cycle;

architecture Behavioral of CPU_single_cycle is

signal Instr_tmp:STD_LOGIC_VECTOR(31 downto 0);
signal ALU_Zero_tmp:STD_LOGIC;
signal PC_LdEn_tmp:STD_LOGIC;
signal PC_Sel_tmp:STD_LOGIC;
signal RF_B_Sel_tmp:STD_LOGIC;
signal RF_WrEn_tmp:STD_LOGIC;
signal RF_WrData_Sel_tmp:STD_LOGIC;
signal ALU_Bin_Sel_tmp:STD_LOGIC;
signal ALU_Func_tmp:STD_LOGIC_VECTOR(3 Downto 0);
signal MEM_WrEn_tmp:STD_LOGIC;
signal ByteOp_tmp:STD_LOGIC;
signal Reset_tmp:STD_LOGIC;
signal Clock_tmp:STD_LOGIC;

Component Control is
	Port(
		Instr : in STD_LOGIC_VECTOR(31 downto 0);
		ALU_Zero : in STD_LOGIC;
		PC_LdEn : out STD_LOGIC;
		PC_Sel : out STD_LOGIC;
		RF_B_Sel : out STD_LOGIC;
		RF_WrEn : out STD_LOGIC;
		RF_WrData_Sel : out STD_LOGIC;
		ALU_Bin_Sel : out STD_LOGIC;
		ALU_Func : out STD_LOGIC_VECTOR(3 downto 0);
		MEM_WrEn : out STD_LOGIC;
		ByteOp : out STD_LOGIC
	);
end Component;


Component Datapath is
	Port ( 
		Clk : in  STD_LOGIC;
		Reset : in  STD_LOGIC;
		PC_sel : in  STD_LOGIC;
		PC_LdEn : in  STD_LOGIC;
		RF_WrEn : in  STD_LOGIC;
		RF_WrData_sel : in  STD_LOGIC;
		RF_B_sel : in  STD_LOGIC;
		ALU_Bin_sel : in  STD_LOGIC;
		ALU_func : in  STD_LOGIC_VECTOR(3 downto 0);
		Instr : out STD_LOGIC_VECTOR(31 downto 0);
		ALU_Zero : out std_logic;
		MEM_WrEn : in  STD_LOGIC;
		ByteOp : in STD_LOGIC);
end Component;


begin

controler: Control Port Map(
	Instr => Instr_tmp,
	ALU_Zero => ALU_Zero_tmp,
	PC_LdEn => PC_LdEn_tmp,
	PC_Sel => PC_Sel_tmp,
	RF_B_Sel =>RF_B_Sel_tmp,
	RF_WrEn =>RF_WrEn_tmp,
	RF_WrData_Sel =>Rf_WrData_Sel_tmp,
	ALU_Bin_Sel =>ALU_Bin_Sel_tmp,
	ALU_Func =>ALU_Func_tmp,
	MEM_WrEn => MEM_WrEn_tmp,
	ByteOp=> ByteOp_tmp
);

cpu_datapath: Datapath Port Map(
	Clk => Clock_tmp,
	Reset => Reset_tmp,
	Instr => Instr_tmp,
	ALU_Zero => ALU_Zero_tmp,
	PC_LdEn => PC_LdEn_tmp,
	PC_Sel => PC_Sel_tmp,
	RF_B_Sel =>RF_B_Sel_tmp,
	RF_WrEn =>RF_WrEn_tmp,
	RF_WrData_Sel =>Rf_WrData_Sel_tmp,
	ALU_Bin_Sel =>ALU_Bin_Sel_tmp,
	ALU_Func =>ALU_Func_tmp,
	MEM_WrEn => MEM_WrEn_tmp,
	ByteOp=> ByteOp_tmp
);


Reset_tmp <= Reset;
Clock_tmp <= Clock;
end Behavioral;

