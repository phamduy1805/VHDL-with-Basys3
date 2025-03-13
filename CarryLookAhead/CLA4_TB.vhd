LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY CLA4_TB IS
END CLA4_TB;

ARCHITECTURE test OF CLA4_TB IS
    COMPONENT CLA4
        PORT(
            A, B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            Cin  : IN STD_LOGIC;
            S    : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            Co, Pg, Gg : OUT STD_LOGIC
        );
    END COMPONENT;

    -- Tín hi?u test
    SIGNAL A, B, S : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL Cin, Co, Pg, Gg : STD_LOGIC;

BEGIN
    -- Instantiate CLA4
    UUT: CLA4 PORT MAP(A => A, B => B, Cin => Cin, S => S, Co => Co, Pg => Pg, Gg => Gg);

    -- Test process
    PROCESS
    BEGIN
        -- Test case 1: 0000 + 0000
        A <= "0000"; B <= "0000"; Cin <= '0';
        WAIT FOR 10 ns;
        
        -- Test case 2: 0001 + 0001
        A <= "0001"; B <= "0001"; Cin <= '0';
        WAIT FOR 10 ns;
        
        -- Test case 3: 0101 + 0011
        A <= "0101"; B <= "0011"; Cin <= '0';
        WAIT FOR 10 ns;
        
        -- Test case 4: 1111 + 0001
        A <= "1111"; B <= "0001"; Cin <= '0';
        WAIT FOR 10 ns;
        
        -- Test case 5: 0110 + 1001 with carry-in
        A <= "0110"; B <= "1001"; Cin <= '1';
        WAIT FOR 10 ns;
        
        -- Test case 6: 1010 + 0101 with carry-in
        A <= "1010"; B <= "0101"; Cin <= '1';
        WAIT FOR 10 ns;

        -- Test case 7: 1111 + 1111 (Max value)
        A <= "1111"; B <= "1111"; Cin <= '0';
        WAIT FOR 10 ns;

        -- K?t thúc mô ph?ng
        WAIT;
    END PROCESS;
END test;
