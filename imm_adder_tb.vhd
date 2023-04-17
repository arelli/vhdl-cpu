LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY imm_adder_tb IS
END imm_adder_tb;
 
ARCHITECTURE behavior OF imm_adder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT imm_adder
    PORT(
         imm : IN  std_logic_vector(31 downto 0);
         pc_in : IN  std_logic_vector(31 downto 0);
         add_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal imm : std_logic_vector(31 downto 0) := (others => '0');
   signal pc_in : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal add_out : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: imm_adder PORT MAP (
          imm => imm,
          pc_in => pc_in,
          add_out => add_out
        );
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 10 ns;	
		imm <= x"000000ff";
		pc_in <= x"00000001";
		
		wait for 10 ns;	
		imm <= x"000000ff";
		pc_in <= x"000000fb";

      wait;
   end process;

END;
