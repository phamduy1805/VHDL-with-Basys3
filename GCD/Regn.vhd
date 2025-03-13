library ieee;
use ieee.std_logic_1164.all;

entity Regn is			 
	generic (DATA_WIDTH: Integer := 4);
	port (
	rst:	in std_logic;
	clk: 	in std_logic;
	en:		in std_logic;
	D:		in std_logic_vector (DATA_WIDTH - 1 downto 0);
	Q: 		out std_logic_vector (DATA_WIDTH - 1 downto 0)
	);
end Regn;

architecture RTL of Regn is	
signal Qsig: std_logic_vector (DATA_WIDTH - 1 downto 0) := (others => '0');
begin
	process (rst, clk)
	begin
		if rst = '1' then Qsig <= (others => '0');
		elsif clk'event and clk = '1' then 
			if en = '1' then Qsig <= D;
			end if;
		end if;
	end process;
	Q <= Qsig;
end RTL;
	