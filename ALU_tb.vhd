--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
-- Create Date:   20:53:07 04/08/2022
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ALU_tb IS
END ALU_tb;
 
ARCHITECTURE behavior OF ALU_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         Op : IN  std_logic_vector(3 downto 0);
         Output : OUT  std_logic_vector(31 downto 0);
         Zero : OUT  std_logic;
         Cout : OUT  std_logic;
         Ovf : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');
   signal Op : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(31 downto 0);
   signal Zero : std_logic;
   signal Cout : std_logic;
   signal Ovf : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --  --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A => A,
          B => B,
          Op => Op,
          Output => Output,
          Zero => Zero,
          Cout => Cout,
          Ovf => Ovf
        );


   -- Stimulus process
   stim_proc: process
   begin		
		-- Addition and Zero Flag
		Op <= "0000";
		A <=  x"00000000";
		B <=  x"00000000";
		wait for 50 ns;	
		
		-- Subtraction
		Op <= "0001";
		A <=  x"0000000f";
		B <=  x"00000001";
		wait for 50 ns;
		
		-- Carry and OVF at addition
		Op <= "0000";
		A <=  x"80000000";
		B <=  x"ffffffff";
		wait for 50 ns;
		
		-- OVF at addition
		Op <= "0000";
		A <=  x"7fffffff";
		B <=  x"00000001";
		wait for 50 ns;		
		
		-- OVF at subtraction
		Op <= "0001";
		A <=  x"7fffffff";
		B <=  x"ffffffff";
		wait for 50 ns;
		
		-- Carry at subtraction
		Op <= "0001";
		A <=  x"fffffffe";
		B <=  x"ffffffff";
		wait for 50 ns;
		
		-- Simple Addition
		Op <= "0000";
		A <=  x"00000008";
		B <=  x"00000009";
		wait for 50 ns;
		
		-- Numerical shift right
		Op <= "1000";
		A <=  x"f0000008";
		wait for 50 ns;
		
		-- Logical shift right
		Op <= "1001";
		A <=  x"f0000002";
		wait for 50 ns;
		
		-- Logical shift left
		Op <= "1010";
		A <=  x"0000000f";
		wait for 50 ns;
		
		-- Rotate left
		Op <= "1100";
		A <=  x"f000000e";
		wait for 50 ns;
		
		-- Rotate right
		Op <= "1101";
		A <=  x"e000000f";
		wait for 50 ns;
		
		-- AND
		Op <= "0010";
		A <=  x"00000fff";
		B <=  x"0e00000e";
		wait for 50 ns;
		
		-- OR
		Op <= "0011";
		A <=  x"00000fff";
		B <=  x"0e00000e";
		wait for 50 ns;
		
		-- Not
		Op <= "0100";
		A <=  x"0f0b0802";
		wait for 50 ns;
		
		

      wait;
   end process;

END;
