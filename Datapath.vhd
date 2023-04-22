
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity Datapath is
    Port ( Clk : in  STD_LOGIC;
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
           MEM_WrEn : in  STD_LOGIC;  -- TODO: feed it to MEMSTAGE
			  ByteOp : in STD_LOGIC);
end Datapath;

architecture Behavioral of Datapath is

signal Instr_tmp:STD_LOGIC_VECTOR(31 downto 0);
signal Immed_tmp:STD_LOGIC_VECTOR(31 downto 0);
signal ALU_zero_tmp:STD_LOGIC;
signal ALU_out_tmp:STD_LOGIC_VECTOR(31 downto 0);
signal rfa_tmp:STD_LOGIC_VECTOR(31 downto 0);
signal rfb_tmp:STD_LOGIC_VECTOR(31 downto 0);
signal mem_out_tmp:STD_LOGIC_VECTOR(31 downto 0);

Component EXSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_zero: out  STD_LOGIC);
end Component;

Component DECSTAGE is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);  -- Instruction to be decoded
           RF_WrEn : in  STD_LOGIC;  --  Enable Writing on Register File
           ALU_out : in  STD_LOGIC_VECTOR (31 downto 0);  -- Data to write on RF, coming from ALU
           MEM_out : in  STD_LOGIC_VECTOR (31 downto 0);  -- Data to write on RF, coming from memory
           RF_WrData_sel : in  STD_LOGIC;  -- Select data source: 0=ALU, 1= Memory
           RF_B_sel : in  STD_LOGIC;  -- Position of second register on instruction: 0-> Instr(15-11), 1-> Instr(20-16)
           Clk : in  STD_LOGIC;
			  Rst : in  STD_LOGIC;
           Immed : out  STD_LOGIC_VECTOR (31 downto 0);  -- The (processed) immediate of the instruction
           RF_A : out  STD_LOGIC_VECTOR (31 downto 0);  -- Data from first register.
           RF_B : out  STD_LOGIC_VECTOR (31 downto 0));  -- Data from second register.
end Component;

Component IFSTAGE_RAMED is
Port ( 		PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component MEMSTAGE is
    Port ( clk : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;



begin

decstg: DECSTAGE Port Map(
			Instr=>Instr_tmp,
			RF_WrEn=>RF_WrEn,
			ALU_out=>ALU_out_tmp,
			MEM_out=>mem_out_tmp,
         RF_WrData_sel=>RF_WrData_sel,
         RF_B_sel=>RF_B_sel,
         Clk=>Clk,
			Rst=>Reset,
         Immed=>Immed_tmp,
         RF_A=>rfa_tmp,
         RF_B=>rfb_tmp
);

ifstg: IFSTAGE_RAMED Port Map(
			PC_Immed=>Immed_tmp,
           PC_sel=>PC_sel,
           PC_LdEn=>PC_LdEn,
           Reset=>Reset,
           Clk=>Clk,
           Instr=>Instr_tmp
);
exstg: EXSTAGE Port Map(
			RF_A=>rfa_tmp,
           RF_B=>rfb_tmp,
           Immed=>Immed_tmp,
           ALU_Bin_sel=>ALU_Bin_sel,
           ALU_func=>ALU_func,
           ALU_out=>ALU_out_tmp,
			  ALU_zero => ALU_zero_tmp
);
memstg: MEMSTAGE Port Map(
			clk=>Clk,
           Mem_WrEn=>MEM_WrEn,
           ALU_MEM_Addr=>ALU_out_tmp,
           MEM_DataIn=>rfb_tmp,
           MEM_DataOut=>mem_out_tmp
);

Instr<=Instr_tmp;
ALU_Zero <= ALU_zero_tmp;
end Behavioral;





