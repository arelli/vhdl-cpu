library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Datapath is
    Port ( Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           PC_sel : in  STD_LOGIC;
           PC_LdEn : in  STD_LOGIC;
           RF_WrEn : in  STD_LOGIC;
           RF_WrData_sel : in  STD_LOGIC;
           RF_B_sel : in  STD_LOGIC;
           ALU_Bin_sel : in  STD_LOGIC;
           ALU_func : in  STD_LOGIC_VECTOR (3 downto 0);
           MEM_WrEn : in  STD_LOGIC);
end Datapath;

architecture Behavioral of Datapath is

begin


end Behavioral;

