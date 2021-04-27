library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           Operacao : in  STD_LOGIC_VECTOR (2 downto 0);
			  escolha_multiedivi: in BIT;
			  Z: out std_LOGIC_VECTOR(3 downto 0);
			  saida_seg7: out std_logic_vector(6 downto 0);
			  saida_seg7_two: out std_logic_vector(6 downto 0);
			  Flag_Zero : out STD_LOGIC;
	        Flag_Sinal : out STD_LOGIC;
	        Flag_Overflow : out STD_LOGIC
	        );
end alu;

architecture Behavioral of alu is

COMPONENT somador
    Port (  a, b: in std_logic_vector(3 downto 0);
				s: out std_logic_vector(3 downto 0);
				c4: out std_logic;
				Flag_Zero : out STD_LOGIC;
				Flag_Sinal : out STD_LOGIC;
				Flag_Overflow : out STD_LOGIC);
end COMPONENT somador;
    
COMPONENT a_not is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           saida : out  STD_LOGIC_VECTOR (3 downto 0);
			  Flag_Zero : out STD_LOGIC;
			  Flag_Sinal : out STD_LOGIC);
end COMPONENT a_not;

COMPONENT b_not is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           saida : out  STD_LOGIC_VECTOR (3 downto 0);
			  Flag_Zero : out STD_LOGIC;
			  Flag_Sinal : out STD_LOGIC);
end COMPONENT b_not;
    
COMPONENT subtrator is
    Port ( x1 : in  STD_LOGIC_VECTOR (3 downto 0);
           y1 : in  STD_LOGIC_VECTOR (3 downto 0);
			  S : out  STD_LOGIC_VECTOR (3 downto 0);
           cout : out  STD_LOGIC;
			  Flag_Zero : out STD_LOGIC;
			  Flag_Sinal : out STD_LOGIC;
			  Flag_Overflow : out STD_LOGIC);
end COMPONENT subtrator;

COMPONENT a_or_b is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           y : in  STD_LOGIC_VECTOR (3 downto 0);
           saida : out  STD_LOGIC_VECTOR (3 downto 0);
			  Flag_Zero : out STD_LOGIC;
			 Flag_Sinal : out STD_LOGIC);
end COMPONENT a_or_b;    

COMPONENT multiplicador is
    Port ( a: in  STD_LOGIC_VECTOR (3 downto 0);
			  Operacao: in  BIT;
           s : out  STD_LOGIC_VECTOR (3 downto 0);
			  Flag_Zero : out STD_LOGIC;
			  Flag_Sinal : out STD_LOGIC;
			  Flag_Overflow : out STD_LOGIC
			  );
end COMPONENT multiplicador;
	
COMPONENT a_and_b is
    Port ( x : in  STD_LOGIC_VECTOR (3 downto 0);
           y : in  STD_LOGIC_VECTOR (3 downto 0);
           saida : out  STD_LOGIC_VECTOR (3 downto 0);
			  Flag_Zero : out STD_LOGIC;
			  Flag_Sinal : out STD_LOGIC);
end COMPONENT a_and_b;

COMPONENT divisor is
           Port (a: in  STD_LOGIC_VECTOR (3 downto 0);
			  Operacao: in  BIT;
           s : out  STD_LOGIC_VECTOR (3 downto 0);
			  Flag_Zero : out STD_LOGIC;
			  Flag_Sinal : out STD_LOGIC;
			  Flag_Overflow : out STD_LOGIC
			  );
end COMPONENT divisor;

signal Not_A, Not_b, A_mais_B, a_menos_B,  A_vezes, AandB, A_divi, AorB, segmt7 : STD_LOGIC_VECTOR (3 downto 0);
signal cout_somador, bout_subtrator: std_LOGIC;
signal Flag_Zero_somador, Flag_Sinal_somador, Flag_Overflow_somador: STD_LOGIC;
signal Flag_Zero_inversora, Flag_Sinal_inversora, Flag_Zero_inversorb, Flag_Sinal_inversorb: STD_LOGIC; 
signal Flag_Zero_subtrator, Flag_Sinal_subtrator, Flag_Overflow_subtrator, Flag_Borrow_subtrator: STD_LOGIC;
signal Flag_Zero_divisor, Flag_Sinal_divisor, Flag_overflow_divisor, Flag_Zero_multiplicador, Flag_Sinal_multiplicador, Flag_overflow_multiplicador: STD_LOGIC; 
signal Flag_Zero_or, Flag_Sinal_or, Flag_Zero_and, Flag_Sinal_and : STD_LOGIC;
begin

	-- Declarando os componentes
	U0: somador port map (A, B, A_mais_B, Flag_Zero_somador, Flag_Sinal_somador, Flag_Overflow_somador); -- Para operação 0
	U1: subtrator port map (A, B, A_menos_B, Flag_Sinal_subtrator, Flag_Overflow_subtrator, Flag_Borrow_subtrator);-- Para operação 1
	U2: a_not port map (A, Not_A, Flag_Zero_inversora, Flag_Sinal_inversora);-- Para operação 2
	U3: b_not port map (B, Not_B, Flag_Zero_inversorb, Flag_Sinal_inversorb);-- Para operação 3
	U4: A_or_B port map (A, B, AorB, Flag_Zero_or, Flag_Sinal_or); -- Para operação 4
	U5: a_and_b port map (A, B, AandB, Flag_Zero_and, Flag_Sinal_and); -- Para operação 5
	U6: divisor port map (a, escolha_multiedivi, A_divi, Flag_Zero_divisor, Flag_Sinal_divisor, Flag_overflow_divisor);-- Para operação 6
	U7: multiplicador port map (a, escolha_multiedivi, A_vezes, Flag_Zero_multiplicador, Flag_Sinal_multiplicador, Flag_overflow_multiplicador);-- Para operação 7
	
	process (Operacao, Not_A, Not_b, A_mais_B, A_vezes, A_menos_B, AandB, A_divi, AorB)
	begin
		case Operacao is
			when "000" =>
			   Z <= A_mais_B;
				Flag_Zero <= Flag_Zero_somador;
	   		Flag_Sinal <= Flag_Sinal_somador;
	   		Flag_Overflow <= Flag_Overflow_somador;
			when "001" =>
				Z <= A_menos_B;
				Flag_Zero <= Flag_Zero_subtrator;
	   		Flag_Sinal <= Flag_Sinal_subtrator;
	   		Flag_Overflow <= Flag_Borrow_subtrator;
			when "010" =>
			   Z <= Not_A;
				Flag_Zero <= Flag_Zero_inversora;
	   		Flag_Sinal <= Flag_Sinal_inversora;
	   		Flag_Overflow <= '0';
			when "011" =>
			   Z <= Not_B;
				Flag_Zero <= Flag_Zero_inversorb;
	   		Flag_Sinal <= Flag_Sinal_inversorb;
	   		Flag_Overflow <= '0';
			when "100" =>
				Z <= AorB;
				Flag_Zero <= Flag_Zero_or;
	   		Flag_Sinal <= Flag_Sinal_or;
	   		Flag_Overflow <= '0';
			when "101" =>
				Z <= AandB;
				Flag_Zero <= Flag_Zero_and;
	   		Flag_Sinal <= Flag_Sinal_and;
	   		Flag_Overflow <= '0';
			when "110" =>
				Z <= A_divi;
				Flag_Zero <= Flag_Zero_divisor;
	   		Flag_Sinal <= Flag_Sinal_divisor;
	   		Flag_Overflow <= Flag_Overflow_divisor;
			when "111" =>
				Z <= A_vezes;
				Flag_Zero <= Flag_Zero_somador;
	   		Flag_Sinal <= Flag_Sinal_multiplicador;
	   		Flag_Overflow <= Flag_Overflow_multiplicador;
		end case;
	end process;

end Behavioral;
