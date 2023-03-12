--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:23:46 04/10/2022
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Decoder_tb IS
END Decoder_tb;
 
ARCHITECTURE behavior OF Decoder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Decoder
    PORT(
         Awr : IN  std_logic_vector(4 downto 0);
         Out_signals : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Awr : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal Out_signals : std_logic_vector(31 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Decoder PORT MAP (
          Awr => Awr,
          Out_signals => Out_signals
        );

   -- Clock process definitions

   -- Stimulus process
   stim_proc: process
   begin		
	
		Awr <= "00010";
		wait for 20 ns;
		Awr <= "00111";
		wait for 20 ns;
		Awr <= "00101";

      -- insert stimulus here 

      wait;
   end process;

END;
