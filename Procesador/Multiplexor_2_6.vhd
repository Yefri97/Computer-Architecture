library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Multiplexor_2_6 is
    Port ( input0 : in  STD_LOGIC_VECTOR (5 downto 0);
           input1 : in  STD_LOGIC_VECTOR (5 downto 0);
           cond : in  STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (5 downto 0));
end Multiplexor_2_6;

architecture Behavioral of Multiplexor_2_6 is

begin
process (cond, input0, input1)
begin
	if(cond = '0') then
		output <= input0;
	else
		output <= input1;
	end if;
end process;
end Behavioral;

