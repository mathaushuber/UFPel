library ieee;

use ieee.std_logic_1164.all;

entity UlaControl is 
	port (
		inst : in std_logic_vector (31 downto 0);
		valorLoad : in std_logic_vector (31 downto 0);
		clk : in std_logic;
		clear : in std_logic_vector (31 downto 0);
		o : out std_logic;
		z: out std_logic;
		cOut : out std_logic;
		c0ut: out std_logic;
		zero : out std_logic;
		zer0: out std_logic;
		nt: out std_logic;
		n : out std_logic;
		ulaOutDebug : out std_logic_vector (31 downto 0);
		ulaOutDebug_two: out std_logic_vector (31 downto 0)
	);
end UlaControl;
	
architecture bhv_regUla of UlaControl is
	signal reg1, reg2, reg3, reg4 : std_logic_vector (31 downto 0);
	signal tempUlaOut : std_logic_vector (31 downto 0);
	signal tempUlaOut_two : std_logic_vector (31 downto 0);
	signal regBankInput : std_logic_vector (31 downto 0);
	signal regbi : std_logic_vector (31 downto 0);
	signal tempLoad : std_logic_vector (31 downto 0);
	signal tl : std_logic_vector (31 downto 0);
	component ULA is 
		port(
			a : in std_logic_vector(31 downto 0);
			b : in std_logic_vector(31 downto 0);
			func : in std_logic_vector(1 downto 0);
			o : out std_logic;
			cOut : out std_logic;
			zero : out std_logic;
			n : out std_logic;
			ulaOut : out std_logic_vector (31 downto 0)
		);
	end component;
	component ULA_two is 
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
end component;
	component bancoReg is 
		port( inst : in std_logic_vector (31 downto 0); -- Codigo com a instrução pode ser operação na ula ou um load
				valorLoad : in std_logic_vector (31 downto 0); -- valor para carregar em um registrador
				clk : in std_logic; -- clock
				clear : in std_logic_vector (31 downto 0);
				reg1, reg2 : out std_logic_vector (31 downto 0) -- saida dos valores de dois registradores
		);
	end component;
	component bancoReg_two is 
	port( inst : in std_logic_vector (31 downto 0); -- Codigo com a instrução pode ser operação na ula ou um load
			valorLoad : in std_logic_vector (31 downto 0); -- valor para carregar em um registrador
			clk : in std_logic; -- clock
			clear : in std_logic_vector (31 downto 0);
			reg3, reg4 : out std_logic_vector (31 downto 0) -- saida dos valores de dois registradores
	);
end component;
begin
	regB: bancoReg port map(inst => regBankInput, valorLoad => tempLoad, clk => clk, clear => clear, reg1 => reg1, reg2 => reg2);
	regC: bancoReg_two port map(inst => regBankInput, valorLoad => tempLoad, clk => clk, clear => clear, reg3 => reg3, reg4 => reg4);
	ulaC: ULA port map(a => reg1, b=> reg2, func => inst(1 downto 0), o => o, cOut => cOut, zero => zero, n => n, ulaOut => tempUlaOut);
	ulaB: ULA_two port map(c => reg3, d=> reg4, func => inst(1 downto 0), o => z, cOut => c0ut, zero => zer0, n => nt, ulaOut => tempUlaOut_two);
	ulaOutDebug <= tempUlaOut;
	ulaOutDebug_two <= tempUlaOut_two;
	tempLoad <= valorLoad when inst(31 downto 26) = "100011" else
					tempUlaOut;	
	regBankInput <= inst;
	tl <= valorLoad when inst(31 downto 26) = "100011" else
					tempUlaOut_two;
	regbi <= inst;
end bhv_regUla;