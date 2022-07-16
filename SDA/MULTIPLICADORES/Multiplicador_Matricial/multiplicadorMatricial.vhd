library IEEE;
use ieee.std_logic_1164.all;

entity multiplicadorMatricial is
	generic(TAMANHO: integer:= 4);
	port(
	operacaoUm, operacaoDois: in std_logic_vector(TAMANHO-1 downto 0);
	resultado: out std_logic_vector(2*TAMANHO-1 downto 0)
	);
end entity;

architecture multiplicadorMatricialArch of multiplicadorMatricial is
component somadorNbits is 
	port (
		entrada1, entrada2: in std_logic_vector(TAMANHO-1 downto 0);
		resultadoSoma: out std_logic_vector(TAMANHO-1 downto 0);
		overflow: out std_logic
	);
end component;
signal a, b: std_logic_vector(TAMANHO-1 downto 0);
signal saida: std_logic_vector(2*TAMANHO-1 downto 0);
signal carries: std_logic_vector(TAMANHO-1 downto 0);
type matrizDeParciais is array (3 downto 0) of std_logic_vector(TAMANHO-1 downto 0);--Cria um tipo matriz para armazenar os produtos parciais com tamanho TAMANHO-1
signal produtosParciais : matrizDeParciais;	--Cria uma matriz para armazenar os produtos parciais
begin 
a <= operacaoUm;
b <= operacaoDois;
saida(0) <= a(0) and b(0);
carries(0) <= '0';

produtosParciais(0)(3 downto 1) <=  (a(0) and b(3)) & (a(0) and b(2)) & (a(0) and b(1));

multiplicador: 
	  for i in 0 to TAMANHO-2 generate
		componenteSomador: somadorNbits port map(
		entrada1 => carries(i) & produtosParciais(i)(3 downto 1),
		entrada2 => (a(i+1) and b(3)) & (a(i+1) and b(2)) & (a(i+1) and b(1)) & (a(i+1) and b(0)),
		resultadoSoma => produtosParciais(i+1),
		overflow => carries(i+1)
		);
		saida(i+1) <= produtosParciais(i+1)(0);
	end generate multiplicador;


saida(7 downto 4)<= carries(3) & produtosParciais(3)(3 downto 1);

resultado<= saida;
	
end multiplicadorMatricialArch;