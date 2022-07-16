
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY neander_tb IS
END neander_tb;
 
ARCHITECTURE behavior OF neander_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT neander
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         currentDATA : OUT  std_logic_vector(7 downto 0);
         ac : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal currentDATA : std_logic_vector(7 downto 0);
   signal ac : std_logic_vector(7 downto 0);
	signal counter : integer := 0;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: neander PORT MAP (
          clk => clk,
          rst => rst,
          currentDATA => currentDATA,
          ac => ac
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		counter <= counter + 1;
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		rst <= '1';
      wait for 100 ns;	
		rst <= '0';
      wait;
   end process;

END;
