library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegisterFile is
    Port ( rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
           rst : in  STD_LOGIC;
           DWR : in  STD_LOGIC_VECTOR (31 downto 0);
           rs1Out : out  STD_LOGIC_VECTOR (31 downto 0);
           rs2Out : out  STD_LOGIC_VECTOR (31 downto 0));
end RegisterFile;

architecture Behavioral of RegisterFile is

type ram_type is array (31 downto 0) of std_logic_vector (31 downto 0);
signal RAM : ram_type;

begin

process (rst, rd, dwr, ram, rs1, rs2)
begin
	if (rst = '1') then
		RAM(0) <= x"00000000";
	else
		if (not(rd = "00000")) then
			RAM(conv_integer(rd)) <= DWR;
		end if;
		rs1Out <= RAM(conv_integer(rs1));
		rs2Out <= RAM(conv_integer(rs2));
	end if;
end process;

end Behavioral;