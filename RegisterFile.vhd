----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:15:24 04/10/2022 
-- Design Name: 
-- Module Name:    RegisterFile - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegisterFile is
    Port ( Ard1 : in  STD_LOGIC_VECTOR (4 downto 0);  -- Address (to) read data 1
           Ard2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Awr : in  STD_LOGIC_VECTOR (4 downto 0);  -- Address (to) write data 
           Dout1 : out  STD_LOGIC_VECTOR (31 downto 0);  -- Data output 1
           Dout2 : out  STD_LOGIC_VECTOR (31 downto 0);
           Din : in  STD_LOGIC_VECTOR (31 downto 0);  -- Data Input
           WrEn : in  STD_LOGIC;  -- Write enable
           Clk : in  STD_LOGIC);
end RegisterFile;

architecture Behavioral of RegisterFile is
	-- include the register as a component
	COMPONENT single_register is
    PORT(
         CLK : IN  std_logic;
         Datain : IN  std_logic_vector(31 downto 0);
         WE : INOUT  std_logic;
         Dataout : OUT std_logic_vector(31 downto 0)
        );
    END COMPONENT;

	 
	 COMPONENT Compare_Module is

    Port ( Awr_comp : in  STD_LOGIC_VECTOR (4 downto 0);

           Ard1_comp : in  STD_LOGIC_VECTOR (4 downto 0);

           comp_out : out  STD_LOGIC);

	end COMPONENT;

	
	 -- include also the decoder
	 COMPONENT Decoder
    PORT(
         Awr : IN  std_logic_vector(4 downto 0);
         Out_signals : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
	 

	 COMPONENT mux32_2_to_1 is

    Port ( Select_in : in  STD_LOGIC;

           Input0 : in  STD_LOGIC_VECTOR (31 downto 0);

           Input1 : in  STD_LOGIC_VECTOR (31 downto 0);

           mux_out : out  STD_LOGIC_VECTOR (31 downto 0));

	end COMPONENT;

	
	 -- include the multiplexer as a compontent
	 COMPONENT Multiplexer is
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
	 
	 -- Declare all the 32 32-bit buses going from the 32 registers to each Multiplexer
	 type reg_mux_bus is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
	 signal reg_to_mux:reg_mux_bus;  -- this is a new type: an array that contains 32 buses of 32 bit each.
	 
	 -- declare the internal signals

	 signal WE_internal : STD_LOGIC_VECTOR(31 downto 0);
	 signal dec_out : STD_LOGIC_VECTOR(31 downto 0);
	 signal dout1_internal: STD_LOGIC_VECTOR(31 downto 0);
	 signal dout2_internal: STD_LOGIC_VECTOR(31 downto 0);

	 signal mux_2_1_sel_1: STD_LOGIC;

	 signal mux_2_1_sel_2: STD_LOGIC;

begin

	-- instantiate the decoder
	-- here we assign each "internal" pin of the decoder, to the
	-- rest of the Register File circuit
	decoder_component:Decoder port map(
		Awr => Awr,
		Out_signals(0) => dec_out(0),
		Out_signals(1) => dec_out(1),
		Out_signals(2) => dec_out(2),
		Out_signals(3) => dec_out(3),
		Out_signals(4) => dec_out(4),
		Out_signals(5) => dec_out(5),
		Out_signals(6) => dec_out(6),
		Out_signals(7) => dec_out(7),
		Out_signals(8) => dec_out(8),
		Out_signals(9) => dec_out(9),
		Out_signals(10) => dec_out(10),
		Out_signals(11) => dec_out(11),
		Out_signals(12) => dec_out(12),
		Out_signals(13) => dec_out(13),
		Out_signals(14) => dec_out(14),
		Out_signals(15) => dec_out(15),
		Out_signals(16) => dec_out(16),
		Out_signals(17) => dec_out(17),
		Out_signals(18) => dec_out(18),
		Out_signals(19) => dec_out(19),
		Out_signals(20) => dec_out(20),
		Out_signals(21) => dec_out(21),
		Out_signals(22) => dec_out(22),
		Out_signals(23) => dec_out(23),
		Out_signals(24) => dec_out(24),
		Out_signals(25) => dec_out(25),
		Out_signals(26) => dec_out(26),
		Out_signals(27) => dec_out(27),
		Out_signals(28) => dec_out(28),
		Out_signals(29) => dec_out(29),
		Out_signals(30) => dec_out(30),
		Out_signals(31) => dec_out(31)
	);
	
	muxer1 :Multiplexer port map(
		Out_signal => dout1_internal,
		Input0 => reg_to_mux(0),
		Input1 => reg_to_mux(1),
		Input2 => reg_to_mux(2),
		Input3 => reg_to_mux(3),
		Input4 => reg_to_mux(4),
		Input5 => reg_to_mux(5),
		Input6 => reg_to_mux(6),
		Input7 => reg_to_mux(7),
		Input8 => reg_to_mux(8),
		Input9 => reg_to_mux(9),
		Input10 => reg_to_mux(10),
		Input11 => reg_to_mux(11),
		Input12 => reg_to_mux(12),
		Input13 => reg_to_mux(13),
		Input14 => reg_to_mux(14),
		Input15 => reg_to_mux(15),
		Input16 => reg_to_mux(16),
		Input17 => reg_to_mux(17),
		Input18 => reg_to_mux(18),
		Input19 => reg_to_mux(19),
		Input20 => reg_to_mux(20),
		Input21 => reg_to_mux(21),
		Input22 => reg_to_mux(22),
		Input23 => reg_to_mux(23),
		Input24 => reg_to_mux(24),
		Input25 => reg_to_mux(25),
		Input26 => reg_to_mux(26),
		Input27 => reg_to_mux(27),
		Input28 => reg_to_mux(28),
		Input29 => reg_to_mux(29),
		Input30 => reg_to_mux(30),
		Input31 => reg_to_mux(31),
		Select_in => Ard1
	);
	
	muxer2:Multiplexer port map(
		Out_signal => dout2_internal,
		Input0 => reg_to_mux(0),
		Input1 => reg_to_mux(1),
		Input2 => reg_to_mux(2),
		Input3 => reg_to_mux(3),
		Input4 => reg_to_mux(4),
		Input5 => reg_to_mux(5),
		Input6 => reg_to_mux(6),
		Input7 => reg_to_mux(7),
		Input8 => reg_to_mux(8),
		Input9 => reg_to_mux(9),
		Input10 => reg_to_mux(10),
		Input11 => reg_to_mux(11),
		Input12 => reg_to_mux(12),
		Input13 => reg_to_mux(13),
		Input14 => reg_to_mux(14),
		Input15 => reg_to_mux(15),
		Input16 => reg_to_mux(16),
		Input17 => reg_to_mux(17),
		Input18 => reg_to_mux(18),
		Input19 => reg_to_mux(19),
		Input20 => reg_to_mux(20),
		Input21 => reg_to_mux(21),
		Input22 => reg_to_mux(22),
		Input23 => reg_to_mux(23),
		Input24 => reg_to_mux(24),
		Input25 => reg_to_mux(25),
		Input26 => reg_to_mux(26),
		Input27 => reg_to_mux(27),
		Input28 => reg_to_mux(28),
		Input29 => reg_to_mux(29),
		Input30 => reg_to_mux(30),
		Input31 => reg_to_mux(31),
		Select_in => Ard2
	);
	
	-- Generate all 32 registers in one statement with for-generate
	registers : for i in 0 to 31 generate
		reg:single_register port map(
			Clk => Clk,
			WE => WE_internal(i),
			Datain =>  Din,  -- every register has the same input bus, but different enable signals
			Dataout => reg_to_mux(i)  -- this is a 32- bit bus. Check in the declaration above
		);
	end generate;
	

	comp_mod_1:Compare_Module port map(
		Awr_comp => Awr,
		Ard1_comp => Ard1,
      comp_out => mux_2_1_sel_1
	);

	comp_mod_2:Compare_Module port map(
		Awr_comp => Awr,
		Ard1_comp => Ard2,
      comp_out => mux_2_1_sel_2
	);

	MUX_2_1_1:mux32_2_to_1 port map(
		Select_in => mux_2_1_sel_1,
      Input0 => dout1_internal,
      Input1 => Din,
      mux_out => Dout1
	);

	MUX_2_1_2:mux32_2_to_1 port map(
		Select_in => mux_2_1_sel_2,
      Input0 => dout2_internal,
      Input1 => Din,
      mux_out => Dout2
	);


-- The "AND" gates of the WrEn signal are gonna be here. They are a combinatorial circuit.
--> Implement the combinatorial logic of the Write Enable 
WE_internal(0) <= '0';  -- this is because the 0 Register in MIPS is traditinally, constantly zero.
WE_internal(1) <= (dec_out(1) and WrEn);
WE_internal(2) <= (dec_out(2) and WrEn);
WE_internal(3) <= (dec_out(3) and WrEn);
WE_internal(4) <= (dec_out(4) and WrEn);
WE_internal(5) <= (dec_out(5) and WrEn);
WE_internal(6) <= (dec_out(6) and WrEn);
WE_internal(7) <= (dec_out(7) and WrEn);
WE_internal(8) <= (dec_out(8) and WrEn);
WE_internal(9) <= (dec_out(9) and WrEn);
WE_internal(10) <= (dec_out(10) and WrEn);
WE_internal(11) <= (dec_out(11) and WrEn);
WE_internal(12) <= (dec_out(12) and WrEn);
WE_internal(13) <= (dec_out(13) and WrEn);
WE_internal(14) <= (dec_out(14) and WrEn);
WE_internal(15) <= (dec_out(15) and WrEn);
WE_internal(16) <= (dec_out(16) and WrEn);
WE_internal(17) <= (dec_out(17) and WrEn);
WE_internal(18) <= (dec_out(18) and WrEn);
WE_internal(19) <= (dec_out(19) and WrEn);
WE_internal(20) <= (dec_out(20) and WrEn);
WE_internal(21) <= (dec_out(21) and WrEn);
WE_internal(22) <= (dec_out(22) and WrEn);
WE_internal(23) <= (dec_out(23) and WrEn);
WE_internal(24) <= (dec_out(24) and WrEn);
WE_internal(25) <= (dec_out(25) and WrEn);
WE_internal(26) <= (dec_out(26) and WrEn);
WE_internal(27) <= (dec_out(27) and WrEn);
WE_internal(28) <= (dec_out(28) and WrEn);
WE_internal(29) <= (dec_out(29) and WrEn);
WE_internal(30) <= (dec_out(30) and WrEn);
WE_internal(31) <= (dec_out(31) and WrEn);

end Behavioral;

