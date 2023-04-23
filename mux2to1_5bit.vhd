-- This is a multiplexer of two, 5-bit buses.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mux2to1_5bit is
    Port ( mux0 : in  STD_LOGIC_VECTOR (4 downto 0);
           mux1 : in  STD_LOGIC_VECTOR (4 downto 0);
           mux_out : out  STD_LOGIC_VECTOR (4 downto 0);
           sel : in  STD_LOGIC);
end mux2to1_5bit;

architecture Behavioral of mux2to1_5bit is


signal temp_out : STD_LOGIC_VECTOR(4 downto 0);

begin
	mux_out <= mux1 when (sel = '1') else mux0;
end Behavioral;

