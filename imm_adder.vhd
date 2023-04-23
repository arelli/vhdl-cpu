-- this is here to add an immediate to the existing PC, when we want to make a jump
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity imm_adder is
    Port ( 	imm : in  STD_LOGIC_VECTOR (31 downto 0);
				pc_in : in  STD_LOGIC_VECTOR (31 downto 0);
				add_out : out  STD_LOGIC_VECTOR (31 downto 0));
end imm_adder;

architecture Behavioral of imm_adder is


signal temp : unsigned (31 downto 0);
begin
	addImm_proc:PROCESS(imm,temp, pc_in)
	begin
		temp<=unsigned(imm)+unsigned(pc_in);
	end process;
	add_out<=STD_LOGIC_VECTOR(temp);

end Behavioral;

