--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:35:42 03/12/2023
-- Design Name:   
-- Module Name:   C:/Users/Giorgos/Desktop/Xilinx_Projects/CPU_2023/mux2to1_tb.vhd
-- Project Name:  CPU_2023
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: mux32_2_to_1
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY mux2to1_tb IS
END mux2to1_tb;
 
ARCHITECTURE behavior OF mux2to1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT mux32_2_to_1
    PORT(
         Select_in : IN  std_logic;
         Input0 : IN  std_logic_vector(31 downto 0);
         Input1 : IN  std_logic_vector(31 downto 0);
         mux_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Select_in : std_logic := '0';
   signal Input0 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input1 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal mux_out : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: mux32_2_to_1 PORT MAP (
          Select_in => Select_in,
          Input0 => Input0,
          Input1 => Input1,
          mux_out => mux_out
        );

   -- Clock process definitions


   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		Input0 <= x"000000fe";
		Input1<= x"ff059837";

		wait for 20 ns;
		Select_in <= '0';  
		wait for 20ns;
		Select_in <= '1'; 
		wait for 20 ns;
		Select_in <= '0'; 
		wait for 20 ns;
      wait;
   end process;

END;
