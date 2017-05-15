library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SignExtender_30 is
    Port ( input : in  STD_LOGIC_VECTOR (29 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end SignExtender_30;

architecture Behavioral of SignExtender_30 is

begin
process (input)
begin
	if(input(29) = '1') then
		output <= "11"&input;
	else
		output <= "00"&input;
	end if;
end process;
end Behavioral;

