--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY MEMSTAGE_tb IS
END MEMSTAGE_tb;
 
ARCHITECTURE behavior OF MEMSTAGE_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MEMSTAGE
    PORT(
         clk : IN  std_logic;
         Mem_WrEn : IN  std_logic;
         ALU_MEM_Addr : IN  std_logic_vector(31 downto 0);
         MEM_DataIn : IN  std_logic_vector(31 downto 0);
         MEM_DataOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal Mem_WrEn : std_logic := '0';
   signal ALU_MEM_Addr : std_logic_vector(31 downto 0) := (others => '0');
   signal MEM_DataIn : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal MEM_DataOut : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MEMSTAGE PORT MAP (
          clk => clk,
          Mem_WrEn => Mem_WrEn,
          ALU_MEM_Addr => ALU_MEM_Addr,
          MEM_DataIn => MEM_DataIn,
          MEM_DataOut => MEM_DataOut
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		Mem_WrEn <= '1';  -- enable Writing to memory

		ALU_MEM_Addr <= x"00000001";  -- write on address 1...
		MEM_DataIn <= x"0000000f";  -- ... the number 15.
		
		wait for clk_period*2;
		ALU_MEM_Addr <= x"00000002";
		MEM_DataIn <= x"000000ef";
		
		wait for clk_period*2;
		ALU_MEM_Addr <= x"00000003";
		MEM_DataIn <= x"000000af";
		
		wait for clk_period*2;
		ALU_MEM_Addr <= x"0000000f";
		MEM_DataIn <= x"000000ff";
		wait for clk_period*2;
		
		Mem_WrEn <= '0';  -- Stop writing to memory
		wait for clk_period*2;
		
		ALU_MEM_Addr <= x"00000001";  -- Begin reading the above written data
		wait for clk_period*2;
		
		ALU_MEM_Addr <= x"0000000f";
		wait for clk_period*2;
		
		ALU_MEM_Addr <= x"00000002";
		wait for clk_period*2;
		
		ALU_MEM_Addr <= x"00000003";
		wait for clk_period*2;
		

      wait;
   end process;

END;
