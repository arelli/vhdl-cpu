-- This is the whole signle cycle MIPS-like CPU:
-- It contains the instruction and user memory, the ALU, the registers
-- and all the logic for them to work(Controller).
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY CPU_single_cycle_tb IS
END CPU_single_cycle_tb;
 
ARCHITECTURE behavior OF CPU_single_cycle_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU_single_cycle
    PORT(
         Reset : IN  std_logic;
         Clock : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Reset : std_logic := '0';
   signal Clock : std_logic := '0';

   -- Clock period definitions
   constant Clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU_single_cycle PORT MAP (
          Reset => Reset,
          Clock => Clock
        );

   -- Clock process definitions
   Clock_process :process
   begin
		Clock <= '0';
		wait for Clock_period/2;
		Clock <= '1';
		wait for Clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		Reset <= '1';
      wait for Clock_period*2;
		Reset<='0';

      -- insert stimulus here 

      wait;
   end process;

END;
