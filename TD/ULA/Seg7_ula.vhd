LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Seg7_ula IS
  PORT(
  a, b: in std_logic_vector(3 downto 0);
  Operacao: in std_LOGIC_VECTOR(2 downto 0);
  saida_7seg: out std_logic_vector(6 downto 0);
  saida_7seg_two: out std_logic_vector(6 downto 0);
  escolhadm: in BIT;
  Flag_Zero : out STD_LOGIC;
  Flag_Sinal : out STD_LOGIC;
  Flag_Overflow : out STD_LOGIC
  );
end Seg7_ula;

architecture arq_Seg7_ula of Seg7_ula is
signal n: std_logic_vector(3 downto 0);

COMPONENT alu IS
  PORT(
			  A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           Operacao : in  STD_LOGIC_VECTOR (2 downto 0);
			  escolha_multiedivi: in BIT;
           Z : out  STD_LOGIC_VECTOR (3 downto 0);
			  saida_seg7: out std_logic_vector(6 downto 0);
			  saida_seg7_two: out std_logic_vector(6 downto 0);
			  Flag_Zero : out STD_LOGIC;
			  Flag_Sinal : out STD_LOGIC;
			  Flag_Overflow : out STD_LOGIC
	        );
END COMPONENT;

COMPONENT seg7 IS
  PORT(
  entrada: in std_logic_vector(3 downto 0);
  s: out std_logic_vector(6 downto 0)
  );
END COMPONENT;

COMPONENT seg7_two IS
  PORT(
  entrada: in std_logic_vector(3 downto 0);
  s2: out std_logic_vector(6 downto 0)
  );
END COMPONENT;


begin 

  ula: alu
    port map ( a => a, b => b, Operacao => Operacao, escolha_multiedivi=> escolhadm, Z => n, Flag_Zero => Flag_Zero, Flag_Sinal => Flag_Sinal, Flag_Overflow=> Flag_Overflow);
    
  segmento7: seg7
    port map (entrada => n, s => saida_7seg);
   segmento72: seg7_two
    port map (entrada => n, s2 => saida_7seg_two);
	 
end arq_Seg7_ula;
