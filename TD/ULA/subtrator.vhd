alibrary ieee;
use ieee.std_logic_1164.all;

entity subtrator is
port
(
 x1: in std_logic_vector(3 downto 0);
 y1: in std_logic_vector(3 downto 0);
 S: buffer std_logic_vector(3 downto 0);
 cout: out std_logic;
 Flag_Zero : out STD_LOGIC;
 Flag_Overflow : out STD_LOGIC;
 Flag_Sinal : out STD_LOGIC
);
end subtrator;

architecture subtrator_completo of subtrator is
component FullSub is
 Port( x: in std_logic;
		 y: in std_logic;
		 bin: in std_logic;
		 bout: out std_logic;
		 dif: out std_logic
		);
end component;
Signal C: std_logic_vector (3 downto 1);
Signal cin: std_logic;
SIGNAL ynvertido: STD_LOGIC_VECTOR (3 downto 0);
SIGNAL resultado: std_logic_vector (3 downto 0);
SIGNAL Flag_Zero_subtrator: std_logic;
SIGNAL Flag_Sinal_subtrator: std_logic;
SIGNAL Flag_Overflow_subtrator: std_logic;
signal armazena_borrow : std_logic;
signal borrow : std_logic;

begin

FS0: FullSub port map (x => x1(0), y => y1(0), Bin => cin, Bout => C(1), Dif => S(0));
FS1: FullSub port map (x => x1(1), y => y1(1), Bin => C(1), Bout => C(2), Dif => S(1));
FS2: FullSub port map (x => x1(2), y => y1(2), Bin => C(2), Bout => C(3), Dif => S(2));
FS3: FullSub port map (x => x1(3), y => y1(3), Bin => C(3), Bout => cout, Dif => S(3));
	resultado <= s;
	Flag_Zero <= not(resultado(0) or resultado(1) or resultado(2) or resultado(3));
	Flag_Overflow <= Flag_Overflow_subtrator;
	armazena_borrow <= not borrow;
	Flag_Sinal <= resultado(3);
end subtrator_completo;
