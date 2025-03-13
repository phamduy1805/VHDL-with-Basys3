library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity mul4x4 is
	port(
	clk: in std_logic;
	start: in std_logic;
	Mplier: in std_logic_vector (3 downto 0);
	Mplicand: in std_logic_vector (3 downto 0);
	Product: out std_logic_vector (7 downto 0);
	Done: out std_logic
	);
end mul4x4;

architecture behavioral of mul4x4 is
signal State: integer range 0 to 9 := 0;
signal ACC: std_logic_vector (8 downto 0);
alias M: std_logic is ACC(0);
begin
	process (clk)
	begin
		if clk'event and clk = '1' then
			case State is
				when 0 => 
				if start = '1' then
					ACC(3 downto 0) <= Mplier;
					ACC(8 downto 4) <= "00000";
					State <= 1;
				end if;
				when 1 | 3 | 5 | 7 =>
				if M = '1' then 
					ACC(8 downto 4) <= '0' & ACC(7 downto 4) + Mplicand;--add
					State <= State + 1;
				else 
					ACC(8 downto 0 ) <= '0' & ACC(8 downto 1);
					State <= State + 2;
				end if;
				when 2 | 4 | 6 | 8 =>
				ACC <= '0' & ACC(8 downto 1);
				State <= State + 1;
				when 9 =>
				State <= 0;
			end case;
		end if;
	end process;
	Done <= '1' when State = 9 else '0';  
	Product <= ACC(7 downto 0);
end behavioral;
	
				