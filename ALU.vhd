----------------------------------------------------------------------------------
-- Company: Technical University of Crete
-- Engineer: Antonios Rafail Ellinitakis
-- 
-- Create Date:    23:04:04 04/05/2022 
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL; -- confuses "-","+" with STD_LOGIC_SIGNED.all
use IEEE.STD_LOGIC_SIGNED.all;
use ieee.NUMERIC_STD.all;

-- Here are defined the input and output "pins" of our "circuit"
entity ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end ALU;

-- Here we can define "wires"(internal signals) running from each "pin" 
architecture Behavioral of ALU is
	signal output_wire:STD_LOGIC_VECTOR (31 downto 0);
	signal output_wire_33_bits:STD_LOGIC_VECTOR (32 downto 0);
	signal zero_flag_wire:STD_LOGIC := '0';  -- the default value is zero(?)
	signal ovf_wire:STD_LOGIC := '0';
	signal cout_wire:STD_LOGIC := '0';

--> variables in processes are like "local" variables in functions
--> they are assigned with ":="
--> they are defined between the "process" and "begin" keywords
--> they always get immediately the value that is assigned to them.

--> signals are like global variables 
--> they are assigned with "<="
--> Signals are defined in the architecture, before the begin keyword.
--> they do not always get immediately the change applied to them
--> (in combinatorial code, they get the values immediately. In sequential they wait for certain events)

begin
	-- the process is a behavioral description of the circuit
	-- a process is executed sequentially, but different processes are executed concurrently!
	process(A,B, Op)  -- inside the parenthes(e)is, there is the sensitivity list of signals.Changes to these signals, trigger this process to execute.
	begin
		case(Op) is  -- the case statement is like a MUXer with the "Op" signal as input
			-- Arithmetic Addition
			when "0000" => output_wire <= A+B;
			-- Arithmetic Subtraction
			when "0001" => output_wire <= A-B;
			-- Logical AND
			when "0010" => output_wire <= A and B;  -- logical operators in VHDL are called by their name
			-- Logical OR
			when "0011" => output_wire <= A or B;
			-- Inversion of A
			when "0100" => output_wire <= not A;
			-- Numerical shift Right
			when "1000" =>
				output_wire <= std_logic_vector(shift_right(signed(A), 1));
			--Logical shift Right
			when "1001" =>
				output_wire <= std_logic_vector(shift_right(unsigned(A), 1));  -- unsigned because it is a logical shift
			-- Numerical Shift Left
			when "1010" =>
				output_wire <= std_logic_vector(shift_left(signed(A), 1));
			-- Rotate Left by 1
			when "1100" =>
				output_wire <=  std_logic_vector(signed(A) rol 1);
			-- Rotate Right by 1
			when "1101" =>
				output_wire <= std_logic_vector(signed(A) ror 1);
			when others => 
				output_wire <= "00000000000000000000000000000000";
		end case;
				
	end process;
	
	-- Cout, Zero and OVF Flags control(simultaneously with the above, hence the different process)
	process(A,B,Op,output_wire)
	begin
		--Check for zero output
		if(output_wire = x"00000000") then 	--zero flag
			zero_flag_wire <= '1';  -- set the Zero Flag
		else 
			zero_flag_wire <= '0';
		end if;
		
		-- Check for Ovf
		-- In Addition of signed numbers, positive + positive must be positive, and negative + negative must be negative
		if ((A(31) = B(31)) and (A(31) /= output_wire(31)) and (Op = "0000")) then
			ovf_wire <= '1';
		-- In subtraction, the opposite is true.
		elsif ((A(31) /= B(31)) and (A(31) /= output_wire(31)) and (Op = "0001")) then
			ovf_wire <= '1';
		else 
			ovf_wire <= '0';
		end if;
		
		-- Check for a Carry Out
		if (Op="0001") then
			output_wire_33_bits <= (A(31) & A) - (B(31) & B);
			cout_wire <= output_wire_33_bits(32);  -- if there is a 33rd bit produced, send it as a Cout flag
		elsif (Op="0000") then
			output_wire_33_bits <= (A(31) & A) + (B(31) & B);
			cout_wire <= output_wire_33_bits(32); 
		else
			cout_wire <= '0';
		end if;
			
	end process;
				
			

	-- Create the logic of the output signals:
	
	Output <= output_wire after 10ns; -- Send the result to the output of the ALU
	Cout <= cout_wire after 10 ns;
	Ovf <= ovf_wire after 10ns;
	Zero <= zero_flag_wire after 10ns;
	
end Behavioral;

