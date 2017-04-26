library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ControlUnit is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           aluOp : out  STD_LOGIC_VECTOR (5 downto 0));
end ControlUnit;

architecture Behavioral of ControlUnit is

begin

process (op, op3)
begin
	case (op) is
		when "10" =>
			case (op3) is
				when "000000" => aluOp <= "000000"; -- ADD
				when "010000" => aluOp <= "010000"; -- ADDcc
				when "001000" => aluOp <= "001000"; -- ADDX
				when "011000" => aluOp <= "011000"; -- ADDXcc
				
				when "000100" => aluOp <= "000100"; -- SUB
				when "010100" => aluOp <= "010100"; -- SUBcc
				when "001100" => aluOp <= "001100"; -- SUBX
				when "011100" => aluOp <= "011100"; -- SUBXcc
				
				when "000001" => aluOp <= "000001"; -- AND
				when "010001" => aluOp <= "010001"; -- ANDcc
				when "000010" => aluOp <= "000010"; -- OR
				when "010010" => aluOp <= "010010"; -- ORcc
				
				when "111100" => aluOp <= "000000"; -- SAVE
				when "111101" => aluOp <= "000000"; -- RESTORE
				
				when others => aluOp <= "111111";
			end case;
		when others => aluOp <= "111111";
	end case;
end process;

end Behavioral;