--
--  
-- Autor: Erick S. Dias
-- Data: 03/12/24

library ieee;
use ieee.std_logic_1164.all;

entity top_level is
    port(
        a1, a0, b1, b0          : in std_logic;
        igual, maior, menor     : out std_logic
    );
end entity;

architecture main of top_level is

    component top is
        port(
            a1, a0, b1, b0          : in std_logic;
            igual, maior, menor     : out std_logic
        );
    end component;

begin

    U: top port map (a1 => a1, a0 => a0, b1 => b1, b0 => b0, igual => igual, maior => maior, menor => menor);
    
end architecture;