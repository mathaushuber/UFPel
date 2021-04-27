library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity contador is 
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
end contador; 
architecture arq_contador of contador is
	begin	
    
      process(clock)
		variable cont: std_logic_vector(5 downto 0);

		begin
         
			cont:= partida;   
		if (hold or clear)='1' then --se hold ou clear for =1, então
                
                	if hold= '1' then   --se hold =1, então
                    		cont:=cont;
								LED_hold <= '1';
								LED_cont <= '0';
                	end if;
					 
                	if clear = '1'then  --se clear =1, então
                    		cont := "000000";
                	end if;
				saida <= cont;
          	else if clock = '1' then   --se não, se clock for=1,entao
                LED_hold <= '0';
					 LED_cont <= '1';
			if sentido= '1' then	--se sentido for = 1 , entao
			
				if load= '1' then   -- se load for = 1, entao
                        		cont:= valor;
				else					--se não...
					cont:= cont + 1;
				end if;
							
				if cont > 59 then 	--se cont for maior que 59, entao
					cont:="000000";
				end if; 
			else
				
				if load='1' then  -- se load for = 1, entao
					cont:=valor; 
				else					--se não...
									cont:=cont-1;
				end if;
					
				if (cont < 0) then		--se cont for menor que 0, entao
					cont:="111011";
				end if; 
				
				end if;
				 saida <= cont;
          			end if;
				end if; 
      end process;  
end arq_contador;
