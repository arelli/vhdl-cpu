----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:41:41 04/10/2022 
-- Design Name: 
-- Module Name:    Multiplexer - Behavioral 
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

entity Multiplexer is
    Port ( Select_in : in  STD_LOGIC_VECTOR (4 downto 0);
           Input0 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input3 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input4 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input5 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input6 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input7 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input8 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input9 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input10 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input11 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input12 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input13 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input14 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input15 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input16 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input17 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input18 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input19 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input20 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input21 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input22 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input23 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input24 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input25 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input26 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input27 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input28 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input29 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input30 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input31 : in  STD_LOGIC_VECTOR (31 downto 0);
           Out_signal : out  STD_LOGIC_VECTOR (31 downto 0));
end Multiplexer;

architecture Behavioral of Multiplexer is
signal out_signal_temp : STD_LOGIC_VECTOR (31 downto 0);

begin
	process(Select_in)  -- the process is "run" otan we have a change in the value of Select_in
	begin
		case Select_in is
			when "00000" => out_signal_temp <= Input0;
			when "00001" => out_signal_temp <= Input1;
			when "00010" => out_signal_temp <= Input2;
			when "00011" => out_signal_temp <= Input3;
			when "00100" => out_signal_temp <= Input4;
			when "00101" => out_signal_temp <= Input5;
			when "00110" => out_signal_temp <= Input6;
			when "00111" => out_signal_temp <= Input7;
			when "01000" => out_signal_temp <= Input8;
			when "01001" => out_signal_temp <= Input9;
			when "01010" => out_signal_temp <= Input10;
			when "01011" => out_signal_temp <= Input11;
			when "01100" => out_signal_temp <= Input12;
			when "01101" => out_signal_temp <= Input13;
			when "01110" => out_signal_temp <= Input14;
			when "01111" => out_signal_temp <= Input15;
			when "10000" => out_signal_temp <= Input16;
			when "10001" => out_signal_temp <= Input17;
			when "10010" => out_signal_temp <= Input18;
			when "10011" => out_signal_temp <= Input19;
			when "10100" => out_signal_temp <= Input20;
			when "10101" => out_signal_temp <= Input21;
			when "10110" => out_signal_temp <= Input22;
			when "10111" => out_signal_temp <= Input23;
			when "11000" => out_signal_temp <= Input24;
			when "11001" => out_signal_temp <= Input25;
			when "11010" => out_signal_temp <= Input26;
			when "11011" => out_signal_temp <= Input27;
			when "11100" => out_signal_temp <= Input28;
			when "11101" => out_signal_temp <= Input29;
			when "11110" => out_signal_temp <= Input30;
			when "11111" => out_signal_temp <= Input31;
			when others => out_signal_temp <= x"00000000"; -- in any other case, the output will be 0
		end case;
	end process;

Out_signal <= out_signal_temp;
end Behavioral;

