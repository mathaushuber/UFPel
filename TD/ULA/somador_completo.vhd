LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY somador_completo IS
  PORT(
  a, b, c_in: in std_logic;
  s, c_out: out std_logic
  );
end somador_completo;
architecture HARDWARE of somador_completo is
begin 
  s <= c_in xor a xor b;
  c_out <= (a and b) or (a and c_in) or (b and c_in);
end HARDWARE;
