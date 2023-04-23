-- this is just to add 4 on every clock cycle to the PC.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity incrementor4 is
    Port ( pc_in : in  STD_LOGIC_VECTOR (31 downto 0);
           pc_out : out  STD_LOGIC_VECTOR (31 downto 0));
end incrementor4;

architecture Behavioral of incrementor4 is
signal temp : unsigned (31 downto 0);
begin
	inc_proc:PROCESS(pc_in,temp)
	begin
		temp<=unsigned(pc_in)+4;
	end process;
	pc_out<=STD_LOGIC_VECTOR(temp);
end Behavioral;

