library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ArithmeticLogicUnit is
    Port ( op1 : in  STD_LOGIC_VECTOR (31 downto 0);
           op2 : in  STD_LOGIC_VECTOR (31 downto 0);
           aluOp : in  STD_LOGIC_VECTOR (5 downto 0);
			  C : in  STD_LOGIC;
           result : out  STD_LOGIC_VECTOR (31 downto 0));
end ArithmeticLogicUnit;

architecture Behavioral of ArithmeticLogicUnit is

begin

process (aluOp, op1, op2)
begin
	case (aluOp) is
		
		when "000000" => result <= op1 + op2; -- ADD
		when "010000" => result <= op1 + op2; -- ADDcc
		when "001000" => result <= op1 + op2 + C; -- ADDX
		when "011000" => result <= op1 + op2 + C; -- ADDXcc
		
		when "000100" => result<= op1 - op2; -- SUB
		when "010100" => result <= op1 - op2; -- SUBcc
		when "001100" => result <= op1 - op2 - C; -- SUBX
		when "011100" => result <= op1 - op2 - C; -- SUBXcc
		
		when "000001" => result <= op1 and op2; -- AND
		when "010001" => result <= op1 and op2; -- ANDcc
		when "000010" => result <= op1 or op2; -- OR
		when "010010" => result <= op1 or op2; -- ORcc
		
		when others => result <= op1;
	end case;
end process;

end Behavioral;