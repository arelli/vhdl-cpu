LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY incrementor4_tb IS
END incrementor4_tb;
 
ARCHITECTURE behavior OF incrementor4_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT incrementor4
    PORT(
         pc_in : IN  std_logic_vector(31 downto 0);
         pc_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal pc_in : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal pc_out : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: incrementor4 PORT MAP (
          pc_in => pc_in,
          pc_out => pc_out
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      pc_in <= x"00000001";
		
		wait for 100 ns;	

      pc_in <= x"0000f894";
		wait for 100 ns;

      wait;
   end process;

END;
