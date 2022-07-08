library ieee;

use ieee.std_logic_1164.all;

entity registrador32_two is 
	port(
		dados :	in std_logic_vector(31 downto 0);
		load	:	in std_logic;
		clear	:	in std_logic;
		clock	:	in std_logic;
		saida :	out std_logic_vector(31 downto 0)
	);
end registrador32_two;

architecture bhv_reg32_two of registrador32_two is
begin
		process (clock, clear)
			begin
				if clear = '1' then
					saida <= x"00000000";
				elsif rising_edge(clock)then
					if load = '1' then 
						saida <= dados;
					end if;
				end if;
		end process;
end bhv_reg32_two;