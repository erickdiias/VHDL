-- Aula do dia 08/11/24
-- Atividade pratica
-- Autor: Erick S. Dias (157491), Caroline Bauman (163461)
-- Data: 08/11/2024

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Sistemas_digitais is
    Port ( a1, a0, b1, b0 : in STD_LOGIC;
           a_igual_b : out STD_LOGIC;
           a_maior_b : out STD_LOGIC;
           a_menor_b : out STD_LOGIC
         );
end Sistemas_digitais;

architecture Structural of Sistemas_digitais is

    -- Declaração dos componentes
    component Vhdl4
        Port ( a1, a0, b1, b0 : in STD_LOGIC;
               resultado : out STD_LOGIC );
    end component;

    component Vhdl2
        Port ( a1, a0, b1, b0 : in STD_LOGIC;
               resultado : out STD_LOGIC );
    end component;

    component Vhdl3
        Port ( a1, a0, b1, b0 : in STD_LOGIC;
               resultado : out STD_LOGIC );
    end component;

begin
    U1: Vhdl4 port map (a1 => a1, a0 => a0, b1 => b1, b0 => b0, resultado => a_igual_b);
    U2: Vhdl2 port map (a1 => a1, a0 => a0, b1 => b1, b0 => b0, resultado => a_maior_b);
    U3: Vhdl3 port map (a1 => a1, a0 => a0, b1 => b1, b0 => b0, resultado => a_menor_b);

end Structural;
