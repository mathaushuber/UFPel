library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity counter is
	port (
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		enable : in STD_LOGIC;
		load : in STD_LOGIC;
		d : in STD_LOGIC_VECTOR (7 downto 0);
		s : out STD_LOGIC_VECTOR (7 downto 0)
	);
end counter;

architecture Behavioral of counter is

	signal temp : unsigned (7 downto 0);

begin

	process(clk, rst)
	begin
	
	if (rising_edge(clk)) then
		if (rst = '1') then
			temp <= "00000000";
		elsif (enable = '1') then
			temp <= temp + 1;
		elsif (load = '1') then
			temp <= unsigned(d);
		end if;
	end if;
	
	end process;

	s <= std_logic_vector(temp);
	
end Behavioral;