----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    00:04:23 03/27/2023 
-- Design Name: 
-- Module Name:    MEMSTAGE - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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
		addra=>ALU_MEM_Addr(9 downto 0),  --  slice the bus to its last 10 bytes(we only ave 1024 memory addresses)
		dina=>MEM_DataIn,
		douta=>MEM_DataOut_tmp
	);
	
	
MEM_DataOut<=MEM_DataOut_tmp;

end Behavioral;

