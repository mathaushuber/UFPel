LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY somador IS
  PORT(
  a, b: in std_logic_vector(3 downto 0);
  s: buffer std_logic_vector(3 downto 0);
  c4: out std_logic;
  Flag_Zero : out STD_LOGIC;
  Flag_Sinal : out STD_LOGIC;
  Flag_Overflow : out STD_LOGIC
  );
end somador;

architecture hardware of somador is

SIGNAL c: std_logic_vector(2 downto 0);

COMPONENT meio_somador
  PORT (
  a, b: in std_logic;
  s, c_out: out std_logic
  );
END COMPONENT;

COMPONENT somador_completo
  PORT (
  a, b, c_in: in std_logic;
  s, c_out: out std_logic
  );
END COMPONENT;

signal prop: std_logic_vector(2 downto 0);
signal valor : std_logic_vector(3 downto 0);
signal c3 : std_logic;
signal c2 : std_logic;

begin 
  soma1: meio_somador
    port map(a => a(0), b => b(0), s => s(0), c_out => c(0));
    
  soma2: somador_completo
    port map(a => a(1), b => b(1), c_in => c(0), s => s(1), c_out => c(1));
    
  soma3: somador_completo
    port map(a => a(2), b => b(2), c_in => c(1), s => s(2), c_out => c(2));
    
  soma4: somador_completo
    port map(a => a(3), b => b(3), c_in => c(2), s => s(3), c_out => c4);
	 valor <= s;
	 c3 <= s(3);
	 c2 <= s(2);
	 Flag_Zero <= not(valor(0) or valor(1) or valor(2) or valor(3));
	 Flag_Sinal <= valor(3);
    Flag_Overflow <= c3 xor c2;
      
end hardware;
