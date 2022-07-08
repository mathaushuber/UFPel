LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;

ENTITY UlaControl_TB IS
END UlaControl_TB; 

ARCHITECTURE behavior OF UlaControl_TB IS 


component UlaControl is 
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
end component;

	--Input
	signal inputSignal :  std_logic_vector(95 downto 0) := (others=>'0');
	--Outputs
	signal clk, n, zero , o, cOut, c0, z: std_logic;
	signal ulaOutDebug : std_logic_vector(31 downto 0);
	signal UOD_two : std_logic_vector(31 downto 0);
	
	file fileEntrada,fileSaida: text;

  function str_to_stdvec(inp: string) return std_logic_vector is
	variable temp: std_logic_vector(inp'range);
	begin
		for i in inp'range loop
			if (inp(i) = '1') then
				temp(i) := '1';
			elsif (inp(i) = '0') then
				temp(i) := '0';
			end if;
		end loop;
		return temp;
	end function str_to_stdvec;

	function stdvec_to_str(inp: std_logic_vector) return string is
		variable temp: string(inp'left+1 downto 1);
	begin
		for i in inp'reverse_range loop
			if (inp(i) = '1') then
				temp(i+1) := '1';
			elsif (inp(i) = '0') then
				temp(i+1) := '0';
			end if;
		end loop;
		return temp;
	end function stdvec_to_str;


BEGIN
	
	-- Instantiate the Unit Under Test (UUT)
	regUla: UlaControl PORT MAP(
		inst => inputSignal(95 downto 64),
		valorLoad => inputSignal(63 downto 32),
		clk => clk,
		clear =>inputSignal(31 downto 0),
		o => o,
		cOut => cOut,
		c0ut => c0,
		z => z,
		zero => zero,
		n => n,
		ulaOutDebug => ulaOutDebug,
		ulaOutDebug_two => UOD_two
	);

	
	Clock :PROCESS 
	BEGIN
  		clk <= '1', '0' AFTER 5 ns;
  		WAIT FOR 10 ns;
	END PROCESS;

	
	tb : PROCESS
	variable inline: line;
	--
	variable out0: std_logic_vector(35 downto 0);
	variable out1: std_logic_vector(35 downto 0);
	variable str_out0: string(36 downto 1);
	variable str_out1: string(36 downto 1);
	variable outline: line;
	--variable outline2: line;	
		--
	variable sample: string(96 downto 1);
	BEGIN

  FILE_OPEN(fileEntrada, "arquivo_entrada.txt", READ_MODE);
	FILE_OPEN(fileSaida, "arquivo_saida.txt", WRITE_MODE); 		
		
		while not endfile(fileEntrada) loop
			readline(fileEntrada, inline);
			read(inline, sample);
			inputSignal <= str_to_stdvec(sample);
			
			wait for 100 ns;

			--1
			out0 := ulaOutDebug&n&zero&cout&o;
			out1 := UOD_two&n&zero&c0&o;
			str_out0 := stdvec_to_str(out0);
			str_out1 := stdvec_to_str(out1);
			write(outline, str_out0);
			writeline(fileSaida, outline);
			write(outline, str_out1);
			writeline(fileSaida, outline);
      
     -- wait for 20 ns;
		--	out1:= n&zero&cout&o; 
			
		--	str_out1 := stdvec_to_str(out1);
		--	write(outline, str_out1);
		--	writeline(fileSaida, outline);


		END LOOP;

		file_close(fileEntrada);
		file_close(fileSaida);

		wait; -- will wait forever
	END PROCESS;

END;