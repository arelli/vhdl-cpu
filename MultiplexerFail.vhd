----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:57:01 04/10/2022 
-- Design Name: 
-- Module Name:    Multiplexer - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


-- This is a 32-to-1 multiplxer, but the only difference is that
-- each input line, is a 32 bit bus coming from a register in 
-- the register file. This is why we need a custom type(defined below)
-- to represent a "vector" that contains 32 32-bit buses.

entity MultiplexerFail is
    Port ( Select_in : in  STD_LOGIC_VECTOR (4 downto 0);
           Inputs : in  multidArray (31 downto 0);
           Out_singal : out  STD_LOGIC_VECTOR (31 downto 0));  -- remember, each input line are the 32 bits of a register
end MultiplexerFail;

architecture Behavioral of MultiplexerFail is
-- Define my own multidimentional array to include 32 32-bit buses(from the registers here in particular)
type multidArray is array (0 downto 31) of STD_LOGIC_VECTOR(31 downto 0);

signal out_signal_temp : STD_LOGIC_VECTOR (31 downto 0) := x"00000000";


begin
	process(Select_in)
	begin
		case Select_in is
			when "00000" => out_signal_temp <= Inputs(0);
			when "00001" => out_signal_temp <= Inputs(1);
			when "00010" => out_signal_temp <= Inputs(2);
			when "00011" => out_signal_temp <= Inputs(3);
			when "00100" => out_signal_temp <= Inputs(4);
			when "00101" => out_signal_temp <= Inputs(5);
			when "00110" => out_signal_temp <= Inputs(6);
			when "00111" => out_signal_temp <= Inputs(7);
			when "01000" => out_signal_temp <= Inputs(8);
			when "01001" => out_signal_temp <= Inputs(9);
			when "01010" => out_signal_temp <= Inputs(10);
			when "01011" => out_signal_temp <= Inputs(11);
			when "01100" => out_signal_temp <= Inputs(12);
			when "01101" => out_signal_temp <= Inputs(13);
			when "01110" => out_signal_temp <= Inputs(14);
			when "01111" => out_signal_temp <= Inputs(15);
			when "10000" => out_signal_temp <= Inputs(16);
			when "10001" => out_signal_temp <= Inputs(17);
			when "10010" => out_signal_temp <= Inputs(18);
			when "10011" => out_signal_temp <= Inputs(19);
			when "10100" => out_signal_temp <= Inputs(20);
			when "10101" => out_signal_temp <= Inputs(21);
			when "10110" => out_signal_temp <= Inputs(22);
			when "10111" => out_signal_temp <= Inputs(23);
			when "11000" => out_signal_temp <= Inputs(24);
			when "11001" => out_signal_temp <= Inputs(25);
			when "11010" => out_signal_temp <= Inputs(26);
			when "11011" => out_signal_temp <= Inputs(27);
			when "11100" => out_signal_temp <= Inputs(28);
			when "11101" => out_signal_temp <= Inputs(29);
			when "11110" => out_signal_temp <= Inputs(30);
			when "11111" => out_signal_temp <= Inputs(31);
			when others => out_signal_temp <= x"00000000"; -- in any other case, the output will be 0
		end case;
	end process;
	

Out_signal <= out_signal_temp after 10 ns;
end Behavioral;

