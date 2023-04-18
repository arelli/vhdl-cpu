LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY DECSTAGE_tb IS
END DECSTAGE_tb;
 
ARCHITECTURE behavior OF DECSTAGE_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT DECSTAGE
    PORT(
         Instr : IN  std_logic_vector(31 downto 0);
         RF_WrEn : IN  std_logic;
         ALU_out : IN  std_logic_vector(31 downto 0);
         MEM_out : IN  std_logic_vector(31 downto 0);
         RF_WrData_sel : IN  std_logic;
         RF_B_sel : IN  std_logic;
         Clk : IN  std_logic;
         Rst : IN  std_logic;
         Immed : OUT  std_logic_vector(31 downto 0);
         RF_A : OUT  std_logic_vector(31 downto 0);
         RF_B : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Instr : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrEn : std_logic := '0';
   signal ALU_out : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_out : std_logic_vector(31 downto 0) := (others => '0');
   signal RF_WrData_sel : std_logic := '0';
   signal RF_B_sel : std_logic := '0';
   signal Clk : std_logic := '0';
   signal Rst : std_logic := '0';

 	--Outputs
   signal Immed : std_logic_vector(31 downto 0);
   signal RF_A : std_logic_vector(31 downto 0);
   signal RF_B : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: DECSTAGE PORT MAP (
          Instr => Instr,
          RF_WrEn => RF_WrEn,
          ALU_out => ALU_out,
          MEM_out => MEM_out,
          RF_WrData_sel => RF_WrData_sel,
          RF_B_sel => RF_B_sel,
          Clk => Clk,
          Rst => Rst,
          Immed => Immed,
          RF_A => RF_A,
          RF_B => RF_B
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
		Rst <= '1';
      wait for 100 ns;	
		Rst<='0';

      wait for Clk_period*1;
		
		RF_B_Sel <= '1';  -- we are working with immediates
		RF_WrEn <= '1';  -- to be able to write in the register file
		RF_WrData_sel <= '1';  --to choose to write data coming from MEM_OUT(input of decstage)
		
		-- 111000 00000 00001 0000000000000110  li r1,6  ( "load the value 6 on register 1")
		-- this should store the immediate on r1, and output it 
      Instr <= "11100000000000010000000000000110"; 
		MEM_out <= "00000000000000000000000000000110";  -- load the (zero extended) immediate from above on the RF
		wait for Clk_period*1;
		
		-- 111000 00000 00010 0000000000000111  li r2,7  ( "load the value 7 on register 2")
		-- this should store the immediate on r2, and output it
		Instr <= "11100000000000100000000000000111";
		MEM_out <= "00000000000000000000000000000111";  -- load the immediate from above on the RF
		wait for Clk_period*1;
		
		
		RF_B_Sel <= '0';  -- no longer have immediate
		RF_WrEn <= '0';	
		RF_WrData_sel <= '0';		
		-- 100000 00001 00011 00010 00000 110000  add r1,r3,r2  ( "add the contents of r1 and r2 and save the result on r3")
		-- this should output the contents of r1 and r2 on RF_a and RF_b, to be forwarded to the ALU.
		-- the Control FSM should produce the fitting signals for that: ALU_Bin_Sel(pass RF_b signal),RF_WrData_Sel(pass ALU_out signal)
		Instr <= "10000000001000110001000000110000";
		
				

      wait;
   end process;

END;


-- test code:
-- opcode| Rs  | Rd  |    Immediate    
-- 111000 00000 00001 0000000000000110  li r1,6  ( "load the value 6 on register 1")
-- 111000 00000 00010 0000000000000111  li r2,7  ( "load the value 7 on register 2")
-- opcode| Rs  | Rd  | rt  | N/A | func
-- 100000 00001 00011 00010 00000 110000  add r1,r3,r2  ( "add the contents of r1 and r2 and save the result on r3")
