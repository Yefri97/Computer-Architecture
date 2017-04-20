library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ProcessorStateRegister is
    Port ( NZVC : in  STD_LOGIC_VECTOR (3 downto 0);
           nCWP : in  STD_LOGIC;
           C : out  STD_LOGIC;
           CWP : out  STD_LOGIC);
end ProcessorStateRegister;

architecture Behavioral of ProcessorStateRegister is

signal psr : std_logic_vector (31 downto 0);

begin

psr(23 downto 20) <= NZVC;

end Behavioral;

