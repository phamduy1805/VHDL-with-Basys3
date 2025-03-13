LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY seven_seg_display IS
	PORT (
	clk: 	IN STD_LOGIC; --tan so mac dinh cua basys 3 la 100Mhz
	reset: 	IN STD_LOGIC;
	seg: 	OUT STD_LOGIC_VECTOR (6 downto 0);
	an: 	OUT STD_LOGIC_VECTOR ( 3 downto 0)
	);
END seven_seg_display;

ARCHITECTURE Behavioral OF seven_seg_display IS
SIGNAL counter: INTEGER := 0; --bo dem chia xung
SIGNAL digit: 	INTEGER := 0; --gia tri so hien thi
begin
	--chia xung xuong 1hz
	process (clk)
	begin
		if reset = '1' then 
			counter <= 0;
			digit <= 0;
		elsif rising_edge(clk) then
			counter <= counter + 1;
			if counter >= 100_000_000 then 
				counter <= 0;
				if digit = 9 then
					digit <= 0;
				else
					digit <= digit + 1;
				end if;
			end if;
		end if;
	end process;
	
	--ma hoa BCD
	process(digit)
    begin
        case digit is
            when 0 => seg <= "1000000"; -- 0
            when 1 => seg <= "1111001"; -- 1
            when 2 => seg <= "0100100"; -- 2
            when 3 => seg <= "0110000"; -- 3
            when 4 => seg <= "0011001"; -- 4
            when 5 => seg <= "0010010"; -- 5
            when 6 => seg <= "0000010"; -- 6
            when 7 => seg <= "1111000"; -- 7
            when 8 => seg <= "0000000"; -- 8
            when 9 => seg <= "0010000"; -- 9
            when others => seg <= "1111111"; -- T?t LED khi l?i
        end case;
    end process; 
	
	-- lua chon led cho basys3
    an <= "1110";
end Behavioral;
	