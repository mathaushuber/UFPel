library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity neander is
	port (
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		currentDATA : out STD_LOGIC_VECTOR (7 downto 0);
		ac : out STD_LOGIC_VECTOR (7 downto 0)
	);
end neander;

architecture Behavioral of neander is

	component counter
		port (
			clk : in std_logic;
			rst : in std_logic;
			enable : in std_logic;
			load : in std_logic;
			d : in std_logic_vector(7 downto 0);
			s : out std_logic_vector(7 downto 0)
		);
	end component;

	component ctrl_unit
		port (
			clk : in std_logic;
			rst : in std_logic;
			inst : in std_logic_vector(12 downto 0);
			n : in std_logic;
			z : in std_logic;
			selREM : out std_logic;
			cgREM : out std_logic;
			selRDM : out std_logic;
			cgRDM : out std_logic;
			cgAC : out std_logic;
			cgRI : out std_logic;
			cgNZ : out std_logic;
			cgPC : out std_logic;
			incPC : out std_logic;
			selULA : out std_logic_vector(2 downto 0);
			wea : out std_logic_vector(0 downto 0)
		);
	end component;

	component decod_inst
		port (
			opcode : in std_logic_vector(3 downto 0);
			operation : out std_logic_vector(12 downto 0)
		);
	end component;

	component mux2x1
		port (
			e0 : in std_logic_vector(7 downto 0);
			e1 : in std_logic_vector(7 downto 0);
			sel : in std_logic;
			s : out std_logic_vector(7 downto 0)
		);
	end component;

	component reg
		generic ( size : integer );
		port (
			clk : in std_logic;
			rst : in std_logic;
			d : in std_logic_vector((size-1) downto 0);
			load : in std_logic;
			s : out std_logic_vector((size-1) downto 0)
		);
	end component;

	component ula
		port (
			x : in std_logic_vector(7 downto 0);
			y : in std_logic_vector(7 downto 0);
			opsel : in std_logic_vector(2 downto 0);
			s : out std_logic_vector(7 downto 0);
			n : out std_logic;
			z : out std_logic
		);
	end component;

	component memory
		port (
			clka : in STD_LOGIC;
			wea : in STD_LOGIC_VECTOR(0 downto 0);
			addra : in STD_LOGIC_VECTOR(7 downto 0);
			dina : in STD_LOGIC_VECTOR(7 downto 0);
			douta : out STD_LOGIC_VECTOR(7 downto 0)
		);
	end component;

	signal outMEM, outMUXREM, outREM, outMUXRDM, outRDM, outAC, outRI, outPC, outULA : std_logic_vector (7 downto 0);
	signal nAux, zAux, n, z : std_logic;
	signal operation : std_logic_vector (12 downto 0);
	signal selREM, cgREM, selRDM, cgRDM, cgAC, cgRI, cgNZ, cgPC, incPC : std_logic;
	signal selULA : std_logic_vector (2 downto 0);
	signal wea : std_logic_vector (0 downto 0);
	type inst is (nop, sta, lda, add, or_inst, and_inst, not_inst, jmp, jn, jz, sub, mult, hlt); -- dummy variable used for simulation purposes
	signal currentInstruction : inst;

begin
	PC : counter
	port map(
		clk => clk, 
		rst => rst, 
		enable => incPC, 
		load => cgPC, 
		d => outREM, 
		s => outPC
	);

	CTRL : ctrl_unit
	port map(
		clk => clk, 
		rst => rst, 
		inst => operation, 
		n => n, 
		z => z, 
		selREM => selREM, 
		cgREM => cgREM, 
		selRDM => selRDM,
		cgRDM => cgRDM, 
		cgAC => cgAC, 
		cgRI => cgRI, 
		cgNZ => cgNZ, 
		cgPC => cgPC, 
		incPC => incPC, 
		selULA => selULA, 
		wea => wea
	);

	DECOD : decod_inst
	port map(
		opcode => outRI(7 downto 4), 
		operation => operation
	);

	MUXREM : mux2x1
	port map(
		e0 => outPC, 
		e1 => outRDM, 
		s => outMUXREM, 
		sel => selREM
	);
	
	MUXRDM : mux2x1
	port map(
		e0 => outMEM, 
		e1 => outAC, 
		s => outMUXRDM, 
		sel => selRDM
	);

	NZ : reg
	generic map (
		size => 2
	)
	port map(
		clk => clk, 
		rst => rst, 
		d(0) => nAux, 
		d(1) => zAux, 
		load => cgNZ, 
		s(0) => n, 
		s(1) => z
	);

	RI : reg
	generic map (
		size => 8
	)
	port map(
		clk => clk, 
		rst => rst, 
		d => outRDM, 
		load => cgRI, 
		s => outRI
	);

	AC_inst : reg
	generic map (
		size => 8
	)
	port map(
		clk => clk, 
		rst => rst, 
		d => outULA, 
		load => cgAC, 
		s => outAC
	);

	REM_inst : reg
	generic map (
		size => 8
	)
	port map(
		clk => clk, 
		rst => rst, 
		d => outMUXREM, 
		load => cgREM, 
		s => outREM
	);

	RDM : reg
	generic map (
		size => 8
	)
	port map(
		clk => clk, 
		rst => rst, 
		d => outMUXRDM, 
		load => cgRDM, 
		s => outRDM
	);

	ULA_inst : ula
	port map(
		x => outAC, 
		y => outRDM, 
		opsel => selULA, 
		s => outULA, 
		n => nAux, 
		z => zAux
	);

	memory_inst : memory
	port map(
		clka => clk, 
		wea => wea, 
		addra => outREM, 
		dina => outRDM, 
		douta => outMEM
	);
 
	currentDATA <= outMEM;
	ac <= outAC;
	
	currentInstruction <= nop when operation(0)='1' else
								 sta when operation(1)='1' else
								 lda when operation(2)='1' else
								 add when operation(3)='1' else
								 or_inst when operation(4)='1' else
								 and_inst when operation(5)='1' else
								 not_inst when operation(6)='1' else
								 jmp when operation(7)='1' else
								 jn when operation(8)='1' else
								 jz when operation(9)='1' else
								 sub when operation(10)='1' else
								 mult when operation(11)='1' else
								 hlt when operation(12)='1' else nop;

end Behavioral;