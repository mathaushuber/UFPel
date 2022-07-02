library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Moore is
port(
	entrada: in STD_LOGIC_VECTOR (2 downto 0);
	clock: in STD_LOGIC;
	saida: out STD_LOGIC
);
end entity;

architecture behaviour of Moore is

begin

mEstados0: work.MaquinaEstados
	port map(
	clk => clock,
	input => entrada(0),
	reset => entrada(1),
	output => saida
	);
end behaviour;