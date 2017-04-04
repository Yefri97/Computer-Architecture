library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ArithmeticLogicUnit is
    Port ( op1 : in  STD_LOGIC_VECTOR (31 downto 0);
           op2 : in  STD_LOGIC_VECTOR (31 downto 0);
           aluOp : in  STD_LOGIC_VECTOR (5 downto 0);
           result : out  STD_LOGIC_VECTOR (31 downto 0));
end ArithmeticLogicUnit;

architecture Behavioral of ArithmeticLogicUnit is

begin

process (aluOp, op1, op2)
begin
	case (aluOp) is
		when "000000" => result <= op1 + op2;
		when "000001" => result <= op1 - op2;
		when "000010" => result <= op1 or op2;
		when "000011" => result <= op1 and op2;
		when others => result <= op1;
	end case;
end process;

end Behavioral;