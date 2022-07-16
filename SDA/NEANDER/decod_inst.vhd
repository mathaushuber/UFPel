library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;


entity decod_inst is
	port (
		opcode : in STD_LOGIC_VECTOR (3 downto 0);
		operation : out STD_LOGIC_VECTOR (12 downto 0));
end decod_inst;

architecture Behavioral of decod_inst is

begin

	operation <= "0000000000001" when opcode = "0000" -- 0 nop
						else "0000000000010" when opcode = "0001" -- 1 sta 
						else "0000000000100" when opcode = "0010" -- 2 lda
						else "0000000001000" when opcode = "0011" -- 3 add
						else "0000000010000" when opcode = "0100" -- 4 or
						else "0000000100000" when opcode = "0101" -- 5 and
						else "0000001000000" when opcode = "0110" -- 6 not
						else "0000010000000" when opcode = "0111" -- 7 jmp
						else "0000100000000" when opcode = "1000" -- 8 jn
						else "0001000000000" when opcode = "1001" -- 9 jz
						else "0010000000000" when opcode = "1010" -- 10 sub
						else "0100000000000" when opcode = "1011" -- 11 mult
						else "1000000000000" when opcode = "1111" -- 12 hlt
						else "0000000000000";

end Behavioral;

