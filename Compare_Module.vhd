----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:15:31 03/12/2023 
-- Design Name: 
-- Module Name:    Compare_Module - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Compare_Module is
    Port ( Awr_comp : in  STD_LOGIC_VECTOR (4 downto 0);
           Ard1_comp : in  STD_LOGIC_VECTOR (4 downto 0);
           comp_out : out  STD_LOGIC);
end Compare_Module;

architecture Behavioral of Compare_Module is

begin
comp_out <= '1' when Awr_comp = Ard1_comp else '0';

end Behavioral;

