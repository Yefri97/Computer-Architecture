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
				when "000100" => aluOp <= "000001"; -- SUB
				when "000010" => aluOp <= "000010"; -- OR
				when "000001" => aluOp <= "000011"; -- AND
				when "111100" => aluOp <= "100000"; -- ADDcc
				when "111101" => aluOp <= "100001"; -- SUBcc
				when "111110" => aluOp <= "100010"; -- ORcc
				when "111011" => aluOp <= "100011"; -- ANDcc
				when others => aluOp <= "111111";
			end case;
		when others => aluOp <= "111111";
	end case;
end process;

end Behavioral;