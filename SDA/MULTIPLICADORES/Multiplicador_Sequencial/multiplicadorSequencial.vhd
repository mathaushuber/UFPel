library IEEE;
use ieee.std_logic_1164.all;

entity multiplicadorSequencial is
generic(TAMANHO: integer:= 4); 
	port(
	op1, op2: in std_logic_vector(TAMANHO-1 downto 0);
	clock, enable, reset: in std_logic;
	estado: out std_logic_vector(3 downto 0);
	resultado: out std_logic_vector(2*TAMANHO-1 downto 0)
	);
end entity;

architecture multiplicadorSequencialArch of multiplicadorSequencial is
component somadorNbits is 
generic(TAMANHO: integer:= 4);
	port (
		entrada1, entrada2: in std_logic_vector(TAMANHO-1 downto 0);
		resultadoSoma: out std_logic_vector(TAMANHO-1 downto 0);
		overflow: out std_logic
	);
end component;

component mux is 
	generic(TAMANHO: integer:= 4);
	port (
		entrada1, entrada0 : in std_logic_vector(TAMANHO-1 downto 0);
		control: in std_logic;
		saida: out std_logic_vector(TAMANHO -1 downto 0)  
	);
end component;

component registrador is
	generic (TAMANHO: integer :=8);
	port (
		d: in std_logic_vector (TAMANHO-1 downto 0);
		reset, clock, enable : in std_logic;
		q: out std_logic_vector (TAMANHO-1 downto 0)
	);
	
END component;

signal a, aSaida, b, bSaida, saidaDoMux, saidaULA: std_logic_vector(3 downto 0);
signal entradaRegitrador, saidaRegistrador : std_logic_vector(7 downto 0);
signal overflow, controlaMux: std_logic;

-- maquina de estados
signal atual, prox : std_logic_vector(3 downto 0);
constant s0 : std_logic_vector(3 downto 0) := "0000";
constant s1 : std_logic_vector(3 downto 0) := "0001";
constant s2 : std_logic_vector(3 downto 0) := "0010";
constant s3 : std_logic_vector(3 downto 0) := "0011";
constant s4 : std_logic_vector(3 downto 0) := "0100";

begin

MR: registrador port map(
		d(TAMANHO-1 downto 0) => a,
		reset => reset,
		clock => clock,
		enable => enable,
		q(TAMANHO-1 downto 0) => aSaida
	);
	
MD: registrador port map(
		d(TAMANHO-1 downto 0)  => b,
		reset => reset,
		clock => clock,
		enable => enable,
		q(TAMANHO-1 downto 0) => bSaida
	);
	
PR: registrador port map(
		d  => entradaRegitrador,
		reset => reset,
		clock => clock,
		enable => enable,
		q => saidaRegistrador
	);
	
	mux1: mux port map(
		entrada0 => "0000",
		entrada1 => bSaida,
		control=> controlaMux,
		saida=> saidaDoMux  
	);
					
		Somador: somadorNbits port map(
			entrada1 => saidaDoMux,
			entrada2 =>  saidaRegistrador(6 downto 3),
			resultadoSoma => saidaULA,
			overflow=> overflow
		);
	
	-- clock para mudanca de estado
	process(clock,reset)
	begin
		if reset = '1' then
			atual <= s0;
		elsif clock'event and clock = '1' then
		    atual <= prox;
		end if;
	end process;

	-- maquina de estados 
	process (enable, atual, prox)
	begin
		case atual is
			when s0 => 
				if enable = '1' then 
					a <= op1;
					b <= op2;
					prox <= s1;		
				end if;
			when s1 =>
				controlaMux<= aSaida(0);
				entradaRegitrador <= overflow & saidaULA & saidaRegistrador(3 downto 1);--deslocamento
				prox <= s2;
			when s2 =>
				controlaMux<=aSaida(1);
				entradaRegitrador <= overflow & saidaULA & saidaRegistrador(3 downto 1);--deslocamento
				prox <= s3;
			when s3 =>
				controlaMux<=aSaida(2);
				entradaRegitrador <= overflow & saidaULA & saidaRegistrador(3 downto 1);--deslocamento
				prox <= s4;
			when s4 =>
				controlaMux<=aSaida(3);
				entradaRegitrador <= overflow & saidaULA & saidaRegistrador(3 downto 1);--deslocamento
				prox <= s0;
			when others =>
				b <= bSaida;
		end case;
				resultado<= saidaRegistrador;
				estado <= atual;
	end process;
	
			

end multiplicadorSequencialArch;