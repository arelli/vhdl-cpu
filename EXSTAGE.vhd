library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity EXSTAGE is
    Port ( RF_A : in  STD_LOGIC_VECTOR (31 downto 0);
           RF_B : in  STD_LOGIC_VECTOR (31 downto 0);
           Immed : in  STD_LOGIC_VECTOR (31 downto 0);
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           ALU_out : out  STD_LOGIC_VECTOR (31 downto 0);
			  ALU_zero: out  STD_LOGIC );
end EXSTAGE;

architecture Behavioral of EXSTAGE is

signal reg2_muxed : std_logic_vector (31 downto 0);
signal alu_out_tmp : std_logic_vector (31 downto 0);
signal ALU_zero_tmp :STD_LOGIC;

Component mux32_2_to_1 is
    Port ( Select_in : in  STD_LOGIC;
           Input0 : in  STD_LOGIC_VECTOR (31 downto 0);
           Input1 : in  STD_LOGIC_VECTOR (31 downto 0);
           mux_out : out  STD_LOGIC_VECTOR (31 downto 0));
end Component;

Component ALU is
    Port ( A : in  STD_LOGIC_VECTOR (31 downto 0);
           B : in  STD_LOGIC_VECTOR (31 downto 0);
           Op : in  STD_LOGIC_VECTOR (3 downto 0);
           Output : out  STD_LOGIC_VECTOR (31 downto 0);
           Zero : out  STD_LOGIC;
           Cout : out  STD_LOGIC;
           Ovf : out  STD_LOGIC);
end Component;

begin

mux_reg2 : mux32_2_to_1 PORT MAP (
				Input0=>RF_B,
				Input1=>Immed,
				mux_out=>reg2_muxed,
				Select_in=>ALU_Bin_sel
			);
ex_alu : ALU PORT MAP (
				A=>RF_A,
				B=>reg2_muxed,
				Op=>ALU_func,
				Output=>alu_out_tmp,
				Zero=>ALU_zero_tmp,
				Cout=>open,
				Ovf=>open
			);

ALU_out<=alu_out_tmp;
ALU_Zero <= ALU_zero_tmp;

end Behavioral;

