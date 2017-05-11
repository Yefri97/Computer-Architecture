library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DataMemory is
    Port ( ADDRESS : in  STD_LOGIC_VECTOR (4 downto 0);
           CRD : in  STD_LOGIC_VECTOR (31 downto 0);
           WRENMEM : in  STD_LOGIC;
           CMEM : out  STD_LOGIC_VECTOR (31 downto 0));
end DataMemory;

architecture Behavioral of DataMemory is

type ram_type is array (31 downto 0) of std_logic_vector (31 downto 0);
signal RAM : ram_type;

begin

process (WRENMEM) begin
	if (WRENMEM = '1') then
		RAM(conv_integer(ADDRESS)) <= CRD;
	end if;
	CMEM <= RAM(conv_integer(ADDRESS));
end process;

end Behavioral;