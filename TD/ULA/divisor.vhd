library ieee;
use ieee.std_logic_1164.all;

entity divisor is
    Port ( a: in  STD_LOGIC_VECTOR (3 downto 0);
			  Operacao: in  BIT;
           s : out  STD_LOGIC_VECTOR (3 downto 0);
			  Flag_Zero : buffer STD_LOGIC;
			  Flag_Sinal : buffer STD_LOGIC;
			  Flag_Overflow : buffer STD_LOGIC
			  );
end divisor;

architecture Behavioral of divisor is
COMPONENT divi_por_2 is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
			  desloca : in BIT;
           s : out  STD_LOGIC_VECTOR (3 downto 0);
			  Flag_Zero : out STD_LOGIC;
			  Flag_Overflow: out STD_LOGIC;
			  Flag_Sinal : out STD_LOGIC
			  );
end COMPONENT divi_por_2;

COMPONENT divi_por_4 is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
			  desloca : in BIT;
           s : out  STD_LOGIC_VECTOR (3 downto 0);
			  Flag_Zero : out STD_LOGIC;
			  Flag_Overflow: out STD_LOGIC;
			  Flag_Sinal : out STD_LOGIC
			  );
end COMPONENT divi_por_4;
signal dsl: BIT;
signal divide_four, divide_two: std_LOGIC_VECTOR(3 downto 0);
signal flag_over_divi, flag_sin_divi, flag_zero_divi: std_LOGIC;
signal flag_over_divi2, flag_sin_divi2, flag_zero_divi2: std_LOGIC;
begin
T0: divi_por_2 port map(a, dsl, divide_two, flag_over_divi, flag_sin_divi, flag_zero_divi);
T1: divi_por_4 port map(a, dsl, divide_four,flag_over_divi2, flag_sin_divi2, flag_zero_divi2);
process(Operacao, divide_two, divide_four)
begin
	case Operacao is
	when '0' =>
	s <= divide_two;
	flag_Zero <= flag_zero_divi;
	flag_Sinal <= flag_sin_divi;
	flag_Overflow <= flag_over_divi;
	when '1' =>
	s <= divide_four;
	flag_Zero <= flag_zero_divi2;
	flag_Sinal <= flag_sin_divi2;
	flag_Overflow <= flag_over_divi2;
	end case;
	end process;
end Behavioral;
