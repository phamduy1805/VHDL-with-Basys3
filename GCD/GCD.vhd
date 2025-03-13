library ieee;
use ieee.std_logic_1164.all;
library work;
use work.extraPackage.all;

entity GCD is
	generic (DATA_WIDTH : Integer := 4);
	port (
	rst: 		in std_logic;
	clk: 		in std_logic;
	start_i: 	in std_logic;
	X_i: 		in std_logic_vector (DATA_WIDTH - 1 downto 0);
	Y_i: 		in std_logic_vector (DATA_WIDTH - 1 downto 0);
	GCD_o: 		out std_logic_vector (DATA_WIDTH - 1 downto 0);	
	Done_o: 	out std_logic
	);
end GCD;

architecture RTL of GCD is 
signal X_sel, Y_sel: std_logic := '0';
signal X_ld, Y_ld: std_logic := '0';
signal GCD_ld: std_logic := '0';
signal X_neq_Y, X_lt_Y: std_logic := '0';
begin
	Control_Unit: Controller
	port map(
	rst, 		
	clk, 		
	start_i, 	 
	X_sel, 		
	Y_sel, 		
	X_ld, 		
	Y_ld, 		
	GCD_ld, 	
	X_neq_Y, 	
	X_lt_Y,	
	Done_o 	
	);
	
	DataPath_Uint: Datapath
	generic map (DATA_WIDTH)
	port map(
	rst,
	clk,
	X_sel,
	Y_sel,
	X_ld,
	Y_ld,
	GCD_ld,
	X_i,
	Y_i,
	X_neq_Y,
	X_lt_Y,
	GCD_o
	);

end RTL;