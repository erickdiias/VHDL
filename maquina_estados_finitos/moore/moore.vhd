-- MOORE
--
-- Autor: Erick S. Dias
-- Data: 04/12/24

library ieee;
use ieee.std_logic_1164.all;

entity moore is
    port(
        clk, reset, W : in std_logic;
        Z             : out std_logic
    );
end entity;

architecture comportamento of moore is
    type estado is (A, B, C);
    signal estado_atual   : estado;
    signal proximo_estado : estado;
begin
    -- Processo para definição do sincronismo da FSM
    sincrono : process(clk, reset)
    begin
        
        if (reset = '1') then
            estado_atual <= A;
        elsif (rising_edge(clk)) then
            estado_atual <= proximo_estado;
        end if;
    end process sincrono;

    -- Processo para logica combinacional da máquina
    combinacional : process(estado_atual, W)
    begin
        -- Comportamento da saída
        Z <= '0';
        case(estado_atual) is
            when A => 
                Z <= '0';
                if (W = '1') then
                    proximo_estado <= B;
                else
                    proximo_estado <= A;
                end if;

            when B =>
                Z <= '0';
                if (W = '1') then
                    proximo_estado <= C;
                else
                    proximo_estado <= A;
                end if;
                
            when C =>
                Z <= '1';
                if (W = '1') then
                    proximo_estado <= C;
                else
                    proximo_estado <= A;
                end if;
        end case;
    end process combinacional; 
end architecture;