LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mul4x4_tb IS
END mul4x4_tb;

ARCHITECTURE test OF mul4x4_tb IS
    -- Component c?a DUT
    COMPONENT mul4x4
        PORT (
            clk      : IN  std_logic;
            start    : IN  std_logic;
            Mplier   : IN  std_logic_vector(3 downto 0);
            Mplicand : IN  std_logic_vector(3 downto 0);
            Product  : OUT std_logic_vector(8 downto 0);
            Done     : OUT std_logic
        );
    END COMPONENT;

    -- Tín hi?u k?t n?i v?i DUT
    SIGNAL clk      : std_logic := '0';
    SIGNAL start    : std_logic := '0';
    SIGNAL Mplier   : std_logic_vector(3 downto 0) := (others => '0');
    SIGNAL Mplicand : std_logic_vector(3 downto 0) := (others => '0');
    SIGNAL Product  : std_logic_vector(8 downto 0);
    SIGNAL Done     : std_logic;

    -- T?o xung clock
    CONSTANT clk_period : time := 10 ns;

BEGIN
    -- K?t n?i DUT
    DUT: mul4x4 PORT MAP (
        clk      => clk,
        start    => start,
        Mplier   => Mplier,
        Mplicand => Mplicand,
        Product  => Product,
        Done     => Done
    );

    -- Process t?o xung clock
    clk_process: PROCESS
    BEGIN
        WHILE NOW < 500 ns LOOP  -- Gi?i h?n th?i gian mô ph?ng
            clk <= '0';
            WAIT FOR clk_period / 2;
            clk <= '1';
            WAIT FOR clk_period / 2;
        END LOOP;
        WAIT;
    END PROCESS;

    -- Process t?o test vector
    stimulus_process: PROCESS
    BEGIN
        -- Reset ban d?u
        start <= '0';
        Mplier <= "0000";
        Mplicand <= "0000";
        WAIT FOR 20 ns;

        -- Test case 1: 3 * 1
        start <= '1';
        Mplier <= "0011";  -- 3
        Mplicand <= "0001"; -- 1
        WAIT FOR 10 ns;
        start <= '0';

        -- Ch? tín hi?u Done
        WAIT UNTIL Done = '1';
        WAIT FOR 20 ns;

        -- Test case 2: 7 * 5
        start <= '1';
        Mplier <= "0111";  -- 7
        Mplicand <= "0101"; -- 5
        WAIT FOR 10 ns;
        start <= '0';

        -- Ch? tín hi?u Done
        WAIT UNTIL Done = '1';
        WAIT FOR 20 ns;

        -- K?t thúc mô ph?ng
        WAIT;
    END PROCESS;

END test;
