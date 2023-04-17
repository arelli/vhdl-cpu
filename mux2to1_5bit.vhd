----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:42:56 04/09/2022 
-- Design Name: 
-- Module Name:    mux2to1_5bit - Behavioral 
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

entity mux2to1_5bit is
    Port ( mux0 : in  STD_LOGIC_VECTOR (4 downto 0);
           mux1 : in  STD_LOGIC_VECTOR (4 downto 0);
           mux_out : out  STD_LOGIC_VECTOR (4 downto 0);
           sel : in  STD_LOGIC);
end mux2to1_5bit;

architecture Behavioral of mux2to1_5bit is


signal temp_out : STD_LOGIC_VECTOR(4 downto 0);

begin
mux_proc: process (mux0,mux1,temp_out)
begin
	CASE sel IS
		WHEN '0'=>	temp_out<=mux0;
		WHEN '1'=>	temp_out<=mux1;
		WHEN others => temp_out <= "00000"; -- in any other case, the output will be 0
	END CASE;
	
	end process;
	mux_out<=temp_out;

end Behavioral;

