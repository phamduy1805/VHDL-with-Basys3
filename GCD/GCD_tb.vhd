library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity GCD_tb is
end GCD_tb;

architecture test of GCD_tb is
    constant DATA_WIDTH : integer := 4;
    signal rst, clk, start_i, Done_o : std_logic := '0';
    signal X_i, Y_i, GCD_o : std_logic_vector(DATA_WIDTH - 1 downto 0) := (others => '0');
    
    component GCD
        generic (DATA_WIDTH : Integer := 4);
        port (
            rst: in std_logic;
            clk: in std_logic;
            start_i: in std_logic;
            X_i: in std_logic_vector (DATA_WIDTH - 1 downto 0);
            Y_i: in std_logic_vector (DATA_WIDTH - 1 downto 0);
            GCD_o: out std_logic_vector (DATA_WIDTH - 1 downto 0);
            Done_o: out std_logic
        );
    end component;
    
begin
    uut: GCD
        generic map (DATA_WIDTH => DATA_WIDTH)
        port map (
            rst => rst,
            clk => clk,
            start_i => start_i,
            X_i => X_i,
            Y_i => Y_i,
            GCD_o => GCD_o,
            Done_o => Done_o
        );
    
    -- Clock process
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
        end loop;
    end process;
    
    -- Stimulus process
    stimulus: process
    begin
        -- Reset
        rst <= '1';
        X_i <= (others => '0');
        Y_i <= (others => '0');
        start_i <= '0';
        wait for 50 ns;
        rst <= '0';
        wait for 50 ns;
        
        -- Test case 1: GCD(12, 8) = 4
        X_i <= "1100"; -- 12
        Y_i <= "1000"; -- 8
        wait for 20 ns;
        start_i <= '1';
        wait for 20 ns;
        start_i <= '0';
        wait until Done_o = '1';
        wait for 20 ns;
        
        -- Test case 2: GCD(15, 5) = 5
        X_i <= "1111"; -- 15
        Y_i <= "0101"; -- 5
        wait for 20 ns;
        start_i <= '1';
        wait for 20 ns;
        start_i <= '0';
        wait until Done_o = '1';
        wait for 20 ns;
        
        -- Test case 3: GCD(9, 6) = 3
        X_i <= "1001"; -- 9
        Y_i <= "0110"; -- 6
        wait for 20 ns;
        start_i <= '1';
        wait for 20 ns;
        start_i <= '0';
        wait until Done_o = '1';
        wait for 20 ns;
        
        -- End simulation
        wait;
    end process;
end test;
