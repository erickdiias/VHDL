-- half adder
-- autor: Erick S. Dias
-- data: 12/11/24

library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
    port(
        a, b        : in std_logic;
        sum, cout   : out std_logic
    );
end entity;

architecture dataflow of half_adder is
begin

    sum     <= a xor b;
    cout    <= a and b;

end architecture;
