--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:45:15 04/10/2022
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Multiplexe_tb IS
END Multiplexe_tb;
 
ARCHITECTURE behavior OF Multiplexe_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Multiplexer
    PORT(
         Select_in : IN  std_logic_vector(4 downto 0);
         Input0 : IN  std_logic_vector(31 downto 0);
         Input1 : IN  std_logic_vector(31 downto 0);
         Input2 : IN  std_logic_vector(31 downto 0);
         Input3 : IN  std_logic_vector(31 downto 0);
         Input4 : IN  std_logic_vector(31 downto 0);
         Input5 : IN  std_logic_vector(31 downto 0);
         Input6 : IN  std_logic_vector(31 downto 0);
         Input7 : IN  std_logic_vector(31 downto 0);
         Input8 : IN  std_logic_vector(31 downto 0);
         Input9 : IN  std_logic_vector(31 downto 0);
         Input10 : IN  std_logic_vector(31 downto 0);
         Input11 : IN  std_logic_vector(31 downto 0);
         Input12 : IN  std_logic_vector(31 downto 0);
         Input13 : IN  std_logic_vector(31 downto 0);
         Input14 : IN  std_logic_vector(31 downto 0);
         Input15 : IN  std_logic_vector(31 downto 0);
         Input16 : IN  std_logic_vector(31 downto 0);
         Input17 : IN  std_logic_vector(31 downto 0);
         Input18 : IN  std_logic_vector(31 downto 0);
         Input19 : IN  std_logic_vector(31 downto 0);
         Input20 : IN  std_logic_vector(31 downto 0);
         Input21 : IN  std_logic_vector(31 downto 0);
         Input22 : IN  std_logic_vector(31 downto 0);
         Input23 : IN  std_logic_vector(31 downto 0);
         Input24 : IN  std_logic_vector(31 downto 0);
         Input25 : IN  std_logic_vector(31 downto 0);
         Input26 : IN  std_logic_vector(31 downto 0);
         Input27 : IN  std_logic_vector(31 downto 0);
         Input28 : IN  std_logic_vector(31 downto 0);
         Input29 : IN  std_logic_vector(31 downto 0);
         Input30 : IN  std_logic_vector(31 downto 0);
         Input31 : IN  std_logic_vector(31 downto 0);
         Out_signal : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Select_in : std_logic_vector(4 downto 0) := (others => '0');
   signal Input0 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input1 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input2 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input3 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input4 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input5 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input6 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input7 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input8 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input9 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input10 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input11 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input12 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input13 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input14 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input15 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input16 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input17 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input18 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input19 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input20 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input21 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input22 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input23 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input24 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input25 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input26 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input27 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input28 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input29 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input30 : std_logic_vector(31 downto 0) := (others => '0');
   signal Input31 : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Out_signal : std_logic_vector(31 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Multiplexer PORT MAP (
          Select_in => Select_in,
          Input0 => Input0,
          Input1 => Input1,
          Input2 => Input2,
          Input3 => Input3,
          Input4 => Input4,
          Input5 => Input5,
          Input6 => Input6,
          Input7 => Input7,
          Input8 => Input8,
          Input9 => Input9,
          Input10 => Input10,
          Input11 => Input11,
          Input12 => Input12,
          Input13 => Input13,
          Input14 => Input14,
          Input15 => Input15,
          Input16 => Input16,
          Input17 => Input17,
          Input18 => Input18,
          Input19 => Input19,
          Input20 => Input20,
          Input21 => Input21,
          Input22 => Input22,
          Input23 => Input23,
          Input24 => Input24,
          Input25 => Input25,
          Input26 => Input26,
          Input27 => Input27,
          Input28 => Input28,
          Input29 => Input29,
          Input30 => Input30,
          Input31 => Input31,
          Out_signal => Out_signal
        );


   -- Stimulus process
   stim_proc: process
   begin		
	
		wait for 20 ns;  -- To let the internal signal of the MUxer to initialize(after the "after" command!)
		
      -- Set the values to some of the inputs
		Input0 <= x"000000fe";
		Input6 <= x"ff059837";
		Input10 <= x"00ff0000";
		Input31 <= x"fefefefe";
		
		wait for 20 ns;
		Select_in <= "00110";  -- Select Input5
		wait for 20ns;
		Select_in <= "11111"; -- Select Input31
		wait for 20 ns;
		Select_in <= "01010"; -- Select Input10
		wait for 20 ns;

		
		wait;
   end process;

END;
