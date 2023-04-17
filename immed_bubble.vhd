library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity immed_bubble is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0));  -- we want the output to be 32-bit
			  
end immed_bubble;

architecture Behavioral of immed_bubble is

signal instr_tmp : STD_LOGIC_VECTOR(31 downto 0);
signal shifted_2bits : STD_LOGIC_VECTOR(17 downto 0);
begin

imm_dec_proc: process(Instr,instr_tmp,shifted_2bits)
begin
	shifted_2bits <=Instr(15 downto 0) & "00"; 
	case Instr(11 downto 10) is
		when "00" =>	instr_tmp<=std_logic_vector(resize(unsigned(Instr(15 downto 0)),Immed'length));			--resizing only with zero's
		when "01" => 	instr_tmp<=std_logic_vector(resize(signed(Instr(15 downto 0)),Immed'length));				--resizing and sign ext
		when "10" =>	instr_tmp<=std_logic_vector(resize(signed(shifted_2bits),Immed'length));	--resize again and sign extend, and shifting two bits
		when "11" =>	instr_tmp<=Instr(15 downto 0) & "0000000000000000";													--shift left 16 bits
		when others =>	
	end case;
	Immed<=instr_tmp;
end process;
end Behavioral;