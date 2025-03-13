library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity BCD_Adder is
    port(
        X, Y: in std_logic_vector(7 downto 0);
        Z: out std_logic_vector(11 downto 0)
    );
end BCD_Adder;

architecture BCDadd of BCD_Adder is
    alias Xdig1: std_logic_vector(3 downto 0) is X(7 downto 4);
    alias Xdig0: std_logic_vector(3 downto 0) is X(3 downto 0);
    alias Ydig1: std_logic_vector(3 downto 0) is Y(7 downto 4);
    alias Ydig0: std_logic_vector(3 downto 0) is Y(3 downto 0);
    alias Zdig2: std_logic_vector(3 downto 0) is Z(11 downto 8);
    alias Zdig1: std_logic_vector(3 downto 0) is Z(7 downto 4);
    alias Zdig0: std_logic_vector(3 downto 0) is Z(3 downto 0);

    signal S0, S1: std_logic_vector(4 downto 0);
    signal C: std_logic;
begin
    S0 <= std_logic_vector(resize(unsigned('0' & Xdig0) + unsigned(Ydig0), 5));
    Zdig0 <= std_logic_vector(unsigned(S0(3 downto 0)) + 6) when unsigned(S0) > 9 
             else S0(3 downto 0);
    C <= '1' when unsigned(S0) > 9 else '0';

    S1 <= std_logic_vector(resize(unsigned('0' & Xdig1) + unsigned(Ydig1) + ("0000" & C), 5));
    Zdig1 <= std_logic_vector(unsigned(S1(3 downto 0)) + 6) when unsigned(S1) > 9 
             else S1(3 downto 0);
    Zdig2 <= "0001" when unsigned(S1) > 9 else "0000";
end BCDadd;
