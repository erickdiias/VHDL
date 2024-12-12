-- full adder
-- autor: Erick S. Dias
-- data: 12/11/24

library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port(
        a, b, cin   : in std_logic;
        sum, cout   : out std_logic;
    );
end entity;

architecture rtl of full_adder is

    signal c1, c2, c3 : std_logic;

    component half_adder is
        port(
            a, b        : in std_logic;
            sum, cout   : out std_logic
        );
    end component;

begin

    cout <= c2 or c3;

    ha1: half_adder port map(
        a       => a,
        b       => b,
        sum     => c1,
        cout    => c2
    );

    ha2: half_adder port map(
        a       => c1,
        b       => cin,
        sum     => sum,
        cout    => cout
    );

end architecture;