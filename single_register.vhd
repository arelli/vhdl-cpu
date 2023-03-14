----------------------------------------------------------------------------------
-- This is the register that will be used as a component in the register file
-- of our CPU model.
-- Create Date:    14:26:56 04/09/2022 
-- Design Name: 
-- Module Name:    RF - Behavioral 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity single_register is  -- A 32-bit Register
    Port ( CLK : in  STD_LOGIC;  -- clock
           RST : in  STD_LOGIC;  -- reset registero to 0
           Datain : in  STD_LOGIC_VECTOR (31 downto 0); -- input bus
           WE : in  STD_LOGIC;  -- Write Enable(inout means a bidirectional bus, able to check its value internally without intermediate signal/buffer)
           Dataout : out  STD_LOGIC_VECTOR (31 downto 0));  --Data output bus
end single_register;

architecture Behavioral of single_register is
	signal Dataout_temp : STD_LOGIC_VECTOR(31 downto 0);
	-- we need this buffer to read from the input
	signal WE_in_temp : STD_LOGIC ;
begin
	-- Here we define the behavior of the Register
	process(CLK)  --  we want changes to (potentially) happen only when the CLK  signal changes
	begin
		if rising_edge(CLK) then  -- rising_edge
			if (RST='1') then
				Dataout_temp <= x"00000000";
			else
				if (WE_in_temp='1') then
					Dataout_temp <= Datain;  -- write new data to the register
				else
					Dataout_temp <= Dataout_temp;  -- important! This is the "latch", that stores the value
				end if;				
			end if;
		end if;
	end process;
	
	WE_in_temp <= WE;
	Dataout <= Dataout_temp;  -- finally send the signal out with a 10 ns delay
end Behavioral;

