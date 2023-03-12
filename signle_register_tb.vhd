--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:10:37 04/10/2022
-- Design Name:   
-- Module Name:   C:/Xilinx/projects/OrganosiYpologiston/RF_tb.vhd
-- Project Name:  OrganosiYpologiston
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RF
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
 
ENTITY single_register_tb IS
END single_register_tb;
 
ARCHITECTURE behavior OF single_register_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT single_register
    PORT(
         CLK : IN  std_logic;
         Datain : IN  std_logic_vector(31 downto 0);
         WE : INOUT  std_logic;
         Dataout : OUT std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
	--signal WE : std_logic := '0';
   signal Datain : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal WE : std_logic;
	signal Dataout : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: single_register PORT MAP (
          CLK => CLK,
          Datain => Datain,
          WE => WE,
          Dataout => Dataout
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      wait for 10 ns;

		WE <= '0';
      wait for CLK_period*3;
		

      -- insert stimulus here 
		wait for 50 ns;
		-- make some data available for the register
		Datain <= x"0000003f";  -- they will not be written untill WE is enabled
		wait for 50 ns;
		
		WE <= '1';  -- actually write the data in the register
		wait for 50 ns;
		WE <= '0';
		
		wait for 100 ns; -- acutally remember the data for 100 ns
		
		-- Write some new data
		Datain <= x"feae9385";
		WE <= '1';
		wait for 50 ns;
		WE <= '0';
			
		
		-- Try to insert new data without WE enabled
		Datain <= x"000000ee";

      wait;
   end process;

END;
