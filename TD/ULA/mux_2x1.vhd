library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is
port
(
 A: in std_logic;
 B: in std_logic;
 SEL: in BIT;
 s: out std_logic

);
	end mux2x1;
	architecture mux of mux2x1 is
	begin
	with sel select 
	s <= 
	a when '0',
	b when '1';
	end mux;
