LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity CLALogic is
	port(G, P: in std_logic_vector(3 downto 0); Ci: in std_logic;
	C: out std_logic_vector(3 downto 1); Co, Pg, Gg: out std_logic);
end CLALogic;

architecture Behavioral of CLALogic is
signal Gg_int, Pg_int: std_logic;
begin
	C(1) <= G(0) or (P(0) and Ci); 
	C(2) <= G(1) or (P(1) and G(0)) or (P(1) and P(0) and Ci);
	C(3) <= G(2) or (P(2) and G(1)) or (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and Ci);
	Pg_int <= P(3) and P(2) and P(1) and P(0);
	Gg_int <= G(3) or (G(2) and P(3)) or (G(1) and P(2) and P(3)) or (G(0) and P(1) and P(2) and P(3));
	Co <= Gg_int or (Pg_int and Ci); 
	Pg <= Pg_int;
	Gg <= Gg_int;
end Behavioral;