library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity ula is
	port (
		x : in STD_LOGIC_VECTOR (7 downto 0);
		y : in STD_LOGIC_VECTOR (7 downto 0);
		opsel : in STD_LOGIC_VECTOR (2 downto 0);
		s : out STD_LOGIC_VECTOR (7 downto 0);
		n : out std_logic;
		z : out std_logic);
end ula;

architecture Behavioral of ula is

	signal sum, sub: signed (7 downto 0);
	signal mult : signed(15 downto 0);
	signal temp: std_logic_vector(7 downto 0);

begin

	sum <= signed(x) + signed(y);
	mult <= signed(x) * signed(y);
	sub <= signed(x) - signed(y);

	temp <=  std_logic_vector(sum) when opsel="000" else
				x and y when opsel="001" else
				x or y when opsel="010" else
				not x when opsel="011" else
				y when opsel="100" else
				std_logic_vector(sub) when opsel="101" else
				std_logic_vector(mult(7 downto 0)) when opsel="110"
				else "00000000";

	n <= '1' when temp(7) = '1'
				else '0';

	z <= '1' when temp = "00000000"
				else '0';

	s <= temp;
end Behavioral;
