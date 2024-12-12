--
--
--
--

library ieee;
use ieee.std_logic_1164.all;

entity FF_D is
    port(
        clk, D      : in std_logic;
        Q, Q_bar    : out std_logic
    );
end entity;

architecture main of FF_D is
    signal Q_int : std_logic := '0';
begin
    process(clk)
    begin
        if rising_edge(clk) then
            Q_int <= D;
        end if;
    end process;

    Q <= Q_int;
    Q_bar <= not Q_int;

end architecture;