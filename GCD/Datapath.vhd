library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
library work;
use work.extraPackage.all;

entity Datapath is
	generic (DATA_WIDTH: Integer := 4);
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
end Datapath;	

architecture RTL of Datapath is
signal X_src, XsubY, Y_src, YsubX, X, Y: std_logic_vector (DATA_WIDTH - 1 downto 0) := (others => '0');
begin
	-- Mux for select X
	X_src <= X_i when X_sel = '1' else XsubY;
	-- Mux for select Y
	Y_src <= Y_i when Y_sel = '1' else YsubX;
	-- Compare if X not equal to Y
	X_neq_Y <= '1' when X /= Y else '0';
	-- Compare if X is less than Y
	X_lt_Y <= '1' when X < Y else '0';
	-- X - Y
	XsubY <= X - Y;
	-- Y - X
	YsubX <= Y - X;
		
	--X register
	RegX: Regn
	generic map (DATA_WIDTH => DATA_WIDTH)
	port map (
	rst => rst,
	clk => clk,
	en => X_ld,
	D => X_src,	
	Q => X
	); 
	--Y register
	RegY: Regn
	generic map (DATA_WIDTH => DATA_WIDTH)
	port map (
	rst => rst,
	clk => clk,
	en => Y_ld,
	D => Y_src,	
	Q => Y
	);
	--GCD register
	RegGCD: Regn
	generic map (DATA_WIDTH => DATA_WIDTH)
	port map (
	rst => rst,
	clk => clk,
	en => GCD_ld,
	D => X,	
	Q => GCD_o
	);
end RTL;