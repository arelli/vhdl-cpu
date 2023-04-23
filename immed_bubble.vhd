-- This is a module that could have been implemented inside the Control Module:
-- it takes the Immediate given to it and, depending on the instruction, formats 
-- it a different way. See ISA for details. 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity immed_bubble is
    Port ( Instr : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : out  STD_LOGIC_VECTOR (31 downto 0));  
			  
end immed_bubble;

architecture Behavioral of immed_bubble is

signal instr_tmp : STD_LOGIC_VECTOR(31 downto 0);
signal shifted_2bits : STD_LOGIC_VECTOR(17 downto 0);
begin

imm_dec_proc: process(Instr,instr_tmp,shifted_2bits)
begin
	shifted_2bits <=Instr(15 downto 0) & "00"; 
	case Instr(31 downto 26) is  -- depending the opcode, decide the format of the Immediate.
		when  "110010" | "110011" =>	
			instr_tmp<=std_logic_vector(resize(unsigned(Instr(15 downto 0)),Immed'length));  --resizing only with zero's
		when "111000" | "110000" | "000011" | "000111" | "001111" | "011111" =>
			instr_tmp<=std_logic_vector(resize(signed(Instr(15 downto 0)),Immed'length));  --resizing and sign ext
		when "111111" | "010000" | "010001" =>	
			instr_tmp<=std_logic_vector(resize(signed(shifted_2bits),Immed'length));  --resize, sign extend, and shift two bits
		when "111001" =>	
			instr_tmp<=Instr(15 downto 0) & "0000000000000000";  --shift left 16 bits, and zero fill
		when others =>	
			instr_tmp <= x"00000000";
	end case;
	Immed<=instr_tmp;
end process;
end Behavioral;