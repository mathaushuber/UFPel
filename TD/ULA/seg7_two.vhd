LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY seg7_two IS
  PORT(
  entrada: in std_logic_vector(3 downto 0);
  s2: out std_logic_vector(6 downto 0)
  );
end seg7_two;

architecture hardware of seg7_two is
begin 
  with entrada select
  s2 <= "1000000" when "0000",
		  "1000000" when "0001",
		  "1000000" when "0010",
		  "1000000" when "0011",
		  "1000000" when "0100",
		  "1000000" when "0101",
		  "1000000" when "0110",
		  "1000000" when "0111",
		  "1000000" when "1000",
		  "1000000" when "1001",
		  "1111001" when "1010",
		  "1111001" when "1011",
		  "1111001" when "1100",
		  "1111001" when "1101",
		  "1111001" when "1110",
		  "1111001" when "1111",
		  "0111111" when others;
end hardware;
