LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity GPFullAdder is
	port (X, Y, Cin: in std_logic;
	G, P, Sum: out std_logic);
end GPFullAdder;

architecture Behavioral of GPFullAdder is
signal P_int: std_logic;
begin
	G <= X and Y;
	P <= P_int;
	P_int <= X xor Y;
	Sum <= P_int xor Cin;
end Behavioral;