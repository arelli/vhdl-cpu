-- this is a multiplexer that has two 32-bit buses as input. 
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
	mux_out<= Input1 when (Select_in = '1') else Input0;
end Behavioral;

