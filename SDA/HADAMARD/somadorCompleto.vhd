library IEEE;
use ieee.std_logic_1164.all;

entity somadorCompleto is 
	port (
		a, b, cin : in std_logic;
		cout, saida: out std_logic  
	);
end somadorCompleto;


architecture somadorCompletoArch of somadorCompleto is
begin 
	cout <= (a and b) or (a and cin) or (b and cin);
	saida <= a xor b xor cin;
end somadorCompletoArch;