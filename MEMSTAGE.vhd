library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MEMSTAGE is
    Port ( clk : in  STD_LOGIC;
           Mem_WrEn : in  STD_LOGIC;
           ALU_MEM_Addr : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataIn : in  STD_LOGIC_VECTOR (31 downto 0);
           MEM_DataOut : out  STD_LOGIC_VECTOR (31 downto 0));
end MEMSTAGE;

architecture Behavioral of MEMSTAGE is

Component MemoryRAM IS
  PORT (
    clka : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);  -- 9 downto 0 or 31 downto 0???
    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END Component;

signal MEM_DataOut_tmp:STD_LOGIC_VECTOR (31 downto 0);
signal Mem_WrEn_tmp:STD_LOGIC_VECTOR (0 downto 0);

begin

Mem_WrEn_tmp<=(others => '0');
Mem_WrEn_tmp(0)<=Mem_WrEn;

Mem_Unit_RAM: MemoryRAM Port map(
		clka=>clk,
		wea=>Mem_WrEn_tmp,
		addra=>ALU_MEM_Addr(11 downto 2),  --  slice the bus to its last 10 bytes(we only ave 1024 memory addresses)
		dina=>MEM_DataIn,
		douta=>MEM_DataOut_tmp
	);
	
	
MEM_DataOut<=MEM_DataOut_tmp;

end Behavioral;

