--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:19:21 03/12/2023
-- Design Name:   
-- Module Name:   C:/Users/Giorgos/Desktop/Xilinx_Projects/CPU_2023/Compare_Module_tb.vhd
-- Project Name:  CPU_2023
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Compare_Module
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
 
ENTITY Compare_Module_tb IS
END Compare_Module_tb;
 
ARCHITECTURE behavior OF Compare_Module_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Compare_Module
    PORT(
         Awr_comp : IN  std_logic_vector(4 downto 0);
         Ard1_comp : IN  std_logic_vector(4 downto 0);
         comp_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Awr_comp : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard1_comp : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal comp_out : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Compare_Module PORT MAP (
          Awr_comp => Awr_comp,
          Ard1_comp => Ard1_comp,
          comp_out => comp_out
        );



   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	


		Awr_comp<="00010";
		Ard1_comp<="01000";
		wait for 20 ns;
		Awr_comp<="01000";
		Ard1_comp<="01000";
		wait for 20 ns;
		
		
      wait;
   end process;

END;
