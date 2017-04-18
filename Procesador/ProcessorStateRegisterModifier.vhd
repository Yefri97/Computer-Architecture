library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ProcessorStateRegisterModifier is
    Port ( msb1 : in  STD_LOGIC;
           msb2 : in  STD_LOGIC;
           result : in  STD_LOGIC_VECTOR (31 downto 0);
           aluOp : in  STD_LOGIC_VECTOR (5 downto 0);
           nzvc : out  STD_LOGIC_VECTOR (3 downto 0));
end ProcessorStateRegisterModifier;

architecture Behavioral of ProcessorStateRegisterModifier is

begin

process(aluOp, result, msb1, msb2) begin

	if (aluOp(5) = '1') then
		nzvc(3) <= result(31);
		if (result = "00000000000000000000000000000000") then
			nzvc(2) <= '1';
		else
			nzvc(2) <= '0';
		end if;
		if (aluOp(1) = '0') then
			nzvc(1) <= (msb1 and msb2 and not result(31)) or (not msb1 and not msb2 and result(31));
			nzvc(0) <= (msb1 and msb2) or (not result(31) and (msb1 or msb2));
		else
			nzvc(1) <= '0';
			nzvc(0) <= '0';
		end if;
	end if;

end process;

end Behavioral;
