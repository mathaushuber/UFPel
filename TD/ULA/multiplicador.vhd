library ieee;
use ieee.std_logic_1164.all;

entity multiplicador is
    Port ( a: in  STD_LOGIC_VECTOR (3 downto 0);
			  Operacao: in  BIT;
           s : out  STD_LOGIC_VECTOR (3 downto 0);
			  Flag_Zero : buffer STD_LOGIC;
			  Flag_Sinal : buffer STD_LOGIC;
			  Flag_Overflow : buffer STD_LOGIC
			  );
end multiplicador;

architecture Behavioral of multiplicador is
COMPONENT multi_por_2 is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
			  desloca : in BIT;
           s : out  STD_LOGIC_VECTOR (3 downto 0);
			  Flag_Zero : out STD_LOGIC;
			  Flag_Overflow: out STD_LOGIC;
			  Flag_Sinal : out STD_LOGIC
			  );
end COMPONENT multi_por_2;

COMPONENT multi_por_4 is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
			  desloca : in BIT;
           s : out  STD_LOGIC_VECTOR (3 downto 0);
			  Flag_Zero : out STD_LOGIC;
			  Flag_Overflow: out STD_LOGIC;
			  Flag_Sinal : out STD_LOGIC
			  );
end COMPONENT multi_por_4;
signal dsl: BIT;
signal flag_over_mult1, flag_sin_mult1, flag_zero_mult1: std_LOGIC;
signal flag_over_mult2, flag_sin_mult2, flag_zero_mult2: std_LOGIC;
signal multiplica_two, multiplica_four: std_LOGIC_VECTOR(3 downto 0);
begin
T0: multi_por_2 port map(a, dsl, multiplica_two, flag_over_mult1, flag_sin_mult1, flag_zero_mult1);
T1: multi_por_4 port map(a, dsl, multiplica_four,flag_over_mult2, flag_sin_mult2, flag_zero_mult2);
process(Operacao, multiplica_two, multiplica_four)
begin
	case Operacao is
	when '0' =>
	s <= multiplica_two;
	flag_overflow <= flag_over_mult1;
	flag_Sinal <= flag_sin_mult1;
	flag_Zero <= flag_zero_mult1;
	when '1' =>
	s <= multiplica_four;
	flag_overflow <= flag_over_mult2;
	flag_Sinal <= flag_sin_mult2;
	flag_Zero <= flag_zero_mult2;
	end case;
	end process;
end Behavioral;
