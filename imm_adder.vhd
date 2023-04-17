----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:55:53 04/07/2022 
-- Design Name: 
-- Module Name:    imm_adder - Behavioral 
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

entity imm_adder is
    Port ( 	imm : in  STD_LOGIC_VECTOR (31 downto 0);
				pc_in : in  STD_LOGIC_VECTOR (31 downto 0);
				add_out : out  STD_LOGIC_VECTOR (31 downto 0));
end imm_adder;

architecture Behavioral of imm_adder is


signal temp : unsigned (31 downto 0);
begin
	addImm_proc:PROCESS(imm,temp, pc_in)
	begin
		temp<=unsigned(imm)+unsigned(pc_in);
	end process;
	add_out<=STD_LOGIC_VECTOR(temp);

end Behavioral;

