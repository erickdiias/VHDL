library ieee;
use ieee.std_logic_1164.all;

entity FlipFlop_Mestre_Escravo is
    port(
        D, CLK      : in std_logic;
        Q, Q_bar    : out std_logic
    );
end entity;

architecture main of FlipFlop_Mestre_Escravo is
    signal set1, reset1, Q_int1, Q_bar_int1 : std_logic; -- Sinais mestre
    signal set2, reset2, Q_int2, Q_bar_int2 : std_logic; -- Sinais escravo
begin

    -- Mestre
    set1       <= not(CLK) nand D;
    reset1     <= not(CLK) nand not(D);

    Q_int1     <= set1 nand Q_bar_int1;
    Q_bar_int1 <= reset1 nand Q_int1;

    -- Escravo
    set2       <= Q_int1 nand CLK;
    reset2     <= Q_bar_int1 nand CLK;

    Q_int2     <= set2 nand Q_bar_int2;
    Q_bar_int2 <= reset2 nand Q_int2;

    -- Saída
    Q          <= Q_int2;
    Q_bar      <= Q_bar_int2;

end architecture;
