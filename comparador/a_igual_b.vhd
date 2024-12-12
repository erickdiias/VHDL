-- A = B
--  
-- Autor: Erick S. Dias
-- Data: 03/12/24

library ieee;
use ieee.std_logic_1164.all;

entity a_igual_b is
    port(
        a1, a0, b1, b0  : in std_logic;
        igual           : out std_logic
    );
end entity;

architecture main of a_igual_b is
begin
    igual <= (not a1 and not a0 and not b1 and not b0) or
             (not a1 and a0 and not b1 and b0) or
             (a1 and a0 and b1 and b0) or
             (a1 and not a0 and b1 and not b0);
end architecture;