
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity reg is
	generic ( size : integer );
	port (
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		d : in STD_LOGIC_VECTOR ((size-1) downto 0);
		load : in STD_LOGIC;
		s : out STD_LOGIC_VECTOR ((size-1) downto 0));
end reg;

architecture Behavioral of reg is

begin

	process(clk, rst)
	begin
		if (rising_edge(clk)) then
			if (rst = '1') then
				s <= std_logic_vector(to_unsigned(0, size));
			elsif (load = '1') then
				s <= d;
			end if;
		end if;
	end process;

end Behavioral;