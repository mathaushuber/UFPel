LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY segmento7 IS
  PORT(
  saida_7seg: out std_logic_vector(6 downto 0);
  saida_7seg_two: out std_logic_vector(6 downto 0);
  hold: in std_logic;
  load: in std_logic;
  partida, valor: in std_logic_vector(5 downto 0);
  sentido_contagem: in std_logic;
  clear: in std_logic;
  clock: in std_logic;
  LED_cont: out std_logic;
  LED_hold: out std_logic
  );
end segmento7;

architecture comportamental of segmento7 is
signal ponte: std_logic_vector(5 downto 0);


COMPONENT contador is
	port(
		clock: in std_logic;
		clear: in std_logic;
		hold : in std_logic;
		load : in std_logic;
		sentido: in std_logic;
      partida: in std_logic_vector(5 downto 0);
		valor: in std_logic_vector(5 downto 0);
		saida: out std_logic_vector(5 downto 0);
		LED_hold: out std_logic;
		LED_cont: out std_logic
	);
end COMPONENT;

COMPONENT seg71 IS
  PORT(
  entrada: in std_logic_vector(5 downto 0);
  s: out std_logic_vector(6 downto 0)
  );
END COMPONENT;

COMPONENT seg72 IS
  PORT(
  entrada: in std_logic_vector(5 downto 0);
  s2: out std_logic_vector(6 downto 0)
  );
END COMPONENT;


begin 
   contsaida: contador
	port map(saida => ponte, clock => clock, clear => clear, hold => hold, load => load, sentido => sentido_contagem, partida => partida, valor => valor, LED_hold => LED_hold, LED_cont => LED_cont);
   segmento7: seg71
    port map (entrada => ponte, s => saida_7seg);
   segmento72: seg72
    port map (entrada => ponte, s2 => saida_7seg_two);
	 
end comportamental;