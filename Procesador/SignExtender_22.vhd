library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SignExtender_22 is
    Port ( input : in  STD_LOGIC_VECTOR (21 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end SignExtender_22;

architecture Behavioral of SignExtender_22 is

begin
process (input)
begin
	if(input(21) = '1') then
		output <= "1111111111"&input;
	else
		output <= "0000000000"&input;
	end if;
end process;
end Behavioral;

