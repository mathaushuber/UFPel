library ieee;

use ieee.std_logic_1164.all;

entity bancoReg_two is 
	port( inst : in std_logic_vector (31 downto 0); -- Codigo com a instrução pode ser operação na ula ou um load
			valorLoad : in std_logic_vector (31 downto 0); -- valor para carregar em um registrador
			clk : in std_logic; -- clock
			clear : in std_logic_vector (31 downto 0);
			reg3, reg4 : out std_logic_vector (31 downto 0) -- saida dos valores de dois registradores
	);
end bancoReg_two;
	
architecture bhv_br_two of bancoReg_two is

	component registrador32_two is 
		port(
			dados :	in std_logic_vector(31 downto 0);
			load	:	in std_logic;
			clear	:	in std_logic;
			clock	:	in std_logic;
			saida :	out std_logic_vector(31 downto 0)
		);
	end component;

	signal load : std_logic_vector (31 downto 0);
	signal saida : std_logic_vector(1023 downto 0);
begin
	gen: for i in 0 to 31 generate
		reg32: registrador32_two port map (dados => valorLoad, load => load(i) , clear => clear(i), clock => clk, saida => saida((32*(i+1)-1) downto 32*i) );
	end generate;
	-- Seleciona saida do registrador 1
	with inst(25 downto 21) select 
		reg3 <= 
					--REGISTRADOR 0 ATÉ 15
					saida(31 downto 0) 		when "00000",
					saida(63 downto 32) 		when "00001",
					saida(95 downto 64) 		when "00010",
					saida(127 downto 96) 	when "00011",
					saida(159 downto 128) 	when "00100",
					saida(191 downto 160)	when "00101",
					saida(223 downto 192) 	when "00110",
					saida(255 downto 224) 	when "00111",
					saida(287 downto 256) 	when "01000",
					saida(319 downto 288) 	when "01001",
					saida(351 downto 320) 	when "01010",
					saida(383 downto 352)	when "01011",
					saida(415 downto 384) 	when "01100",
					saida(447 downto 416) 	when "01101",
					saida(479 downto 448) 	when "01110",
					saida(511 downto 480) 	when "01111",
					
					--REGISTRADOR 16 ATÉ 31
					saida(543 downto 512) 	when "10000",
					saida(575 downto 544) 	when "10001",
					saida(607 downto 576) 	when "10010",
					saida(639 downto 608) 	when "10011",
					saida(671 downto 640) 	when "10100",
					saida(703 downto 672)	when "10101",
					saida(735 downto 704) 	when "10110",
					saida(767 downto 736) 	when "10111",
					saida(799 downto 768) 	when "11000",
					saida(831 downto 800) 	when "11001",
					saida(863 downto 832) 	when "11010",
					saida(895 downto 864)	when "11011",
					saida(927 downto 896) 	when "11100",
					saida(959 downto 928) 	when "11101",
					saida(991 downto 960) 	when "11110",
					saida(1023 downto 992) 	when "11111",
					x"00000000"             when others;
		
		with inst(20 downto 16) select 
			reg4 <= 
					--REGISTRADOR 0 ATÉ 15
					saida(31 downto 0) 		when "00000",
					saida(63 downto 32) 		when "00001",
					saida(95 downto 64) 		when "00010",
					saida(127 downto 96) 	when "00011",
					saida(159 downto 128) 	when "00100",
					saida(191 downto 160)	when "00101",
					saida(223 downto 192) 	when "00110",
					saida(255 downto 224) 	when "00111",
					saida(287 downto 256) 	when "01000",
					saida(319 downto 288) 	when "01001",
					saida(351 downto 320) 	when "01010",
					saida(383 downto 352)	when "01011",
					saida(415 downto 384) 	when "01100",
					saida(447 downto 416) 	when "01101",
					saida(479 downto 448) 	when "01110",
					saida(511 downto 480) 	when "01111",
					
					--REGISTRADOR 16 ATÉ 31
					saida(543 downto 512) 	when "10000",
					saida(575 downto 544) 	when "10001",
					saida(607 downto 576) 	when "10010",
					saida(639 downto 608) 	when "10011",
					saida(671 downto 640) 	when "10100",
					saida(703 downto 672)	when "10101",
					saida(735 downto 704) 	when "10110",
					saida(767 downto 736) 	when "10111",
					saida(799 downto 768) 	when "11000",
					saida(831 downto 800) 	when "11001",
					saida(863 downto 832) 	when "11010",
					saida(895 downto 864)	when "11011",
					saida(927 downto 896) 	when "11100",
					saida(959 downto 928) 	when "11101",
					saida(991 downto 960) 	when "11110",
					saida(1023 downto 992) 	when "11111",
					x"00000000"             when others;
		
		load <= 	--REGISTRADORES 0 ATÉ 15
					x"00000001" when inst(15 downto 11) = "00000" else
					x"00000002" when inst(15 downto 11) = "00001" else
					x"00000004" when inst(15 downto 11) = "00010" else
					x"00000008" when inst(15 downto 11) = "00011" else
					x"00000010" when inst(15 downto 11) = "00100" else
					x"00000020" when inst(15 downto 11) = "00101" else
					x"00000040" when inst(15 downto 11) = "00110" else
					x"00000080" when inst(15 downto 11) = "00111" else
					x"00000100" when inst(15 downto 11) = "01000" else
					x"00000200" when inst(15 downto 11) = "01001" else
					x"00000400" when inst(15 downto 11) = "01010" else
					x"00000800" when inst(15 downto 11) = "01011" else
					x"00001000" when inst(15 downto 11) = "01100" else
					x"00002000" when inst(15 downto 11) = "01101" else
					x"00004000" when inst(15 downto 11) = "01110" else
					x"00008000" when inst(15 downto 11) = "01111" else
					
					--REGISTRADORES 16 ATÉ 31
					x"00010000" when inst(15 downto 11) = "10000" else
					x"00020000" when inst(15 downto 11) = "10001" else
					x"00040000" when inst(15 downto 11) = "10010" else
					x"00080000" when inst(15 downto 11) = "10011" else
					x"00100000" when inst(15 downto 11) = "10100" else
					x"00200000" when inst(15 downto 11) = "10101" else
					x"00400000" when inst(15 downto 11) = "10110" else
					x"00800000" when inst(15 downto 11) = "10111" else
					x"01000000" when inst(15 downto 11) = "11000" else
					x"02000000" when inst(15 downto 11) = "11001" else
					x"04000000" when inst(15 downto 11) = "11010" else
					x"08000000" when inst(15 downto 11) = "11011" else
					x"10000000" when inst(15 downto 11) = "11100" else
					x"20000000" when inst(15 downto 11) = "11101" else
					x"40000000" when inst(15 downto 11) = "11110" else
					x"80000000" when inst(15 downto 11) = "11111" else
				x"00000000";
	
end bhv_br_two;
