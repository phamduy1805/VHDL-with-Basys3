library ieee;
use ieee.std_logic_1164.all;

package extraPackage is
	
component GCD is
	generic (DATA_WIDTH : Integer := 8);
	port (
	rst: 		in std_logic;
	clk: 		in std_logic;
	start_i: 	in std_logic;
	X_i: 		in std_logic_vector (DATA_WIDTH - 1 downto 0);
	Y_i: 		in std_logic_vector (DATA_WIDTH - 1 downto 0);
	GCD_o: 		out std_logic_vector (DATA_WIDTH - 1 downto 0);	
	Done_o: 	out std_logic
	);
end component GCD;

component Regn is
	generic (DATA_WIDTH: Integer := 8);
	port(
	rst:	in std_logic;
	clk: 	in std_logic;
	en:		in std_logic;
	D:		in std_logic_vector (DATA_WIDTH - 1 downto 0);
	Q: 		out std_logic_vector (DATA_WIDTH - 1 downto 0)
	);
end component Regn;

component Datapath is
	generic (DATA_WIDTH: Integer := 8);
	port(
	rst:		in std_logic;
	clk:		in std_logic;
	X_sel:		in std_logic;
	Y_sel:  	in std_logic;
	X_ld:		in std_logic;
	Y_ld:		in std_logic;
	GCD_ld:		in std_logic;
	X_i:		in std_logic_vector (DATA_WIDTH - 1 downto 0);
	Y_i: 		in std_logic_vector (DATA_WIDTH - 1 downto 0);
	X_neq_Y:	out std_logic;
	X_lt_Y:		out std_logic;
	GCD_o:      out std_logic_vector(DATA_WIDTH - 1 downto 0)
	);
end component Datapath;

component Controller is
	port (
	rst: 		in std_logic;
	clk: 		in std_logic;
	start_i: 	in std_logic; 
	X_sel: 		out std_logic;
	Y_sel: 		out std_logic;
	X_ld: 		out std_logic;
	Y_ld: 		out std_logic;
	GCD_ld: 	out std_logic;
	X_neq_Y: 	in std_logic;
	X_lt_Y: 	in std_logic;
	Done_o: 	out std_logic
	);
end component Controller;

end extraPackage;