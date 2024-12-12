-- Top
--  
-- Autor: Erick S. Dias
-- Data: 03/12/24

library ieee;
use ieee.std_logic_1164.all;

entity top is
    port(
        a1, a0, b1, b0          : in std_logic;
        igual, maior, menor     : out std_logic
    );
end entity;

architecture main of top is

    component a_igual_b is
        port(
            a1, a0, b1, b0  : in std_logic;
            igual           : out std_logic
        );
    end component;

    component a_maior_b is
        port(
            a1, a0, b1, b0   : in std_logic;
            maior            : out std_logic
        );
    end component;

    component a_menor_b is
        port(
            a1, a0, b1, b0   : in std_logic;
            menor            : out std_logic
        );
    end component;

begin

    U1: a_igual_b port map (a1 => a1, a0 => a0, b1 => b1, b0 => b0, igual => igual);
    U2: a_maior_b port map (a1 => a1, a0 => a0, b1 => b1, b0 => b0, maior => maior);
    U3: a_menor_b port map (a1 => a1, a0 => a0, b1 => b1, b0 => b0, menor => menor);

end architecture;