library ieee;
use ieee.std_logic_1164.all;

entity FullSub is
port
(
	x: in std_logic;
	y: in std_logic;
	Bin: in std_logic;
	Bout: out std_logic;
	Dif: out std_logic
);
end FullSub;

architecture sub_full of FullSub is
begin

Dif <= x xor y xor Bin;
Bout <= (Bin and(not(x xor y))) or (not(x) and y);

end sub_full;
