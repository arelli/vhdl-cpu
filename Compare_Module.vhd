-- This is used to make the Register file writethrough. This means 
-- that when I write on a register address Im trying to read from (the same time)
-- the the results I wrote to it pass immediately to the RF output, without
-- waiting for the clock!.
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Compare_Module is
    Port ( Awr_comp : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard1_comp : in  STD_LOGIC_VECTOR (4 downto 0);
           comp_out : out  STD_LOGIC);
end Compare_Module;

architecture Behavioral of Compare_Module is

begin
comp_out <= '1' when Awr_comp = Ard1_comp else '0';

end Behavioral;

