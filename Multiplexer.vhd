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

    with Select_in select
    out_signal_temp <= Input0 when "00000",
         Input1 when "00001",
         Input2 when "00010",
         Input3 when "00011",
         Input4 when "00100",
         Input5 when "00101",
         Input6 when "00110",
         Input7 when "00111",
         Input8 when "01000",
         Input9 when "01001",
         Input10 when "01010",
         Input11 when "01011",
         Input12 when "01100",
         Input13 when "01101",
         Input14 when "01110",
         Input15 when "01111",
         Input16 when "10000",
         Input17 when "10001",
         Input18 when "10010",
         Input19 when "10011",
         Input20 when "10100",
         Input21 when "10101",
         Input22 when "10110",
         Input23 when "10111",
         Input24 when "11000",
         Input25 when "11001",
         Input26 when "11010",
         Input27 when "11011",
         Input28 when "11100",
         Input29 when "11101",
         Input30 when "11110",
         Input31 when "11111",
         x"00000000"  when others;

Out_signal <= out_signal_temp;
end Behavioral;

