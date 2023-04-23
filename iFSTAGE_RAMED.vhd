-- This is the Instruction Fetch(IF) stage. It is responsible for fetching the 
-- intructions from the IMEM(Instruction MEMory), one by one, and for executing
-- jumps when branching instructions are encountered.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IFSTAGE_RAMED is
Port ( 	  PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);  
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Instr : out  STD_LOGIC_VECTOR (31 downto 0));
end IFSTAGE_RAMED;

architecture Behavioral of IFSTAGE_RAMED is

signal Instr_tmp:STD_LOGIC_VECTOR (31 downto 0);
signal Instr_out:STD_LOGIC_VECTOR (31 downto 0);

Component IFSTAGE is
    Port ( PC_Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Instr_internal : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component Memory2 IS
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END Component;

begin
ifstg_internal: IFSTAGE Port map(
		PC_Immed=>PC_Immed,
		PC_sel=>PC_sel,
		PC_LdEn=>PC_LdEn,
		Reset=>Reset,
		Clk=>Clk,
		Instr_internal=>Instr_tmp
	);
Mem_Unit: Memory2 Port map(
		clka=>Clk,
		wea=>(others => '0'),
		addra=>Instr_tmp(11 downto 2),  -- ignore the first two bits(we increment PC by 4!!)
		dina=>(others => '0'),
		douta=>Instr_out
	);
	
Instr<=Instr_out;
end Behavioral;

