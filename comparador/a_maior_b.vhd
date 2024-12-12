-- A > B
--  
-- Autor: Erick S. Dias
-- Data: 03/12/24

library ieee;
use ieee.std_logic_1164.all;

entity a_maior_b is
    port(
        a1, a0, b1, b0   : in std_logic;
        maior            : out std_logic
    );
end entity;

architecture main of a_maior_b is
begin
    maior <= (a1 and not b1) or
             (a0 and not b1 and not b0) or
             (a1 and a0 and not b0);
end architecture;