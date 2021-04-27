library ieee;
use ieee.std_logic_1164.all;

entity a_not is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           saida : buffer  STD_LOGIC_VECTOR (3 downto 0);
			  Flag_Zero : out STD_LOGIC;
			  Flag_Sinal : out STD_LOGIC);
end a_not;

architecture Behavioral of a_not is
SIGNAL valor : STD_LOGIC_VECTOR(3 downto 0);
begin
	Gen_1: For I IN 3 downto 0 generate
			 saida(I) <= not x(I);
	end generate;
	valor <= saida;
	Flag_Zero <= not (valor(0) or valor(1) or valor(2) or valor(3));
	Flag_Sinal <= valor(3);

end Behavioral;
