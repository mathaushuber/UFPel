library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_two is 
	port(
		c : in std_logic_vector(31 downto 0);
		d : in std_logic_vector(31 downto 0);
		func : in std_logic_vector(1 downto 0);
		o : out std_logic;
		cOut : out std_logic;
		zero : out std_logic;
		n : out std_logic;
		ulaOut : out std_logic_vector (31 downto 0)
	);
end ULA_two;

architecture bhv_ULA of ULA_two is

component Shifter IS
    PORT(
        A        : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        ALUOp    : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        SHAMT    : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
        ShifterR : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
end component;

	signal tempOut : std_logic_vector(31 downto 0);
	signal cIN : std_logic;
	signal op: STD_LOGIC_VECTOR(1 DOWNTO 0);
	signal sha: STD_LOGIC_VECTOR(4 DOWNTO 0);
	signal shift: STD_LOGIC_VECTOR(31 DOWNTO 0);
begin
	addSLL : Shifter port map(a => D, ALUOp => op, SHAMT => sha, ShifterR => shift);
	cIN <= '1' when func = "10" else '0';
	
	tempOut <=  d when func = "00" else
					not c when func = "01" else
					shift when func = "10" else
					c xor d when func = "11";
					
	
	zero <= '1' when tempOut = x"00" else '0';
	n <= tempOut(31);
	ulaOut <= tempOut;
end bhv_ULA;	