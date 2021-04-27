library ieee;
use ieee.std_logic_1164.all;

entity a_and_b is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           y : in  STD_LOGIC_VECTOR (3 downto 0);
           saida : buffer  STD_LOGIC_VECTOR (3 downto 0);
			  Flag_Zero : out STD_LOGIC;
			  Flag_Sinal : out STD_LOGIC);
end a_and_b;

architecture Behavioral of a_and_b is
signal valor : std_logic_vector (3 downto 0);
begin
	Gen_1: For I IN 3 downto 0 generate
			 saida(I) <= x(I) and y(I);
	end generate;
	valor <= saida;
	Flag_Zero <= not(valor(0) or valor(1) or valor(2) or valor(3));
	Flag_Sinal <= valor(3);
end Behavioral;
