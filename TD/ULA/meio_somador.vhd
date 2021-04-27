LIBRARY	IEEE;
USE IEEE.std_logic_1164.all;

ENTITY meio_somador IS
  PORT(
  a, b: in std_logic;
  s, c_out: out std_logic
  );
end meio_somador;
architecture Behavorial of meio_somador is
begin 
  s <= (not(a) and b) or (a and not(b));
  c_out <= a and b;
end Behavorial;
