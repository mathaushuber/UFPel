library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is 
	port(
		a : in std_logic_vector(31 downto 0);
		b : in std_logic_vector(31 downto 0);
		func : in std_logic_vector(1 downto 0);
		o : out std_logic;
		cOut : out std_logic;
		zero : out std_logic;
		n : out std_logic;
		ulaOut : out std_logic_vector (31 downto 0)
	);
end ULA;

architecture bhv_ULA of ULA is
 
component sum32 is 
	port(
		a : in std_logic_vector(31 downto 0);
		b : in std_logic_vector(31 downto 0);
		cIN : in std_logic;
		cOUT : out std_logic;
		o : out std_logic;
		s : out std_logic_vector(31 downto 0)
	);
end component;
	signal sum : std_logic_vector(31 downto 0);
	signal tempOut : std_logic_vector(31 downto 0);
	signal cIN : std_logic;
begin
	addSub : sum32 port map(a => a, b => b, cIN => cIN, cOUT => cOuT, s => sum);
	cIN <= '1' when func = "10" else '0';
	
	tempOut <=  a when func = "00" else
					a or b when func = "01" else
					sum when func = "10" else
					(a and b) or (not b) 	when func = "11";
					
	
	zero <= '1' when tempOut = x"00" else '0';
	n <= tempOut(31);
	ulaOut <= tempOut;
end bhv_ULA;		
