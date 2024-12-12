-- A < B
--  
-- Autor: Erick S. Dias
-- Data: 03/12/24

library ieee;
use ieee.std_logic_1164.all;

entity a_menor_b is
    port(
        a1, a0, b1, b0   : in std_logic;
        menor            : out std_logic
    );
end entity;

architecture main of a_menor_b is
begin
    menor <= (not a1 and b1) or
             (not a0 and b1 and b0) or
             (not a1 and not a0 and b0);
end architecture;