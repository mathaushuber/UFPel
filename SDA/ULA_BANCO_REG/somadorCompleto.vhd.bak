library ieee;

use ieee.std_logic_1164.all;

entity somadorCompleto is 
	port(
		a : in std_logic;
		b : in std_logic;
		cIn : in std_logic;
		cOut : out std_logic;
		s : out std_logic
	);
end somadorCompleto;
	
architecture bhv_somadorCompleto of somadorCompleto is
begin
	s <= (a xor b) xor cIN;
	cOut <= (a and b) or (cIN and (a xor b)); 
end bhv_somadorCompleto;
