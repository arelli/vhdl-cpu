--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY IFSTAGE_RAMED_tb IS
END IFSTAGE_RAMED_tb;
 
ARCHITECTURE behavior OF IFSTAGE_RAMED_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IFSTAGE_RAMED
    PORT(
         PC_Immed : IN  std_logic_vector(31 downto 0);
         PC_sel : IN  std_logic;
         PC_LdEn : IN  std_logic;
         Reset : IN  std_logic;
         Clk : IN  std_logic;
         Instr : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_Immed : std_logic_vector(31 downto 0) := (others => '0');
   signal PC_sel : std_logic := '0';
   signal PC_LdEn : std_logic := '0';
   signal Reset : std_logic := '0';
   signal Clk : std_logic := '0';

 	--Outputs
   signal Instr : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IFSTAGE_RAMED PORT MAP (
          PC_Immed => PC_Immed,
          PC_sel => PC_sel,
          PC_LdEn => PC_LdEn,
          Reset => Reset,
          Clk => Clk,
          Instr => Instr
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      
		-- hold reset state for 100 ns.
		Reset <= '1';
      wait for 100 ns;	
		Reset <= '0';

		PC_sel <= '0';  -- select auto increment mode.
		PC_LdEn <= '1';  -- to be able to write in the PC register!
	

      wait for Clk_period*10;
		
		PC_LdEn <= '0';  -- check that without PC_LdEn, PC does not increment
		wait for Clk_period*3;
		
		PC_sel <= '1';  -- Test jumping to immediate address.
		PC_LdEn <= '1';
		PC_Immed <= "11111111111111111111111111111000";  -- (-8) in signed binary
		wait for Clk_period*1;
		
		PC_sel <= '0';  -- Put the PC in normal auto-incrementing mode again.

      wait;
   end process;

END;
