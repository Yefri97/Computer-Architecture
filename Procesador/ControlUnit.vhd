library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ControlUnit is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
			  icc : in  STD_LOGIC_VECTOR (3 downto 0);
			  cond : in  STD_LOGIC_VECTOR (3 downto 0);
			  WREN : out  STD_LOGIC;
			  WRENMEM : out  STD_LOGIC;
			  RFDEST : out  STD_LOGIC;
			  RFSRC : out  STD_LOGIC_VECTOR (1 downto 0);
			  PCSRC : out  STD_LOGIC_VECTOR (1 downto 0);
           aluOp : out  STD_LOGIC_VECTOR (5 downto 0));
end ControlUnit;

architecture Behavioral of ControlUnit is

signal N, Z, V, C : std_logic;

begin

process (op, op3)
begin
	case (op) is
		when "00" => -- BRANCH
			WREN <= '1';
			WRENMEM <= '0';
			RFDEST <= '0';
			RFSRC <= "01";
			PCSRC <= "10";
			aluOp <= "000000";
			N <= icc(3); Z <= icc(2); V <= icc(1); C <= icc(0);
			if ((cond = "1000") or																		-- BA
				 (cond = "1001" and Z = '0') or 														-- BNE
				 (cond = "0001" and Z = '1') or 														-- BE
				 (cond = "1010" and (Z = '0' and N = '0')) or 									-- BG
				 (cond = "0010" and (Z = '1' or N = '1')) or 									-- BLE
				 (cond = "1011" and N = '0') or 														-- BGE
				 (cond = "0011" and N = '1') 															-- BL
			) then
				PCSRC <= "01";
			end if;
		when "01" => -- CALL
			WREN <= '1';
			WRENMEM <= '0';
			RFDEST <= '1';
			RFSRC <= "10";
			PCSRC <= "00";
			aluOp <= "000000";
		when "10" =>
			WREN <= '1';
			WRENMEM <= '0';
			RFDEST <= '0';
			RFSRC <= "01";
			PCSRC <= "10";
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
				
				when "111000" => -- JMPL
					PCSRC <= "11";
					aluOp <= "000000";
				
				when others => aluOp <= "111111";
			end case;
			
		when "11" =>
			case (op3) is
				when "000000" => -- LOAD
					WREN <= '1';
					WRENMEM <= '0';
				when "000100" => -- STORE
					WREN <= '0';
					WRENMEM <= '1';
				when others => aluOp <= "111111";
			end case;
			RFDEST <= '0';
			RFSRC <= "00";
			PCSRC <= "10";
			aluOp <= "000000";
		when others => aluOp <= "111111";
	end case;
end process;

end Behavioral;