----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:31:42 03/12/2023 
-- Design Name: 
-- Module Name:    mux32_2_to_1 - Behavioral 
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

entity mux32_2_to_1 is
    Port ( Select_in : in  STD_LOGIC;
           Input0 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input1 : in  STD_LOGIC_VECTOR (31 downto 0);
           mux_out : out  STD_LOGIC_VECTOR (31 downto 0));
end mux32_2_to_1;

architecture Behavioral of mux32_2_to_1 is

signal out_signal_temp : STD_LOGIC_VECTOR (31 downto 0);

begin
	process(Select_in, Input0, Input1)  -- the process is "run" otan we have a change in the value of Select_in
	begin

		case Select_in is
			when '0' => out_signal_temp <= Input0;
			when '1' => out_signal_temp <= Input1;
			when others => out_signal_temp <= x"00000000"; -- in any other case, the output will be 0
		end case;
	end process;
	mux_out <= out_signal_temp;
end Behavioral;

