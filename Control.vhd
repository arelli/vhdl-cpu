-- This is the Control Module: the orchestrator of the whole Datapath, controls
-- the ocntrol signals that are used as input for the datapath: for example, 
-- when we need to do an lw (load word), we need to tell the RF its ok to 
-- write to it(RF_Write_En) and where those data will come from(RF_DataSel).
-- So it is a black box that receives an Instruction(from IF) and outputs
-- the respective control signals for the datapath to work. 
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control is
Port(
	Instr : in STD_LOGIC_VECTOR(31 downto 0);
	ALU_Zero : in STD_LOGIC;
	PC_LdEn : out STD_LOGIC;
	PC_Sel : out STD_LOGIC;
	RF_B_Sel : out STD_LOGIC;
	RF_WrEn : out STD_LOGIC;
	RF_WrData_Sel : out STD_LOGIC;
	ALU_Bin_Sel : out STD_LOGIC;
	ALU_Func : out STD_LOGIC_VECTOR(3 downto 0);
	MEM_WrEn : out STD_LOGIC;
	ByteOp : out STD_LOGIC
);
end Control;

architecture Behavioral of Control is

signal OpCode : STD_LOGIC_VECTOR(5 downto 0);
signal Func : STD_LOGIC_VECTOR(3 downto 0);
signal PC_LdEn_tmp : STD_LOGIC;
signal PC_Sel_tmp: STD_LOGIC;
signal RF_B_Sel_tmp : STD_LOGIC;
signal RF_WrEn_tmp : STD_LOGIC;
signal RF_WrData_Sel_tmp : STD_LOGIC;
signal ALU_Bin_Sel_tmp : STD_LOGIC;
signal ALU_Func_tmp : STD_LOGIC_VECTOR(3 downto 0);
signal MEM_WrEn_tmp : STD_LOGIC;
signal ByteOp_tmp : STD_LOGIC;


begin
OpCode<=Instr(31 downto 26);
Func<=Instr(3 downto 0);
process(OpCode,ALU_Zero,Func)
	begin
	case OpCode is
		when "100000" => 	-- ALL ALU two-register operations
			PC_LdEn_tmp<='1';
			PC_Sel_tmp<='0';
			RF_B_Sel_tmp<='0';
			RF_WrEn_tmp<='1';
			RF_WrData_Sel_tmp<='0';
			ALU_Bin_Sel_tmp<='0';
			ALU_Func_tmp<=Func;  -- just pass the ALU function from the instruction
			MEM_WrEn_tmp<='0';
			ByteOp_tmp<='0';
		when "111000" =>	--li
			PC_LdEn_tmp<='1';
			PC_Sel_tmp<='0';
			RF_B_Sel_tmp<='1';
			RF_WrEn_tmp<='1';
			RF_WrData_Sel_tmp<='0';
			ALU_Bin_Sel_tmp<='1';
			ALU_Func_tmp<="0000";
			MEM_WrEn_tmp<='0';
			ByteOp_tmp<='0';
		when "111001" =>	--lui
			PC_LdEn_tmp<='1';
			PC_Sel_tmp<='0';
			RF_B_Sel_tmp<='1';
			RF_WrEn_tmp<='1';
			RF_WrData_Sel_tmp<='0';
			ALU_Bin_Sel_tmp<='1';
			ALU_Func_tmp<="0000";
			MEM_WrEn_tmp<='0';
			ByteOp_tmp<='0';
		when "110000" =>	--addi
			PC_LdEn_tmp<='1';
			PC_Sel_tmp<='0';
			RF_B_Sel_tmp<='1';
			RF_WrEn_tmp<='1';
			RF_WrData_Sel_tmp<='0';
			ALU_Bin_Sel_tmp<='1';
			ALU_Func_tmp<="0000";
			MEM_WrEn_tmp<='0';
			ByteOp_tmp<='0';
		when "110010" =>	--andi
			PC_LdEn_tmp<='1';
			PC_Sel_tmp<='0';
			RF_B_Sel_tmp<='1';
			RF_WrEn_tmp<='1';
			RF_WrData_Sel_tmp<='0';
			ALU_Bin_Sel_tmp<='1';
			ALU_Func_tmp<="0010";
			MEM_WrEn_tmp<='0';
			ByteOp_tmp<='0';
		when "110011" =>	--ori
			PC_LdEn_tmp<='1';
			PC_Sel_tmp<='0';
			RF_B_Sel_tmp<='1';
			RF_WrEn_tmp<='1';
			RF_WrData_Sel_tmp<='0';
			ALU_Bin_Sel_tmp<='1';
			ALU_Func_tmp<="0011";
			MEM_WrEn_tmp<='0';
			ByteOp_tmp<='0';
		when "111111" =>	--branch
			PC_LdEn_tmp<='1';
			PC_Sel_tmp<='1';
			RF_B_Sel_tmp<='1';
			RF_WrEn_tmp<='0';
			RF_WrData_Sel_tmp<='0';
			ALU_Bin_Sel_tmp<='0';
			ALU_Func_tmp<="0000";
			MEM_WrEn_tmp<='0';
			ByteOp_tmp<='0';
		when "010000" =>	--branch equal
			PC_LdEn_tmp<='1';
			RF_B_Sel_tmp<='1';  -- subtract the two numbers...
			RF_WrEn_tmp<='0';
			RF_WrData_Sel_tmp<='0';
			ALU_Bin_Sel_tmp<='0';
			ALU_Func_tmp<="0001";  -- subtraction!(to check if equal)
			-- the following will only work if the RF and the ALU produce
			-- their results BEFORE the clock edge!!(same for bne)

			if(ALU_Zero='1') then  -- ...if they are equal...
						PC_Sel_tmp <='1';  --... load the immediate into PC!
					else
						PC_Sel_tmp <='0';		
					end if;
			MEM_WrEn_tmp<='0';
			ByteOp_tmp<='0';
		when "010001" =>	--branch not equal
			PC_LdEn_tmp<='1';			
			RF_B_Sel_tmp<='1';  
			RF_WrEn_tmp<='0';
			RF_WrData_Sel_tmp<='0';
			ALU_Bin_Sel_tmp<='0';
			ALU_Func_tmp<="0001";
			if(ALU_Zero='0') then  -- if they are not equal
						PC_Sel_tmp <='1';
					else
						PC_Sel_tmp <='0';		
					end if;
			MEM_WrEn_tmp<='0';
			ByteOp_tmp<='0';
		when "000011" =>	--load byte
			PC_LdEn_tmp<='1';
			PC_Sel_tmp<='0';
			RF_B_Sel_tmp<='1';
			RF_WrEn_tmp<='1';
			RF_WrData_Sel_tmp<='0';
			ALU_Bin_Sel_tmp<='1';
			ALU_Func_tmp<="0000";
			MEM_WrEn_tmp<='0';
			ByteOp_tmp<='1';
		when "000111" =>	--store byte
			PC_LdEn_tmp<='1';
			PC_Sel_tmp<='0';
			RF_B_Sel_tmp<='1';
			RF_WrEn_tmp<='0';
			RF_WrData_Sel_tmp<='0';
			ALU_Bin_Sel_tmp<='1';
			ALU_Func_tmp<="0000";
			MEM_WrEn_tmp<='1';
			ByteOp_tmp<='1';
		when "001111" =>	--load word
			PC_LdEn_tmp<='1';
			PC_Sel_tmp<='0';
			RF_B_Sel_tmp<='1';
			RF_WrEn_tmp<='1';
			RF_WrData_Sel_tmp<='1';
			ALU_Bin_Sel_tmp<='1';
			ALU_Func_tmp<="0000";
			MEM_WrEn_tmp<='0';
			ByteOp_tmp<='0';
		when "011111" =>	--store word
			PC_LdEn_tmp<='1';
			PC_Sel_tmp<='0';
			RF_B_Sel_tmp<='1';
			RF_WrEn_tmp<='0';
			RF_WrData_Sel_tmp<='0';
			ALU_Bin_Sel_tmp<='1';
			ALU_Func_tmp<="0000";
			MEM_WrEn_tmp<='1';
			ByteOp_tmp<='0';
--		when "000000"=>	-- Consider it as nop and proceed to next IF Instruction
--			PC_LdEn_tmp<='1';
--			PC_Sel_tmp<='0';
--			RF_B_Sel_tmp<='0';
--			RF_WrEn_tmp<='0';
--			RF_WrData_Sel_tmp<='0';
--			ALU_Bin_Sel_tmp<='0';
--			ALU_Func_tmp<="0000";
--			MEM_WrEn_tmp<='0';
--			ByteOp_tmp<='0';
		when others =>	
			PC_LdEn_tmp<='1';
			PC_Sel_tmp<='0';
			RF_B_Sel_tmp<='0';
			RF_WrEn_tmp<='0';
			RF_WrData_Sel_tmp<='0';
			ALU_Bin_Sel_tmp<='0';
			ALU_Func_tmp<="0000";
			MEM_WrEn_tmp<='0';
			ByteOp_tmp<='0';
	end case;
end process;

	PC_LdEn<=PC_LdEn_tmp;
	PC_Sel<=PC_Sel_tmp;
	RF_B_Sel<=RF_B_Sel_tmp;
	RF_WrEn<=RF_WrEn_tmp;
	RF_WrData_Sel<=RF_WrData_Sel_tmp;
	ALU_Bin_Sel<=ALU_Bin_Sel_tmp;
	ALU_Func<=ALU_Func_tmp;
	MEM_WrEn<=MEM_WrEn_tmp;
	ByteOp<=ByteOp_tmp;

end Behavioral;

