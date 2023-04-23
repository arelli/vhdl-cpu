-- This is the DECode Stage: here, the instructions are "decoded", which means
-- they are sliced into sub-sequences which are fed to their respective destinations(RF,Immediate).
-- It also contains the Register File.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DECSTAGE is
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
end DECSTAGE;

architecture Behavioral of DECSTAGE is

signal Din_tmp:STD_LOGIC_VECTOR (31 downto 0);
signal Ard1_tmp:STD_LOGIC_VECTOR (4 downto 0);
signal RF_A_tmp:STD_LOGIC_VECTOR (31 downto 0);
signal RF_B_tmp:STD_LOGIC_VECTOR (31 downto 0);
signal Immed_tmp:STD_LOGIC_VECTOR (31 downto 0);

Component RegisterFile is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);  -- Address (to) read data 1
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);  -- Address (to) write data 
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);  -- Data output 1
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);  -- Data Input
           WrEn : in  STD_LOGIC;  -- Write enable
			  Rst : in STD_LOGIC;
           Clk : in  STD_LOGIC);
end Component;

Component mux32_2_to_1 is
    Port ( Select_in : in  STD_LOGIC;
           Input0 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input1 : in  STD_LOGIC_VECTOR (31 downto 0);
           mux_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component mux2to1_5bit is
    Port ( mux0 : in  STD_LOGIC_VECTOR (4 downto 0);
           mux1 : in  STD_LOGIC_VECTOR (4 downto 0);
           mux_out : out  STD_LOGIC_VECTOR (4 downto 0);
           sel : in  STD_LOGIC);
end Component;

Component immed_bubble is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

begin

Mux_ALU_MEM : mux32_2_to_1 PORT MAP (
				Input0=>ALU_out,
				Input1=>MEM_out,
				mux_out=>Din_tmp,
				Select_in=>RF_WrData_sel
			);
			
Mux_Instr_ALU : mux2to1_5bit PORT MAP (
				mux0=>Instr(15 downto 11),
				mux1=>Instr(20 downto 16),
				mux_out=>Ard1_tmp,
				sel=>RF_B_sel
			);
			
RFile : RegisterFile PORT MAP(
				Ard1=>Instr(25 downto 21),
				Ard2=>Ard1_tmp,
				Awr=>Instr(20 downto 16),
				Dout1=>RF_A_tmp,
				Dout2=>RF_B_tmp,
				Din=>Din_tmp,
				WrEn=>RF_WrEn,
				Rst=>Rst,
				Clk=>Clk
			);
			
bubble: immed_bubble PORT MAP(
				Instr=>Instr,
				Immed=>Immed_tmp
			);
Immed<=Immed_tmp;
RF_A<=RF_A_tmp;
RF_B<=RF_B_tmp;
end Behavioral;

