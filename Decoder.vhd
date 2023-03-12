----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:04:04 04/10/2022 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder is
    Port ( Awr : in  STD_LOGIC_VECTOR (4 downto 0);
           Out_signals : out  STD_LOGIC_VECTOR (31 downto 0));
end Decoder;

architecture Behavioral of Decoder is
signal Out_signals_temp : STD_LOGIC_VECTOR(31 downto 0);  -- this is needed only to add the 10 ns requested delay

-- This 5 to 32 decoder takes a 5-bit signal in binary arithmetic format,
-- and according to that, it enables one of its (single bit) outputs each  
-- time. It is a combinational circuit and it does not need a clock input.

begin
	process(Awr)
	begin
		case Awr is
			when "00000" => Out_signals_temp <= "00000000000000000000000000000001";
			when "00001" => Out_signals_temp <= "00000000000000000000000000000010";
			when "00010" => Out_signals_temp <= "00000000000000000000000000000100";
			when "00011" => Out_signals_temp <= "00000000000000000000000000001000";
			when "00100" => Out_signals_temp <= "00000000000000000000000000010000";
			when "00101" => Out_signals_temp <= "00000000000000000000000000100000";
			when "00110" => Out_signals_temp <= "00000000000000000000000001000000";
			when "00111" => Out_signals_temp <= "00000000000000000000000010000000";
			when "01000" => Out_signals_temp <= "00000000000000000000000100000000";
			when "01001" => Out_signals_temp <= "00000000000000000000001000000000";
			when "01010" => Out_signals_temp <= "00000000000000000000010000000000";
			when "01011" => Out_signals_temp <= "00000000000000000000100000000000";
			when "01100" => Out_signals_temp <= "00000000000000000001000000000000";
			when "01101" => Out_signals_temp <= "00000000000000000010000000000000";
			when "01110" => Out_signals_temp <= "00000000000000000100000000000000";
			when "01111" => Out_signals_temp <= "00000000000000001000000000000000";
			when "10000" => Out_signals_temp <= "00000000000000010000000000000000";
			when "10001" => Out_signals_temp <= "00000000000000100000000000000000";
			when "10010" => Out_signals_temp <= "00000000000001000000000000000000";
			when "10011" => Out_signals_temp <= "00000000000010000000000000000000";
			when "10100" => Out_signals_temp <= "00000000000100000000000000000000";
			when "10101" => Out_signals_temp <= "00000000001000000000000000000000";
			when "10110" => Out_signals_temp <= "00000000010000000000000000000000";
			when "10111" => Out_signals_temp <= "00000000100000000000000000000000";
			when "11000" => Out_signals_temp <= "00000001000000000000000000000000";
			when "11001" => Out_signals_temp <= "00000010000000000000000000000000";
			when "11010" => Out_signals_temp <= "00000100000000000000000000000000";
			when "11011" => Out_signals_temp <= "00001000000000000000000000000000";
			when "11100" => Out_signals_temp <= "00010000000000000000000000000000";
			when "11101" => Out_signals_temp <= "00100000000000000000000000000000";
			when "11110" => Out_signals_temp <= "01000000000000000000000000000000";
			when "11111" => Out_signals_temp <= "10000000000000000000000000000000";
			when others => Out_signals_temp <= x"00000000"; -- in any other case, the output will be 0
		end case;
	end process;
			
Out_signals <= Out_signals_temp after 10 ns;
end Behavioral;

