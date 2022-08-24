library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity mux2x1 is
	port (
		e0 : in STD_LOGIC_VECTOR (7 downto 0);
		e1 : in STD_LOGIC_VECTOR (7 downto 0);
		s : out STD_LOGIC_VECTOR (7 downto 0);
		sel : in STD_LOGIC);
end mux2x1;

architecture Behavioral of mux2x1 is

begin

	s <= e0 when sel='0' else
				e1;

end Behavioral;