--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:11:45 04/10/2022
-- Design Name:   
-- Module Name:   C:/Xilinx/projects/OrganosiYpologiston/RegisterFile_tb.vhd
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY RegisterFile_tb IS
END RegisterFile_tb;
 
ARCHITECTURE behavior OF RegisterFile_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFile
    PORT(
         Ard1 : IN  std_logic_vector(4 downto 0);
         Ard2 : IN  std_logic_vector(4 downto 0);
         Awr : IN  std_logic_vector(4 downto 0);
         Dout1 : OUT  std_logic_vector(31 downto 0);
         Dout2 : OUT  std_logic_vector(31 downto 0);
         Din : IN  std_logic_vector(31 downto 0);
         WrEn : IN  std_logic;
         Clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Ard1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Ard2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');
   signal Din : std_logic_vector(31 downto 0) := (others => '0');
   signal WrEn : std_logic := '0';
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';

 	--Outputs
   signal Dout1 : std_logic_vector(31 downto 0);
   signal Dout2 : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 100 ns;  -- important: we have to set this to 100ns according to mr. Papadimitriou
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile PORT MAP (
          Ard1 => Ard1,
          Ard2 => Ard2,
          Awr => Awr,
          Dout1 => Dout1,
          Dout2 => Dout2,
          Din => Din,
          WrEn => WrEn,
          Clk => Clk
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
      --wait for Clk_period*40;

      -- Write info to some registers
		Din <= x"0f0f0f0f";  -- Write this value...
		WrEn <='1';         -- ... after enabling us to do so... 
		Awr <= "00001";  -- ... to the register No. 1
		wait for Clk_period;
		
		Din <= x"eabeab00";  -- Write this value...
		Awr <= "00011";  -- ... to the register No. 3
		wait for Clk_period;
		
		Din <= x"baabbaab";  -- Write this value...
		Awr <= "10001";  -- ... to the register No. 17
		wait for Clk_period;
				
				
		-- "remember" data on the registers
		Din <= x"00000000";  -- this is not needed.
		WrEn <= '0';  -- We stopped writing, so we dont need it Enabled anymore
		wait for Clk_period*4;
		
		
		-- Read from some registers
		Ard1 <= "00001";  -- ... from register 1
		wait for Clk_period;
		
		Ard1 <= "00011";  -- ... from register 3
		wait for Clk_period;
		
		Ard2 <= "10001";  -- ... from register 17
		wait for Clk_period;

      wait;
   end process;

END;
