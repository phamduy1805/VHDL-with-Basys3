library ieee;
use ieee.std_logic_1164.all;

entity Controller is
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
end Controller;

architecture RTL of Controller is 
type state is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12);
signal present_state, next_state: state;
begin
	state_reg: process (rst, clk)
	begin
		if rst = '1' then present_state <= S0;
		else
			if clk'event and clk = '1' then
				present_state <= next_state;
			end if;
		end if;
	end process;
	
	next_logic: process (present_state, start_i, X_neq_Y, X_lt_Y)
	begin
		case present_state is
			when S0 => next_state <= S1;
			when S1 => 
				if start_i = '1' then next_state <= S2;
				else next_state <= S1;
				end if;
			when S2 => next_state <= S3;
			when S3 => next_state <= S4;
			when S4 =>
				if X_neq_Y = '1' then next_state <= S5;
				else next_state <= S9;
				end if;
			when S5 =>
				if X_lt_Y = '1' then next_state <= S6;
				else next_state <= S7;
				end if;
			when S6 => next_state <= S4;
			when S7 => next_state <= S4;
			when S9 => next_state <= S10;  
			when S10 => next_state <= S11;
			when S11 => 
				if start_i = '1' then next_state <= S12;
				else next_state <= S11;
				end if;
			when S12 => next_state <= S0;
			when others => next_state <= S0;
		end case;
	end process;   
	
	-- Combinational Logic
	X_sel <= '1' WHEN present_state = S2 ELSE '0';
	X_ld  <= '1' WHEN (present_state = S2 OR present_state = S7) ELSE '0';
	
	Y_sel <= '1' WHEN present_state = S3 ELSE '0';
	Y_ld  <= '1' WHEN (present_state = S3 OR present_state = S6) ELSE '0';
	
	GCD_ld <= '1' WHEN present_state = S9 ELSE '0';
	Done_o <= '1' WHEN (present_state = S10 AND present_state = S11) ELSE '0';

	
	
	
end RTL;
			
		
		
