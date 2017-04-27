library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity WindowsManager is
    Port ( rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           rd : in  STD_LOGIC_VECTOR (4 downto 0);
           op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           cwp : in  STD_LOGIC;
           nrs1 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrs2 : out  STD_LOGIC_VECTOR (5 downto 0);
           nrd : out  STD_LOGIC_VECTOR (5 downto 0);
           ncwp : out  STD_LOGIC);
end WindowsManager;

architecture Behavioral of WindowsManager is

begin
process(op, op3, cwp, rs1, rs2, rd)
begin

if (op = "10" and (op3 = "111100" or op3 = "111101")) then
	ncwp <= not(cwp);
else
	ncwp <= cwp;
end if;

if (cwp = '0') then
	nrs1 <= "0"&rs1;
	nrs2 <= "0"&rs2;
	nrd <= "0"&rd;
else
	if (rs1 >= "011000" and rs1 <= "011111") then
		nrs1 <= rs1 - "010000";
	elsif (rs1 >= "010000" and rs1 <= "010111") then
		nrs1 <= rs1 + "010000";
	elsif (rs1 >= "001000" and rs1 <= "001111") then
		nrs1 <= rs1 + "010000";
	else
		nrs1 <= "0"&rs1;
	end if;
  
	if (rs2 >= "011000" and rs2 <= "011111") then
		nrs2 <= rs2 - "010000";
	elsif (rs2 >= "010000" and rs2 <= "010111") then
		nrs2 <= rs2 + "010000";
	elsif (rs2 >= "001000" and rs2 <= "001111") then
		nrs2 <= rs2 + "010000";
	else
		nrs2 <= "0"&rs2;
	end if;
  
	if (rd >= "011000" and rd <= "011111") then
		nrd <= rd - "010000";
	elsif (rd >= "010000" and rd <= "010111") then
		nrd <= rd + "010000";
	elsif (rd >= "001000" and rd <= "001111") then
		nrd <= rd + "010000";
	else
		nrd <= "0"&rd;
	end if;
	
end if;

end process;
end Behavioral;

