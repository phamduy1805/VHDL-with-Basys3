library IEEE;
use IEEE.std_logic_1164.all;

entity CLA4 is
	port (A, B: in std_logic_vector(3 downto 0);Cin: std_logic; --Inputs
	S: out std_logic_vector(3 downto 0); Co, Pg, Gg: out std_logic); --Outputs
end CLA4;

architecture Structure of CLA4 is
--for calculate G, P, S for each column
component GPFullAdder is
	port (X, Y, Cin: in std_logic;
	G, P, Sum: out std_logic);
end component;

--for calculate Cout of each column; and Co, Gg, Pg of block
component CLALogic is
	port(G, P: in std_logic_vector(3 downto 0); Ci: in std_logic;
	C: out std_logic_vector(3 downto 1); Co, Pg, Gg: out std_logic);
end component;

signal G, P: std_logic_vector(3 downto 0);
signal C: std_logic_vector(3 downto 1); --internal signals

begin
-- instantiate four copies of the GPFullAdder
CarryLogic: CLALogic port map(G => G, P => P, Ci => Cin, C => C, Co => Co, Pg => Pg, Gg => Gg);
FA0: GPFullAdder port map (X => A(0), Y => B(0), Cin => Cin, G => G(0), P => P(0), Sum => S(0));
FA1: GPFullAdder port map (X => A(1), Y => B(1), Cin => C(1), G => G(1), P => P(1), Sum => S(1));
FA2: GPFullAdder port map (X => A(2), Y => B(2), Cin => C(2), G => G(2), P => P(2), Sum => S(2));
FA3: GPFullAdder port map (X => A(3), Y => B(3), Cin => C(3), G => G(3), P => P(3), Sum => S(3));
end Structure;