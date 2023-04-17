----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:22:01 04/07/2022 
-- Design Name: 
-- Module Name:    incrementor4 - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity incrementor4 is
    Port ( pc_in : in  STD_LOGIC_VECTOR (31 downto 0);
           pc_out : out  STD_LOGIC_VECTOR (31 downto 0));
end incrementor4;

architecture Behavioral of incrementor4 is
signal temp : unsigned (31 downto 0);
begin
	inc_proc:PROCESS(pc_in,temp)
	begin
		temp<=unsigned(pc_in)+4;
	end process;
	pc_out<=STD_LOGIC_VECTOR(temp);
end Behavioral;

