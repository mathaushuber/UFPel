library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity ctrl_unit is
	port (
		clk : in STD_LOGIC;
		rst : in STD_LOGIC;
		inst : in STD_LOGIC_VECTOR (12 downto 0);
		n : in STD_LOGIC;
		z : in STD_LOGIC;
		selREM : out STD_LOGIC;
		cgREM : out STD_LOGIC;
		selRDM : out STD_LOGIC;
		cgRDM : out STD_LOGIC;
		cgAC : out STD_LOGIC;
		cgRI : out STD_LOGIC;
		cgNZ : out STD_LOGIC;
		cgPC : out STD_LOGIC;
		incPC : out STD_LOGIC;
		selULA : out STD_LOGIC_VECTOR (2 downto 0);
		wea : out STD_LOGIC_VECTOR (0 downto 0)
	);
end ctrl_unit;

architecture Behavioral of ctrl_unit is

	type state is (t0, t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, hlt);
	signal currentState, nextState : state;

begin

	process (clk, rst)
	begin
		if (rst = '1') then
			currentState <= t0;
		elsif (rising_edge(clk)) then
			currentState <= nextState;
		end if;
	end process;

	process (currentState, inst, n, z)
	begin
		selREM <= '0';
		cgREM <= '0';
		selRDM <= '0';
		cgRDM <= '0';
		cgAC <= '0';
		cgRI <= '0';
		cgNZ <= '0';
		cgPC <= '0';
		incPC <= '0';
		selULA <= "000";
		wea <= "0";
		case currentState is
			when t0 =>
				selREM <= '0';
				cgREM <= '1';
				nextState <= t1;
			when t1 =>
				wea <= "0";
				cgRDM <= '1';
				incPC <= '1';
				nextState <= t2;
			when t2 =>
				wea <= "0";
				cgRDM <= '1';
				incPC <= '0';
				nextState <= t3;
			when t3 =>
				cgRI <= '1';
				nextState <= t4;
			when t4 =>
				if (inst(5 downto 1) /= "00000" or inst(10) = '1' or inst(7) = '1' or inst(11) = '1') then
					selREM <= '0';
					cgREM <= '1';
					nextState <= t5;
				elsif (inst(8) = '1') then
					if (n = '1') then
						selREM <= '0';
						cgREM <= '1';
						nextState <= t5;
					else
						incPC <= '1';
						nextState <= t0;
					end if;
				elsif (inst(9) = '1') then
					if (z = '1') then
						selREM <= '0';
						cgREM <= '1';
						nextState <= t5;
					else
						incPC <= '1';
						nextState <= t0;
					end if;
				elsif (inst(6) = '1') then
					selULA <= "011";
					cgAC <= '1';
					cgNZ <= '1';
					nextState <= t0;
				elsif (inst(0) = '1') then
					nextState <= t0;
				else
					nextState <= hlt;
				end if;
			when t5 =>
				if (inst(5 downto 1) /= "00000" or inst(10) = '1' or inst(11) = '1') then
					wea <= "0";
					cgRDM <= '1';
					--incPC <= '1';
					nextState <= t6;
				elsif (inst(7) = '1') then
					wea <= "0";
					cgRDM <= '1';
					nextState <= t6;
				elsif (inst(8) = '1') then
					if (n = '1') then
						wea <= "0";
						cgRDM <= '1';
						nextState <= t6;
					else
						nextState <= hlt;
					end if;
				elsif (inst(9) = '1') then
					if (z = '1') then
						wea <= "0";
						cgRDM <= '1';
						nextState <= t6;
					else
						nextState <= hlt;
					end if;
				else
					nextState <= hlt;
				end if;
			when t6 =>
				if (inst(5 downto 1) /= "00000" or inst(10) = '1' or inst(11) = '1') then
					wea <= "0";
					cgRDM <= '1';
					incPC <= '1';
					nextState <= t7;
				elsif (inst(7) = '1') then
					wea <= "0";
					cgRDM <= '1';
					nextState <= t7;
				elsif (inst(8) = '1') then
					if (n = '1') then
						wea <= "0";
						cgRDM <= '1';
						nextState <= t7;
					else
						nextState <= hlt;
					end if;
				elsif (inst(9) = '1') then
					if (z = '1') then
						wea <= "0";
						cgRDM <= '1';
						nextState <= t7;
					else
						nextState <= hlt;
					end if;
				else
					nextState <= hlt;
				end if;
			when t7 =>
				if (inst(5 downto 1) /= "00000" or inst(10) = '1' or inst(11) = '1') then
					selREM <= '1';
					cgREM <= '1';
					nextState <= t8;
				elsif (inst(7) = '1' or (inst(8) = '1' and n = '1') or (inst(9) = '1' and z = '1')) then
					cgPC <= '1';
					nextState <= t0;
				else
					nextState <= hlt;
				end if;
			when t8 =>
				if (inst(5 downto 2) /= "0000" or inst(10) = '1' or inst(11) = '1') then
					wea <= "0";
					cgRDM <= '1';
					nextState <= t9;
				elsif (inst(1) = '1') then
					selRDM <= '1';
					cgRDM <= '1';
					nextState <= t10;
				else
					nextState <= hlt;
				end if;
			when t9 =>
				if (inst(5 downto 2) /= "0000" or inst(10) = '1' or inst(11) = '1') then
					wea <= "0";
					cgRDM <= '1';
					nextState <= t10;
				elsif (inst(1) = '1') then
					selRDM <= '1';
					cgRDM <= '1';
					nextState <= t10;
				else
					cgRDM <= '0';
					nextState <= hlt;
				end if;
			when t10 =>
				if (inst(1) = '1') then
					wea <= "1";
					nextState <= t0;
				elsif (inst(3) = '1') then
					selULA <= "000";
					cgAC <= '1';
					cgNZ <= '1';
					nextState <= t0;
				elsif (inst(5) = '1') then
					selULA <= "001";
					cgAC <= '1';
					cgNZ <= '1';
					nextState <= t0;
				elsif (inst(4) = '1') then
					selULA <= "010";
					cgAC <= '1';
					cgNZ <= '1';
					nextState <= t0;
				elsif (inst(2) = '1') then
					selULA <= "100";
					cgAC <= '1';
					cgNZ <= '1';
					nextState <= t0;
				elsif (inst(10) = '1') then
					selULA <= "101";
					cgAC <= '1';
					cgNZ <= '1';
					nextState <= t0;
				elsif (inst(11) = '1') then
					selULA <= "110";
					cgAC <= '1';
					cgNZ <= '1';
					nextState <= t0;
				else
					nextState <= hlt;
				end if;
			when hlt =>
				nextState <= hlt;
			when others =>
				nextState <= t0;
		end case;
	end process;

end Behavioral;