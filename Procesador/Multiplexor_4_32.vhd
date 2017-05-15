library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Multiplexor_4_32 is
    Port ( input0 : in  STD_LOGIC_VECTOR (31 downto 0);
           input1 : in  STD_LOGIC_VECTOR (31 downto 0);
           input2 : in  STD_LOGIC_VECTOR (31 downto 0);
           input3 : in  STD_LOGIC_VECTOR (31 downto 0);
           cond : in  STD_LOGIC_VECTOR (1 downto 0);
           output : out  STD_LOGIC_VECTOR (31 downto 0));
end Multiplexor_4_32;

architecture Behavioral of Multiplexor_4_32 is

begin
process (cond, input0, input1, input2, input3)
begin
	case (cond) is
		when "00" => output <= input0;
		when "01" => output <= input1;
		when "10" => output <= input2;
		when others  => output <= input3;
	end case;
end process;
end Behavioral;

