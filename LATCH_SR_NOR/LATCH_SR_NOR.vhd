-- Submissão do arquivo VHDL de um Latch SR com NOR
-- Atividade prática
-- Autor: Erick S. Dias (157491)
-- Data: 22/11/2024

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LATCH_SR_NOR is
    port (
        set, reset : in std_logic; -- Entradas
        q, q_bar   : out std_logic -- Saídas
    );
end entity;

architecture main of LATCH_SR_NOR is
    signal sel : std_logic_vector(1 downto 0);
begin
    
    sel <= set & reset;

    q <=    '1' when sel = "10" else    -- (S = 1, R = 0)
            '0' when sel = "01" else    -- (S = 0, R = 1)
             q  when sel = "00" else    -- Mantém o estado anterior  (S = 0, R = 0)
            'U';                        -- Estado indefinido (S = 1, R = 1)

    q_bar <= not q;

end architecture;
