-- Submissão do arquivo VHDL de um Latch SR com NAND
-- Atividade prática
-- Autor: Erick S. Dias (157491)
-- Data: 22/11/2024

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LATCH_SR_NAND is
    port (
        set, reset : in std_logic; -- Entradas
        q, q_bar   : out std_logic -- Saídas
    );
end entity;

architecture main of LATCH_SR_NAND is
    signal sel : std_logic_vector(1 downto 0);
begin
    
    sel <= set & reset;

    q <=    '0' when sel = "10" else    -- LIMPAR ou RESETAR o latch (S = 1, R = 0)
            '1' when sel = "01" else    -- SETAR o latch             (S = 0, R = 1)
             q  when sel = "11" else    -- Mantém o estado anterior  (S = 1, R = 1)
            'U';                        -- Estado indefinido         (S = 0, R = 0)

    q_bar <= not q;

end architecture;
