library ieee;
use ieee.std_logic_1164.all;

entity multi_por_4 is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
			  desloca : in BIT;
           s : out  STD_LOGIC_VECTOR (3 downto 0);
			  Flag_Zero : out STD_LOGIC;
			  Flag_Overflow: out STD_LOGIC;
			  Flag_Sinal : out STD_LOGIC
			  );
end multi_por_4;

architecture Behavioral of multi_por_4 is
	COMPONENT mux2x1 is
	port
		(
		A: in std_logic;
		B: in std_logic;
		SEL: in BIT;
		s: out std_logic
		);
end COMPONENT;

signal valor : std_logic_vector(3 downto 0);
begin
	valor <= a;

	s1: mux2x1	                         
		port map(A => A(0), B => '0', sel => desloca, s => s(0));  
	s2: mux2x1
		port map(A => A(1), B => '0', sel => desloca, s=> s(1)); 
	s3: mux2x1
		port map(A => A(2), B => A(0), sel => desloca, s=> s(2)); 
	s4: mux2x1
		port map(A => A(3), B => A(1), sel => desloca, s=> s(3));	
		
	Flag_Zero <= not(valor(0) or valor(1) or valor(2) or valor(3));  
	Flag_Sinal <= valor(3);                                          
	Flag_Overflow <= valor(2) xor valor(3); 
	end Behavioral;
